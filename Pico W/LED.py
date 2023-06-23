from picozero import RGBLED
from time import sleep

rgb = RGBLED(red = 3, green = 4, blue = 5)


def pinkRGB():
    rgb.color = (255,0,255)	#Pink
    sleep(0.3)
    
def blueRGB():
    rgb.color = (0, 0, 255)	#None
    sleep(0.3)
    
def amberRGB():
    rgb.color = (255,165,0) #Orange
    sleep(0.3)
    
def violetRGB():
    rgb.color = (128, 0, 32) #Violet
    sleep(0.3)
    
def redRGB():
    rgb.color = (255, 0, 0)	#Red
    sleep(0.6)

def greenRGB():
    rgb.color = (0, 255, 0) #Green
    sleep(0.6)
