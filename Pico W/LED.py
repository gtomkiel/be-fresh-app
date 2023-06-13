from picozero import RGBLED
from time import sleep

rgb = RGBLED(red = 3, green = 4, blue = 5)


def redRGB:
    rgb.color = (255, 0, 0)	#Red
    
def amberRGB:
    rgb.color = (255,191,0) #Amber
    
def greenRGB:
    rgb.color = (0, 255, 0) #Green
