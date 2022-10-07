
from reed import Meter
import pico_time


def persist_meter(meter: Meter):
    with open('persistence.txt', 'a') as f:
        f.write(f'{meter.value},{pico_time.current_time_ms()},{pico_time.local_time()}\n')
        