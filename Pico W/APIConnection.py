from machine import Pin,UART
import time
import network
import urequests
import ujson
from time import sleep

uart = UART(0, baudrate=9600, tx=Pin(0), rx=Pin(1))
uart.init(bits=8, parity=None, stop=1)

print(uart)

API_KEY= "npuhqctdgtlsjx45h6rma6c6b44y6c"

def apiConnect():
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
            
            API_ENDPOINT= "https://api.barcodelookup.com/v3/products?formatted=y&key=npuhqctdgtlsjx45h6rma6c6b44y6c&barcode=" + barcode
            print(barcode)
            print(API_ENDPOINT)

            url = "https://api.barcodelookup.com/v3/products?formatted=y&key=npuhqctdgtlsjx45h6rma6c6b44y6c&barcode={}".format(barcode)
            response = urequests.get(API_ENDPOINT)
            print(type(barcode))
            print(barcode)
            print(response.status_code)
            sleep(1)
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
            
