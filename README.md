# c64wifi2024
ESP8266 WiFi for C64 **WITH SSL** that compiles without errors

### Updated in 2024 to allow https as well as plain http GET

![c64-esp8266-wifi 007](https://user-images.githubusercontent.com/3143825/126214417-67539717-4127-490d-b01c-4b847225f335.jpeg)

[C64 WiFi Tutorial and more details here](https://retrogamecoders.com/commodore-64-wifi-esp8266/)

Starts in 300 baud

at? to get help

## AT COMMAND SUMMARY:

```
DIAL HOST.....: ATDTHOST:PORT
SPEED DIAL....: ATDSN (N=0-9)
SET SPEED DIAL: AT&ZN=HOST:PORT (N=0-9)
HANDLE TELNET.: ATNETN (N=0,1)
PET MCTERM TR.: ATPETN (N=0,1)
NETWORK INFO..: ATI
HTTP GET......: ATGET<URL>
AUTO ANSWER...: ATS0=N (N=0,1)
SET BUSY MSG..: AT$BM=YOUR BUSY MESSAGE
LOAD NVRAM....: ATZ
SAVE TO NVRAM.: AT&W
SHOW SETTINGS.: AT&V
FACT. DEFAULTS: AT&F
PIN POLARITY..: AT&PN (N=0/INV,1/NORM)
ECHO OFF/ON...: ATE0 / ATE1
VERBOSE OFF/ON: ATV0 / ATV1
SET SSID......: AT$SSID=WIFISSID
SET PASSWORD..: AT$PASS=WIFIPASSWORD
SET BAUD RATE.: AT$SB=N
FLOW CONTROL..: AT&KN (N=0/N,1/HW,2/SW)
WIFI OFF/ON...: ATC0 / ATC1
HANGUP........: ATH
ENTER CMD MODE: +++
EXIT CMD MODE.: ATO
```
