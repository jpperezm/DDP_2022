li R1 65533
li R2 65535
li R4 1

start:
load R3 R1
subi R5 R3 14
jz encender
subi R5 R3 13
jz apagar
j start 

encender:
store R4 R2
j start

apagar:
store R7 R2
j start