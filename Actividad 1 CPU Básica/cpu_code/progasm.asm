li R1, 65533  
li R2, 65535
li R3, 65532 
li R5, 65534 
li R7, 65531
li R8, 1

start:
load R4, R1
subi R9, R4, 1 
jz readstart
subi R9, R4, 2
jz stop 
subi R9, R4, 4
jz showdata
j start 

readstart: 
li R14, 0 
li R15, 1
j start

stop:
li R14, 0
li R15, 0
j start

showdata:
li R15, 0
li R14, 1