--BOX MODULE
--init.lua
--GPIO2 : ID4
pin=4
print("----Setting GPIO2 (ID 4) as INPUT...----")
gpio.mode(pin, gpio.INPUT, gpio.PULLUP)

--gpio.trig(pin,"both",function() dofile("publishGPIO.lua") end)
gpio.trig(pin,"both",function() 
dofile("publishGPIO.lua")
end)

print("Setting up WIFI...")
wifi.setmode(wifi.STATION)
--modify according your wireless router settings
wifi.sta.config("SSID","YOURPASSWORD")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function()
if wifi.sta.getip()== nil then
print("IP unavaiable, Waiting...")
else
tmr.stop(1)
print("Config done, IP is "..wifi.sta.getip())
print("Initialising thinkspeak...")
dofile("publishGPIO.lua")
end
end)
