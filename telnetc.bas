10 rem 1200,8n1
20 open2,2,4,chr$(8)+chr$(0):rem open the serial from user port
30 get#2,s$: print#2,""
40 rem telnet connection to proxy
50 print#2,"atdt10.0.0.203:6464"
60 rem ---------------------------------
100 rem main loop
110 print "{clear}{white}"
200 rem request the info
220 print#2,"d"; : rem date
230 gosub 2000
240 print#2,"t"; : rem time
250 gosub 2000
260 print#2,"w"; : rem weather
270 gosub 2000
280 print#2,"s"; : rem subscribers
290 gosub 2000
300 print#2,"v"; : rem views
310 gosub 2000
1000 rem ---------------------------------
1010 rem loop back to start of the main loop again
1020 goto 100
2000 rem ---------------------------------
2010 rem output the response until nothing waiting
2020 get#2,s$: print s$;:rem print these bytes
2030 if s$<>chr$(13) then 2020:rem keep going until no bytes waiting
2040 for w=1 to 1000:next
2050 return
9000 rem ---------------------------------
9010 close 2:end