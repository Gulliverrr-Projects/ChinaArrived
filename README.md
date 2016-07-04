# ChinaArrived
I tend to get loads of little jiffy bags every other day delivered at work from my beloved Chinese eBay sellers for 0.99GBP. To save my colleagues from skyping/calling/walking over my desk just to let me know I got mail, I made this IoT gadget that saves them the trouble and keep me notified without moving away from my desk.

It is a set of two parts. One is a box with a switch on the bottom. Whenever you put any (jiffy bag) in it, the button is pressed. The box is located where the mailman comes in.
The other part is a tiny USB powered alert thingie with an LED and is located at my desk (powered directly from my monitor's USB port)

Both parts are connected to my works WiFi and speak to a thingspeak.com server. Once you place anything in the box (downstairs), the LED on my desk lights up. Once I remove the item from the box, the LED turns off. Simple as that.

I use an ESP8266-01 on each side with NodeMCU as standalone without an arduino or anything else. Each side has an LM7803 voltage regulator, a filtering capacitor on the power line and an LED. The box is powered from mains with a power pack (5V, 1A) and has a feedback LED that shows if the box is loaded or not (in case the bottom flap gets stuck pressed even after removing the item). The alert has a USB male plug for power and a 3mm LED for alerting me.

The best part is that the whole project was done in a night and it cost less than 5GBP by reusing the box, the power pack, the LEDs, caps and resistors (for the LED), the terminal switch and USB cable that was marked as dead for a cut data line.
Each circuit is self explanatory so can't be bothered to provide schematics. I use GPIO2 in both ESPs. If you can't follow, ask me.
