#lowercase
POKE 53272,23
PRINT CHR$(5): PRINT CHR$(147): PRINT CHR$(19);: REM CLEAR SCREEN, WHITE TEXT
open2,2,4,chr$(8)+chr$(0):rem open the serial from user port

print "starting"
print#2,"at":gosub transmit

for i = 1 to 5
gosub response
NEXT

print "connecting to wifi"
print#2,"atc1":gosub transmit

for i = 1 to 5
gosub response
NEXT

show:
print "getting connection info"
print#2,"ati":gosub transmit

for i = 1 to 10
gosub response
next

showinstructs:
gosub instructions

selection:
u$="": i$="": get i$
if i$="1" then print "1 selected": u$="atgethttp://192.168.0.103/WIN&a=64&pl=1": gosub transmit
if i$="2" then print "2 selected": u$="atgethttp://192.168.0.103/WIN&a=64&pl=2": gosub transmit 
if i$="3" then print "3 selected": u$="atgethttp://192.168.0.103/WIN&a=64&pl=3": gosub transmit
if i$="4" then print "4 selected": u$="atgethttps://hook.eu2.make.com/AD3MIE2EHS5UUHJO3N630YUT9GUHIWJ1?message=c64+basic": gosub transmit
if i$="5" then print "5 selected": u$="atgetHTTPS://TIMEAPI.IO/API/TIMEZONE/ZONE?TIMEZONE=EUROPE/LONDON": gosub transmit


if i$ = "" then goto selection: rem loop back to start of the main loop again

for i = 1 to 5
gosub response
NEXT
goto showinstructs:

close 2: end

transmit:
print#2,u$ + chr$(10)+chr$(13);:u$=""
print ""

waiting:
if PEEK(673) AND 1 then print ".";: goto waiting: rem still transmitting
for i = 1 to 5
gosub response
NEXT
return


rem get the response until nothing waiting
response:
get#2,s$:if s$<>"" then print s$;:goto response
for w=1 to 2000: next
return
 
instructions:
PRINT CHR$(5): PRINT CHR$(147): PRINT CHR$(19);: REM CLEAR SCREEN, WHITE TEXT
print "select 1, 2 or 3 for led sequences"
print "select 4 to send a message to iphone"
print "select 5 current time from the internet"
RETURN
