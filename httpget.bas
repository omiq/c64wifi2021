#lowercase
start:
POKE 53272,23
PRINT CHR$(5): PRINT CHR$(147): PRINT CHR$(19);: REM CLEAR SCREEN, WHITE TEXT
open2,2,4,chr$(8)+chr$(0):rem open the serial from user port

print "starting"
print#2,"at&k1":gosub transmit

for i = 1 to 5
gosub response
NEXT


showinstructs:
gosub instructions

selection:
u$="": i$="": get i$
if i$="1" then print "1 selected": u$="atgethttp://192.168.0.103/WIN&a=64&pl=1": gosub transmit
if i$="2" then print "2 selected": u$="atgethttp://192.168.0.103/WIN&a=64&pl=2": gosub transmit 
if i$="3" then print "3 selected": u$="atgethttp://192.168.0.103/WIN&a=64&pl=3": gosub transmit
if i$="m" then print "m selected": u$="atgethttps://hook.eu2.make.com/AD3MIE2EHS5UUHJO3N630YUT9GUHIWJ1?message=c64+basic": gosub transmit
if i$="t" then print "t selected": u$="atgetHTTPS://TIMEAPI.IO/API/TIMEZONE/ZONE?TIMEZONE=EUROPE/LONDON": gosub gettime
if i$="w" then print "w selected": u$="atgetHTTPS://V2.WTTR.IN/YORK,UK": gosub weather
if i$="r" then print "r selected": u$="atgethttps://www.random.org/INTEGERS/?NUM=1&MIN=1&MAX=20&COL=1&BASE=10&FORMAT=PLAIN&RND=NEW": gosub transmit
if i$="d" then print "d selected": u$="atgetHTTPS://API.DICTIONARYAPI.DEV/API/V2/ENTRIES/EN/NERD": gosub transmit

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
s$="":get#2,s$: 
if s$="" then goto shortdelay
if s$=chr$(13) or s$=chr$(10) then print s$;:goto response
if s$<" " or s$>"Z" then goto response
print s$+"";:goto response
shortdelay:
for w=1 to 400: next
return


rem get the url and then
rem parse the result from timeapi
gettime:
print#2,u$ + chr$(10)+chr$(13);:u$=""
print ""

waitfortime:
if PEEK(673) AND 1 then print ".";: goto waitfortime: rem still transmitting

rem get the time 
cc=0 : rem the api will return more chars that we can use
ts$ = "": nw$=""
parsetime:
get#2,s$:if s$<>"" and cc < 255 then ts$ = ts$ + s$:cc=cc+1:goto parsetime
nw$=mid$(ts$,176,22): ts$=""
for c = 1 to len(nw$)
c$ = mid$(nw$,c,1)
if c$="t" then i=c
NEXT

h$=mid$(nw$,i+1,2)
m$=mid$(nw$,i+4,2)
s$=mid$(nw$,i+7,2)
print ""
print h$ + ":" + m$ + ":" + s$
print ""
if val(h$)<25 and val(m$) < 60 and val(s$)<60 then time$ = h$ + m$ + s$
leftoverbytes:
get#2,s$:if s$<>"" then goto leftoverbytes
for w=1 to 1000: next
return


restweatherbytes:
get#2,s$: if s$<>"" goto restweatherbytes
return

rem weather
weather:
rem get the url and then
rem parse the result from weather url
gosub restweatherbytes
print#2,u$ + chr$(10)+chr$(13);:u$=""
print ""

waitfortransmit:
if PEEK(673) AND 1 then print ".";: goto waitfortransmit: rem still transmitting


parseweather:
for c=1 to 1160: get#2,s$: next

rem weather string length ~30
wl=50

parseweatherstr:
get#2,s$
if s$ = chr$(13) or s$=chr$(10) and len(w$)<wl then w$ = w$ + s$ : goto parseweatherstr
if s$ >= " " and s$ <= "Z" and len(w$)<wl then w$ = w$ + s$ : goto parseweatherstr
if len(w$)=wl then goto showweather
if s$<>"" goto parseweatherstr


gosub restweatherbytes
return

showweather:
print chr$(147)
print "current weather"
print w$: 
w$="": 

print "": print "press a key"
waitforkey:
get k$: if k$="" then goto waitforkey
print "please wait ..."
goto restweatherbytes


 
instructions:
PRINT CHR$(5): PRINT CHR$(147): PRINT CHR$(19);: REM CLEAR SCREEN, WHITE TEXT
print "select 1, 2 or 3 for led sequences"
print "select m to send a message to iphone"
print "select t current time from the internet"
print "select w for weather"
print "select r for random d20 roll"
print "select d for dictionary"
RETURN
