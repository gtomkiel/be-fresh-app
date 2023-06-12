import network
import socket
from time import sleep
import upip
from umqtt.simple import MQTTClient


ssid = "Galaxy M310830"
password = "hlgz1105"

def wConnect():
    #Connect to WLAN
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)
    wlan.connect(ssid, password)
    
    while wlan.isconnected() == False:
        print("Waiting for connection")
        sleep(1)
    ip = wlan.ifconfig()[0]
    print(f'Connected on {ip}')
    #return ip

def connectMQTT():
    
    client = MQTTClient(client_id="My_raspberry_Pi_pico_W",
                        server="1c4a0f81cee94b2e886cd9d1d2202b27.s2.eu.hivemq.cloud", #MQTT broker address
                        port=0,
                        user="AOlagoke",	#MQTT username IT-1B
                        password="2345Bzx!!", #MQTT password user_1234
                        keepalive=7200,
                        ssl=True,
                        ssl_params={'server_hostname': '1c4a0f81cee94b2e886cd9d1d2202b27.s2.eu.hivemq.cloud'}
                        )
    client.connect()
    return client

def publish(topic, value):
    print(topic)
    print(value)
    client.publish(topic,value)
    print("publish Done")

try:
    wConnect()
    client = connectMQTT()
    
    publish("Dark", "qwertyuioppppp")
except KeyboardInterrupt:
    machine.reset()