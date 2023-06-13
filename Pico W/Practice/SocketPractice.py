import network
import socket
from time import sleep
from picozero import pico_temp_sensor, pico_led
import machine

import socket
import sys

#ssid= "Spott 5GHz"
#password="Spott@2020!"
ssid = "Galaxy M310830"
password = "hlgz1105"



#server_address = ("192.168.0.52", 8050)
#print('starting up on %s port %s' % server_address)
#sock.bind(server_address)

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

while True:
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)
    wlan.connect(ssid, password)x
    while wlan.isconnected() == False:
        print("Waiting for connection")
        sleep(1)
    ip = wlan.ifconfig()[0]
    print(f'Connected on {ip}')
    server_address = (ip, 80)    
    print('starting up on %s port %s' % server_address)
    sock.bind(server_address)
    sock.listen(1)
    #print('waiting for a connection')
    connection, client_address = sock.accept()
    try:
        print('connection from', client_address)

    finally:
        connection.close()