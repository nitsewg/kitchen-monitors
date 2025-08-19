import adafruit_dht
from datetime import datetime
import smtplib
import board
import csv
import RPi.GPIO as GPIO
import time

with open('/home/pi/kitchen-monitors/info.csv') as csv_file:
    read_csv = csv.reader(csv_file, delimiter=',')
    for row in read_csv:
        threshold = row[0]
        device_name = row[1]
        email_address = row[2]

# Get current date and time

now = datetime.now()
current = now.strftime("%Y-%m-%d %H:%M:%S")

#Set data pin

dht_device = adafruit_dht.DHT22(board.D4)

#Set GPIO 17 for power

GPIO.setmode(GPIO.BCM)
#GPIO.setwarnings(False)
GPIO.setup(17,GPIO.OUT)
GPIO.output(17,GPIO.HIGH)
time.sleep(2)
temp = ''


try:
    temperature_c = dht_device.temperature
except:
    time.sleep(2)
    temperature_c = dht_device.temperature

time.sleep(2)

GPIO.output(17,GPIO.LOW)

#Convert temp

temp = temperature_c * (9 / 5) + 32

#Set smtp info

sender = f'{device_name}@monettschools.org'
receivers = f'{email_address}'
message = f"""Subject: ***{device_name} Temp Alert***

The {device_name} temp is currently {temp} F, exceeding the threshold of {threshold}

Current date / time: {current}
"""

# print('Temp={0:0.1f}*C  Humidity={1:0.1f}%'.format(t,h))


if temp > int(threshold):
    try:
        smtpObj = smtplib.SMTP('192.168.30.69')
        smtpObj.sendmail(sender, receivers, message)  
    except:
        print("unable to send email.")
else:
    print("Temperature is currently %d" % temp )