from machine import Pin,UART
import time
import network
import urequests
import ujson
import time
#import uurlparse
#from WiFiConnect import wConnect

uart = UART(0, baudrate=9600, tx=Pin(0), rx=Pin(1))
uart.init(bits=8, parity=None, stop=1)

print(uart)

API_KEY= "npuhqctdgtlsjx45h6rma6c6b44y6c"

#wConnect()
ssid = "Galaxy M310830"
password = "hlgz1105"
def wConnect():
    #Connect to WLAN
    #wlan = network.WLAN(network.STA_IF)
    #wlan.active(True)
    #wlan.connect(ssid, password)
    #while wlan.isconnected() == False:
       # print("Waiting for connection")
        #time.sleep(1)
    #ip = wlan.ifconfig()[0]
    #print(f'Connected on {ip}')
    #return ip
    while True:
        if uart.any() != 0:
            data = uart.read()
            print(data)

            # Convert the byte string to a regular string
            string_data = str(data, 'utf-8')

            # Remove the 'b' prefix
            cleaned_data = str(data)[2:-1]

            # Remove the trailing newline character '\r'
            cleaned_data = string_data.rstrip('\r')
            barcode = cleaned_data  # Decode the bytes to a string

            print(type(barcode))
            
            API_ENDPOINT= "https://api.barcodelookup.com/v3/products?formatted=y&key=npuhqctdgtlsjx45h6rma6c6b44y6c&barcode=" + barcode
            print(barcode)
            print(API_ENDPOINT)
          
            url = API_ENDPOINT
            #parsed_url = uurlparse.urlparse(url)
            #query_params = uurlparse.parse_qs(parsed_url.query)
            #print(query_params.text)
            url = "https://api.barcodelookup.com/v3/products?formatted=y&key=npuhqctdgtlsjx45h6rma6c6b44y6c&barcode={}".format(barcode)
            print()
            print("-"*20)
            print (url)
            #time.sleep(5)
            response = urequests.get(API_ENDPOINT)
            print(type(barcode))
            print(barcode)
            print(response.status_code)
            # response = requests.request("GET", API_ENDPOINT, data=ujson.dump(params))
            time.sleep(1)
            if response.status_code == 200:
                dataa = response.json()
                result = dataa["products"][0]["title"].split(" - ")[0]
                print(result)
                output_data = {
                    "name": result,
                }
                print(data)
                with open("product.json", "w") as file:
                    ujson.dump(output_data, file)
                print("returning result...")
                return result
            else:
                print("Error: API request failed with status code", response.status_code)
                return "Error: API request failed with status code"
        # Display or use the product information as needed
       #print(res + ' is result')
       #res.strip("b'")
       #print(res)

#try:
 #   wConnect() 
#except KeyboardInterrupt:
 #   machine.reset()


