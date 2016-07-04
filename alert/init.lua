--ALERT MODULE
--init.lua
pin=4
gpio.mode(pin,gpio.OUTPUT)
print("Setting up WIFI...")
wifi.setmode(wifi.STATION)
--modify according your wireless router settings
wifi.sta.config("SSID","PASSWORD")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function()
if wifi.sta.getip()== nil then
print("IP unavaiable, Waiting...")
else
tmr.stop(1)
print("Config done, IP is "..wifi.sta.getip())
--first read now
readThingspeak()
-- and then every 5 minutes
tmr.alarm(0, 300000, 1, function() readThingspeak() end)
end
end)

function readThingspeak()
conn = nil
conn = net.createConnection(net.TCP, 0)
conn:on("receive", function(conn, payload)success = true updateGPIO(payload) end) --send and deep sleep
conn:on("connection",
   function(conn, payload)
      print("Connected TS")
      conn:send('GET /channels/YOURID/fields/1/last?key=YOURKEY'..'HTTP/1.1\r\n\
      Host: api.thingspeak.com\r\nAccept: */*\r\nUser-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n\r\n')
   end)
conn:on("disconnection", function(conn, payload) print('Disconnected') end)
conn:connect(80,'184.106.153.149')
end

function updateGPIO(payload)
if payload=="1" then
print("payload:"..payload..", HIGH")
gpio.write(pin,gpio.LOW)
else
print("payload:"..payload..", LOW")
gpio.write(pin,gpio.HIGH)
end
end
