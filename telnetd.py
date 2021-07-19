#!/usr/bin/env python3
from datetime import datetime
import socket
import requests
import asyncio
import pyyoutube 

# YouTube API key
ytapi = pyyoutube.Api(api_key='***************')

# Your Channel
channel = ytapi.get_channel_info(channel_id="UC***************")

def getweather():
    # openweathermap API key
    key = "********************"
    location = "Calgary"
    weather_url = "http://api.openweathermap.org/data/2.5/weather?q=%s&APPID=%s&units=metric" % (location, key)
    weather_data = requests.get(weather_url).json()
    weather = weather_data['weather'][0]['main']
    print(weather)
    return("The weather in %s is %s %dc\n\r" % (location, weather, int(weather_data['main']['temp'])))


server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.setblocking(False)

print(    server.bind(("", 6464)) )

server.listen(256)

connections = []

getweather()

while True:
    try:
        connection, address = server.accept()
        print("Incoming connection from ", address)
        connection.send(b"CONNECTED\n\r")

        connection.setblocking(False)
        connections.append(connection)
    except BlockingIOError:
        pass

    for connection in connections:
        try:
            message = connection.recv(4096)
        except BlockingIOError:
            continue

        message=message.strip().decode('ascii')
        print("\n\r>",message)

        if message=="D":            
            now = datetime.now()
            current_date = now.strftime("%Y-%m-%d")
            print("\n\rCurrent Date =", current_date)
            connection.send( bytes("\n\r"+current_date + "\n\r",'ascii') )

        elif message=="T":
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            print("\n\rCurrent Time =", current_time)
            connection.send( bytes("\n\r"+current_time + "\n\r",'ascii') )

        elif message=="W":
            current_weather=getweather()
            connection.send( bytes("\n\r"+current_weather.upper() + "\n\r",'ascii') )
        
        elif message=='S':
            subs=str(channel.items[0].to_dict()['statistics']['subscriberCount']) 
            print( subs )
            connection.send( bytes("\n\r" + subs + "\n\r",'ascii') )

        elif message=='V':
            views=str(channel.items[0].to_dict()['statistics']['viewCount']) 
            print( views )
            connection.send( bytes("\n\r" + views + "\n\r",'ascii') )

