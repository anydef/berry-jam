import uasyncio as asyncio


class Meter(object):
    def __init__(self):
        self.__counter = 0
        self.mutex = asyncio.Lock()

    async def inc(self, count=1):
        await self.mutex.acquire()
        self.__counter = self.__counter + count
        self.mutex.release()

    async def reset(self, new_value=0):
        await self.mutex.acquire()
        self.__counter = new_value
        self.mutex.release()

    @property
    def value(self):
        return self.__counter


class AsyncPin:

    def __init__(self, pin, trigger):
        self.pin = pin
        self.flag = asyncio.ThreadSafeFlag()
        self.pin.irq(lambda pin: self.callback(pin), trigger, hard=False)

    def callback(self, pin):
        self.flag.set()

    def value(self):
        return self.pin.value()

    async def wait_edge(self):
        await self.flag.wait()


async def do_on_event(event, *tasks):
    while True:
        await event.wait()
        for t in tasks:
            await t[0](*t[1:])
        event.clear()
