from machine import pyb

try:
    led = pyb.LED(2)
    while True:
        led.toggle()
        pyb.delay(1000)
except:
    pass