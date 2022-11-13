---
layout: post
title:  "Setup Micropython on ESP8266"
date:   2022-10-02 20:20:17 +0200
categories: [coding, python]
tags: [micropython,NodeMCU, ESP8266, ESP32]

---
# Python on MicroControllers
This serves as my todo list on setting up MicroPython on ESP 8266 and ESP 32 micro controllers.

1. Identify your Chip
```shell
❯ esptool.py --port /dev/tty.usbserial-140 flash_id
esptool.py v2.8
Serial port /dev/tty.usbserial-140
Connecting....
Detecting chip type... ESP8266
Chip is ESP8266EX
Features: WiFi
Crystal is 26MHz
MAC: a0:20:a6:17:52:a5
Uploading stub...
Running stub...
Stub running...
Manufacturer: e0
Device: 4016
Detected flash size: 4MB
Hard resetting via RTS pin...
```
The `Detected flash size: 4MB` indicates we can use the latest regular [MicroPython image](https://micropython.org/resources/firmware/esp8266-20220618-v1.19.1.bin).   

2. Erase flash memory
```shell
❯ esptool.py --port /dev/tty.usbserial-140 erase_flash
esptool.py v2.8
Serial port /dev/tty.usbserial-140
Connecting....
Detecting chip type... ESP8266
Chip is ESP8266EX
Features: WiFi
Crystal is 26MHz
MAC: a0:20:a6:17:52:a5
Uploading stub...
Running stub...
Stub running...
Erasing flash (this may take a while)...
Chip erase completed successfully in 11.2s
Hard resetting via RTS pin...
```

2. Deploy MicroPython
```shell
❯ esptool.py --port /dev/tty.usbserial-140 --baud 460800 write_flash --flash_size=detect 0 ~/Downloads/esp8266-20220618-v1.19.1.bin
esptool.py v2.8
Serial port /dev/tty.usbserial-140
Connecting....
Detecting chip type... ESP8266
Chip is ESP8266EX
Features: WiFi
Crystal is 26MHz
MAC: a0:20:a6:17:52:a5
Uploading stub...
Running stub...
Stub running...
Changing baud rate to 460800
Changed.
Configuring flash size...
Auto-detected Flash size: 4MB
Flash params set to 0x0040
Compressed 634844 bytes to 419808...
Wrote 634844 bytes (419808 compressed) at 0x00000000 in 10.5 seconds (effective 485.9 kbit/s)...
Hash of data verified.
Leaving...
Hard resetting via RTS pin...
```

3. Enable Wifi and connect the MCU to your WLAN   
The default REPL is available via serial connection.   
We'll use this serial connection to setup WiFi.   
I use `screen` here - but any terminal emulator should do:
```shell
> screen /dev/tty.usbserial-140 115200
```

4. Press the return key until you see this:
```shell
>>> 
```

5. Configure WLAN access   
Replace `"<AP_name>"` and `"<password>"` with your values...      
```shell
>>> import network
>>> sta_if = network.WLAN(network.STA_IF);
>>> sta_if.active(True)
>>> sta_if.connect("<AP_name>", "<password>")
>>> sta.if.isconnected()
```
The last statement should return `True`.

6. Lets find out the device IP:
```shell
>>> sta_if.isconnected()
True
>>> print(sta_if.ifconfig())
('192.168.178.66', '255.255.255.0', '192.168.178.1', '192.168.178.1')
```


7. Enable WebRepl   
Once the Board joined your network it's time to [use the webrepl](git@github.com:micropython/webrepl.git).
```shell
>>> import webrepl_setup
WebREPL daemon auto-start status: disabled
Would you like to (E)nable or (D)isable it running on boot?
(Empty line to quit)
> e
To enable WebREPL, you must set password for it
New password (4-9 chars): itzelbritzel
Confirm password: itzelbritzel
Changes will be activated after reboot
Would you like to reboot now? (y/n) y
```
Answering `y` to the last question leads to somethong to this:    
```shell
Would you like to reboot now? (y/n) y
>>>
 ets Jan  8 2013,rst cause:2, boot mode:(3,3)
load 0x40100000, len 30720, room 16
tail 0
chksum 0xba
load 0x3ffe8000, len 996, room 8
tail 12
chksum 0x2c
ho 0 tail 12 room 4
load 0x3ffe83f0, len 1080, room 12
tail 12
chksum 0x43
csum 0x43
����'�{��o<�l$ld`c��|s�d�g��'�d`��r�$�d�l`��s�l�l�l`��;�d���l$`rdǃ;$ğ�#Č#|dc��#<��Č$lb��o�g��lo���$�$l���l`�'����cld쌏c���cl�#{$sdr�g����b���l��l���d���l�c��'�߀�#���$�$���d���WebREPL daemon started on ws://192.168.4.1:8266
WebREPL daemon started on ws://0.0.0.0:8266
Started webrepl in normal mode
MicroPython v1.19.1 on 2022-06-18; ESP module with ESP8266
Type "help()" for more information.
```
Verify Micropython persisted your WiFi credentials:
```shell
...
MicroPython v1.19.1 on 2022-06-18; ESP module with ESP8266
Type "help()" for more information.
>>> import network
>>> sta_if = network.WLAN(network.STA_IF)
>>> sta_if.isconnected()
True
>>> sta_if.ifconfig()
('192.168.178.66', '255.255.255.0', '192.168.178.1', '192.168.178.1')
```
Since WebREPl uses websockets you need to use the WebRepl Client. I recommend [cloning it from GitHub](https://github.com/micropython/webrepl) and run it on you local machine.
Just open `webrepl.html` in your brower.
> Ensure to use either `file:` protocol or `http:`.

We're done :-)

> In case of trouble please have a look at [the excellent documentation here](http://docs.micropython.org/en/latest/esp8266/quickref.html#networking)


The webrepl repo contains a a neat tool to copy files to/from the MCU:
```shell
❯ webrepl_cli.py -p itzelbritzel awesome-app.py 192.168.178.66:/awesome-app.py
op:put, host:192.168.178.66, port:8266, passwd:itzelbritzel.
awesome-app.py -> /awesome-app.py
Remote WebREPL version: (1, 19, 1)
Sent 895 of 895 bytes
```
A great alternative to using the webpage. (see `webrepl_cli.py --help` for details)

