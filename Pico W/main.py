import network
import socket
from time import sleep
from picozero import pico_temp_sensor, pico_led
import machine
from APIConnection import apiConnect
from Led import pinkRGB, violetRGB, redRGB, amberRGB, greenRGB, blueRGB
import socket
import sys

ssid = "Galaxy M310830"
password = "hlgz1105"
#Connect to WLAN
wlan = network.WLAN(network.STA_IF)
wlan.active(True)
wlan.connect(ssid, password)
while wlan.isconnected() == False:
    print("Waiting for connection")
    sleep(1)
ip = wlan.ifconfig()[0]
print(f'Connected on {ip}')
pinkRGB()
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server_address = (ip, 145)
print(sys.stderr, 'starting up on %s port %s' % server_address)

sock.bind(server_address)

sock.listen(1)

while True:
    blueRGB()
    print(sys.stderr, 'waiting for a connection')
    connection, client_address = sock.accept()
    try:
        print(sys.stderr, 'connection from', client_address)
        amberRGB()
        data = connection.recv(1024).decode()
        
        if "startBarcode" in data:
            violetRGB()
            print("yeaaaa connec")
            ini_name = apiConnect()
            print(ini_name)
            
            if "API request failed" in ini_name: 
                redRGB()
                error = "404Error"
                response = "HTTP/1.1 200 OK\r\nContent-Length: \r\n\r\n{}".format(error)
                connection.sendall(response.encode("utf-8"))
                continue
            elif "1234" in ini_name:			#If hotspot has no data
                redRGB()
                error = "no internet connection"
                response = "HTTP/1.1 200 OK\r\nContent-Length: \r\n\r\n{}".format(error)
                connection.sendall(response.encode("utf-8"))
            else:								#If successful
                fin_name = ''
                
                if ',' in ini_name:				#If product name has ' we split em to get the name without additional value
                    str_name = ini_name.split(",")
                    fin_name = str_name[0] + str_name[1]
                else:
                    fin_name = ini_name
                response = "HTTP/1.1 200 OK\r\nContent-Length: {}\r\n\r\n{}".format(len(fin_name), fin_name)
                greenRGB()
                connection.sendall(response.encode("utf-8"))
                continue
    except KeyError:
        redRGB()
        error = "404Error"
        response = "HTTP/1.1 200 OK\r\nContent-Length: \r\n\r\n{}".format(error)
        connection.sendall(response.encode("utf-8"))
        continue
        
            
    finally:
        connection.close()
        