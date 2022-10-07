import uasyncio as asyncio
from machine import Pin
from uasyncio import Event

import boot
import meter_counter
import persistence
import pushgateway_client
import webserver_async as webserver
from reed import AsyncPin, Meter, do_on_event

print("Booting up.")

onboard_led = Pin("LED", Pin.OUT)
onboard_led.off()

meter_led = Pin(15, Pin.OUT)
meter_led.off()

reed_pin = AsyncPin(Pin(14, Pin.IN, Pin.PULL_DOWN), Pin.IRQ_RISING)

reed_event = Event()
reed_counter = Meter()
reed_m3_counter = Meter()


async def receive_value(async_pin, event):
    while True:
        await async_pin.wait_edge()
        if async_pin.value() == 1:
            event.set()
            await reed_counter.inc()
            await reed_m3_counter.inc()

            pushgateway_client.send_gas_meter_total(reed_counter.value)
            pushgateway_client.send_gas_meter_count(1)


async def send_m3_metric(meter: Meter):
    if meter.value >= 100:  # counting m3. 1imp = 0.01m3.
        await meter.reset()
        pushgateway_client.send_gas_meter_count_m3(1)


async def heartbeat(led, delay):
    while True:
        led.on()
        await asyncio.sleep(0.25)
        led.off()
        await asyncio.sleep(delay)


async def heartbeat_metric(delay):
    while True:
        await asyncio.sleep(delay)
        pushgateway_client.send_heartbeat()


async def flush_meter(meter, delay):
    while True:
        persistence.persist_meter(meter)
        await asyncio.sleep(delay)


async def main():
    boot.init()
    # start webserver
    asyncio.create_task(asyncio.start_server(
        webserver.create_server(reed_counter=reed_counter), "0.0.0.0", 80))

    # listen to reed pin irq events
    asyncio.create_task(receive_value(reed_pin, reed_event))

    asyncio.create_task(do_on_event(reed_event,
                                    (meter_counter.blink, meter_led),
                                    (send_m3_metric, reed_m3_counter),
                                    )
                        )
    # send heartbeat metric every minute.
    # this is required since gas meter might be idling,
    # and monitoring system will not be able to recognize whether the module is running.
    asyncio.create_task(heartbeat_metric(60))

    # flush meter status every hour into the file.
    asyncio.create_task(flush_meter(reed_counter, 3600))

    # onboard led heartbeat. this loop keeps event loop intact.
    await heartbeat(onboard_led, 5)


try:
    asyncio.run(main())
finally:
    asyncio.new_event_loop()
