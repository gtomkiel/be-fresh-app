from machine import ADC, Pin
import time

adc = ADC(Pin(28))
#adc.width(ADC.WIDTH_11BIT)

while True:
    distance = adc.read_u16()
    print("Distance:", distance)
    #time.sleep(2)