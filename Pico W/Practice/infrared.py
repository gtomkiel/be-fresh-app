from machine import ADC, Pin
import time

adc = ADC(Pin(28))

# Calibration data
m = 0.1  # Slope
b = 5.0  # Intercept

while True:
    adc_value = adc.read_u16()
    voltage = adc_value * 3.3 / (2 ** 16)  # Convert ADC value to voltage (assuming 3.3V reference voltage)
    distance = m * voltage + b  # Convert voltage to distance using the calibration equation
    print("Distance:", distance)
    time.sleep(2)