1 POKE 53272,23
2 PRINT CHR$(5): PRINT CHR$(147): PRINT CHR$(19);: REM clear screen, white text
3 OPEN2,2,4,CHR$(8)+CHR$(0):REM OPEN THE SERIAL FROM USER PORT
4 PRINT "STARTING"
5 PRINT#2,"AT":GOSUB 29
6 FOR I = 1 TO 5
7 GOSUB 37
8 NEXT
9 PRINT "CONNECTING TO WIFI"
10 PRINT#2,"ATC1":GOSUB 29
11 FOR I = 1 TO 5
12 GOSUB 37
13 NEXT
14 PRINT "GETTING CONNECTION INFO"
15 PRINT#2,"ATI":GOSUB 29
16 FOR I = 1 TO 10
17 GOSUB 37
18 NEXT
19 GOSUB 40
20 U$="": I$="": GET I$
21 IF I$="1" THEN PRINT "1 SELECTED": U$="ATGETHTTP://192.168.0.100/win&A=64&PL=1": GOSUB 29
22 IF I$="2" THEN PRINT "2 SELECTED": U$="ATGETHTTP://192.168.0.100/win&A=64&PL=2": GOSUB 29
23 IF I$="3" THEN PRINT "3 SELECTED": U$="ATGETHTTP://192.168.0.100/win&A=64&PL=3": GOSUB 29
24 IF I$ = "" THEN GOTO 20: REM LOOP BACK TO START OF THE MAIN LOOP AGAIN
25 FOR I = 1 TO 5
26 GOSUB 37
27 NEXT
28 CLOSE 2: END
29 PRINT#2,U$ + CHR$(10)+CHR$(13);:U$=""
30 PRINT ""
31 IF PEEK(673) AND 1 THEN PRINT ".";: GOTO 31: REM STILL TRANSMITTING
32 FOR I = 1 TO 5
33 GOSUB 37
34 NEXT
35 RETURN
36 REM GET THE RESPONSE UNTIL NOTHING WAITING
37 GET#2,S$:IF S$<>"" THEN PRINT S$;:GOTO 37
38 FOR W=1 TO 2000: NEXT
39 RETURN
40 PRINT CHR$(147)
41 PRINT CHR$(5): PRINT CHR$(147): PRINT CHR$(19);: REM clear screen, white text
42 PRINT "SELECT 1, 2 OR 3"
43 RETURN