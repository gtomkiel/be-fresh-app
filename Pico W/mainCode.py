from machine import Pin,UART
import time
import network
import urequests as requests
import ujson
#from WiFiConnect import wConnect

uart = UART(0, baudrate=9600, tx=Pin(0), rx=Pin(1))
uart.init(bits=8, parity=None, stop=1)

print(uart)

API_KEY= "4olvq39adf9wmwiqpedcnl0grqwnxe"
API_ENDPOINT= "https://api.barcodelookup.com/v3/products?formatted=y&key=" + API_KEY + "&barcode="

#wConnect()
ssid = "Galaxy M310830"
password = "hlgz1105"
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
        #if uart.any() != 0:
            #data = uart.read()
            #barcode = data.decode('utf-8')  # Decode the bytes to a string
            #print("Raw barcode:", barcode)
            
            barcode = str(738759970526)
            
            params = {
                "barcode": barcode,
                "apiKey": API_KEY
            }
        
            url = API_ENDPOINT + barcode
            print (url)
            response = requests.get(url)
            # response = requests.request("GET", API_ENDPOINT, data=ujson.dump(params))
        
            if response.status_code == 200:
                product_info = response.json()
                print (product_info["products"][0]["title"])
                #print("Product name:", product_info['name'])
            else:
                print("Error: API request failed with status code", response.status_code)
                print(response.text)
            # Display or use the product information as needed
       #print(res + ' is result')
       #res.strip("b'")
       #print(res)

try:
    wConnect() 
except KeyboardInterrupt:
    machine.reset()
