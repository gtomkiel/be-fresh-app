from picozero import RGBLED
from time import sleep

rgb = RGBLED(red = 3, green = 4, blue = 5)

while True:
    try:
        #rgb.color = (255, 0, 0)	#Red
        rgb.color = (255,191,0)	#Amber
        #rgb.color = (255,255,0)	#Yellow	
        sleep(0.5)
        rgb.color = (0, 255, 0)	#Green
        sleep(0.5)
        #rgb.color = (0, 0, 255)
        #sleep(0.5)
    except KeyboardInterrupt:
        machine.reset()