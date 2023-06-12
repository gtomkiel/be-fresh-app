import network
import socket
from time import sleep
from picozero import pico_temp_sensor, pico_led
import machine

#ssid = 'Ziggo6247314'
#password = 'P7asfywe2uet'

ssid = "Galaxy M310830"
password = "hlgz1105"
def connect():
    #Connect to WLAN
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)
    wlan.connect(ssid, password)
    while wlan.isconnected() == False:
        print("Waiting for connection")
        sleep(1)
    ip = wlan.ifconfig()[0]
    print(f'Connected on {ip}')
    return ip

def open_socket(ip):
    #Open a socket
    address = (ip, 80)
    connection = socket.socket()
    connection.bind(address)
    connection.listen(1)
    return connection
    
def webpage(temperature,state):
    #Template HTML
    html = f"""
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Document</title>
            </head>
            <body>
                <header>

                </header>

                <main>

                    <form action="./lighton">
            
                        <input type="submit" value="Light On">
                    </form>

                    <form action="./lightoff">

                        <input type="submit" value="Light Off">
                    </form>

                    <p>LED is {state}</p>
                    <p>Temperature is {temperature}</p>
                </main>

                <footer>

                </footer>
            </body>
        </html>
    """
    return str(html)

def serve(connection):
    #Start a web server
    state = "OFF"
    pico_led.off()
    temperature = 0
    #print("Debug 77")
    #To keep webserver running
    while True:
        client = connection.accept()[0]
        reque = client.recv(1024)
        request = str(reque)
        #print(request)
        print("Approached by a client")
        try:
            request = request.split()[1]
        except IndexError:
            pass
        if request == '/lighton?':
            pico_led.on()
            state = 'ON'
        elif request == '/lightoff?':
            pico_led.off()
            state = 'OFF'
        temperature = pico_temp_sensor.temp
        
        html = webpage(temperature, state)
        client.send(html)   					#Send client webpage
        client.close()

try:
    ip = connect()
    connection = open_socket(ip)
    serve(connection)
except KeyboardInterrupt:
    machine.reset()
    