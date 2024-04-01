#lowercase
POKE 53272,23

show:
print "{clear}{white}"
open2,2,4,chr$(8)+chr$(0):rem open the serial from user port

if i$<>"" then goto selection

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

print "getting connection info"
print#2,"ati":gosub transmit

for i = 1 to 10
gosub response
next


gosub instructions

selection:
u$="": get i$
if i$="1" then print "1 selected": u$="atgethttp://192.168.0.100/WIN&a=64&pl=1": gosub transmit
if i$="2" then print "2 selected": u$="atgethttp://192.168.0.100/WIN&a=64&pl=2": gosub transmit 
if i$="3" then print "3 selected": u$="atgethttp://192.168.0.100/WIN&a=64&pl=3": gosub transmit

if i$ = "" then goto selection: rem loop back to start of the main loop again

for i = 1 to 5
gosub response
NEXT
close 2
print fre(1)
i$=">"
goto show

transmit:
print#2,u$ + chr$(10)+chr$(13);
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
print chr$(147)
print "{clear}{white}wled"
print "select 1, 2 or 3"
RETURN

