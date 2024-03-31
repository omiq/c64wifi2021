rem The WiFi adapter defaults to 300 baud but use serial 1200,8n1 - AT$SB=1200
rem open the serial from user port
open2,2,4,chr$(8)+chr$(0)
get#2,s$: print#2,""
gosub response:
print#2,"AT$SSID=YOUR_WIFI_NAME" + chr$(10) + chr$(13)
gosub response:
print#2,"AT$PASS=WIFI_PASSWORD" + chr$(10) + chr$(13)
gosub response:
print#2,"ATC1" + chr$(10) + chr$(13)
gosub response:


main:
print "{clear}{white}wled"
print "select 1, 2 or 3"
selection:
get i$: if i$ = "" goto selection:
if i$="1" then print#2,"http://192.168.0.102/win&A=64&PL=1"  + chr$(10) + chr$(13): rem my scrolling message
if i$="2" then print#2,"http://192.168.0.102/win&A=64&PL=2"  + chr$(10) + chr$(13): rem 
if i$="3" then print#2,"http://192.168.0.102/win&A=64&PL=3"  + chr$(10) + chr$(13): rem 
gosub response: rem get the response
goto main: rem loop back to start of the main loop again

response:
rem get the response until nothing waiting
 get#2,s$: print s$;:rem print these bytes
 if s$<>"" then goto response:rem keep going until no bytes waiting
 for w=1 to 2000:next
 return
 rem ---------------------------------
 close 2:end