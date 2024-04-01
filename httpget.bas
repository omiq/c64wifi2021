#lowercase
POKE 53272,23
print "{clear}{white}"
open2,2,4,chr$(8)+chr$(0):rem open the serial from user port

print#2,"at":gosub transmit
print#2,"atc1":gosub transmit
print#2,"ati":gosub transmit

for i = 1 to 10
gosub response
next


main:
print "{clear}{white}wled"
print "select 1, 2 or 3"
selection:
u$="": get i$
if i$="1" then print "1 selected": u$="atgethttp://192.168.0.100/WIN&a=64&pl=1": gosub transmit
if i$="2" then print "2 selected": u$="atgethttp://192.168.0.100/WIN&a=64&pl=2": gosub transmit 
if i$="3" then print "3 selected": u$="atgethttp://192.168.0.100/WIN&a=64&pl=3": gosub transmit
goto selection: rem loop back to start of the main loop again


transmit:
print#2,u$ + chr$(13)
print ""
waiting:
if PEEK(673) AND 1 then print ".";: goto waiting: rem still transmitting
for w=1 to 2000: next

rem get the response until nothing waiting
response:
get#2,s$:if s$<>"" then print s$;:goto response 
for w=1 to 2000: next
return
 
 rem ---------------------------------
 close 2:end