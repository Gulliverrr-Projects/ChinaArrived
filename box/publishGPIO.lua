--- Read GPIO and send data to thingspeak.com
pinstate = -1
notpinstate = -1
pinstate = gpio.read(pin)
if pinstate==1 then notpinstate=0 end
if pinstate==0 then notpinstate=1 end
--print("Reading PIN.")
print("PIN"..pin..":"..pinstate..".")
--print(gpio.read(pin))

-- conection to thingspeak.com
print("Sending data to thingspeak.com")
conn=net.createConnection(net.TCP, 0) 
conn:on("receive", function(conn, payload) print(payload) end)
-- api.thingspeak.com 184.106.153.149
conn:connect(80,"184.106.153.149") 
conn:send("GET /update?key=YOURKEY&field1="..notpinstate.." HTTP/1.1\r\n") 
conn:send("Host: api.thingspeak.com\r\n") 
conn:send("Accept: */*\r\n") 
conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
conn:send("\r\n")
conn:on("sent",function(conn)
                      print("Closing connection")
                      conn:close()
                  end)
conn:on("disconnection", function(conn)
                                print("Got disconnection...")
                                readThingspeak()
  end)


function readThingspeak()
conn2 = nil
conn2 = net.createConnection(net.TCP, 0)
conn2:on("receive", function(conn2, payload)success = true updateGPIO(payload) end) --send and deep sleep
conn2:on("connection",
   function(conn2, payload)
      print("Reading value from thingspeak")
      conn2:send('GET /channels/YOURID/fields/1/last?key=YOURKEY'..'HTTP/1.1\r\n\
      Host: api.thingspeak.com\r\nAccept: */*\r\nUser-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n\r\n')
   end)
conn2:on("disconnection", function(conn2, payload) print('Disconnected') end)
conn2:connect(80,'184.106.153.149')
end

function updateGPIO(payload)
print("Checking in 5 sec...")
tmr.delay(5000000)
pinstate = gpio.read(pin)
if pinstate==1 then notpinstate=0 end
if pinstate==0 then notpinstate=1 end
if tonumber(payload)==notpinstate then
print("MATCH payload:"..payload..", notpinstate:"..notpinstate..".")
else
print("***MISSMATCH payload:"..payload..", notpinstate:"..notpinstate..".***")
print("Restarting...")
node.restart()end
end
