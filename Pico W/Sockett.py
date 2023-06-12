import network
import socket
from time import sleep
from picozero import pico_temp_sensor, pico_led
import machine
from WiFiConnect import wConnect

import socket
import sys

ssid = "Galaxy M310830"
password = "hlgz1105"

#ssid= "Spott 5GHz"
#password="Spott@2020!"

#Connect to WLAN
wlan = network.WLAN(network.STA_IF)
wlan.active(True)
wlan.connect(ssid, password)
while wlan.isconnected() == False:
    print("Waiting for connection")
    sleep(1)
ip = wlan.ifconfig()[0]
print(f'Connected on {ip}')

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server_address = (ip, 857)
print(sys.stderr, 'starting up on %s port %s' % server_address)
sock.bind(server_address)

sock.listen(1)

while True:
    print(sys.stderr, 'waiting for a connection')
    connection, client_address = sock.accept()
    try:
        print(sys.stderr, 'connection from', client_address)

        data = connection.recv(1024).decode()
        if "startBarcode" in data:
            print("yeaaaa connec")
            sleep(3)
            ini_name = wConnect()
            fin_name = ''
            if ',' in ini_name:
                str_name = ini_name.split(",")
                fin_name = str_name[0] + str_name[1]
            else:
                fin_name = ini_name
            response = "HTTP/1.1 200 OK\r\nContent-Length: {}\r\n\r\n{}".format(len(fin_name), fin_name)
            
            connection.sendall(response.encode("utf-8"))
            print("send")
            connection.close()
            break
    finally:
        connection.close()