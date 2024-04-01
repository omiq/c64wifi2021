#uppercase
rem POKE 53272,23
print "{clear}{white}"

open2,2,4,chr$(8)+chr$(0):rem open the serial from user port
print#2,"ATE0"
for i = 1 to 10
get#2,s$
print s$;
next

rem main loop
main:
get k$:rem get from c64 keyboard
if k$ = chr$(13) then print#2,chr$(10)+chr$(13);
if k$<>"" AND k$ <> chr$(13) then print#2,k$;: 
get#2,s$: rem get byte from serial
print s$;:rem print these bytes

waitbytes:
if (peek(673)and1)then goto waitbytes:rem wait until all chars transmitted

goto main
close 2:end