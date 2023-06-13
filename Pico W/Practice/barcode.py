from machine import Pin,UART
import time
import network
import urequests as request
import ujson
import time
#from WiFiConnect import wConnect

uart = UART(0, baudrate=9600, tx=Pin(0), rx=Pin(1))
uart.init(bits=8, parity=None, stop=1)

print(uart)

API_KEY= "f5tyxo0dbzw2fcfqn6hqvm9uehp4s2"
API_ENDPOINT= "https://api.barcodelookup.com/v3/products?formatted=y&key=" + API_KEY + "&barcode="

#wConnect()
ssid = "Galaxy M310830"
password = "hlgz1105"
print('wconnect')
def wConnect():
    #Connect to WLAN
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)
    wlan.connect(ssid, password)
    while wlan.isconnected() == False:
        print("Waiting for connection")
        time.sleep(1)
    ip = wlan.ifconfig()[0]
    print(f'Connected on {ip}')
    #return ip
    while True:
        if uart.any() != 0:
            data = uart.read()
            barcode = str(data.decode('UTF-8'))  # Decode the bytes to a string
            barcode = data.decode('UTF-8')
            print(type(barcode))