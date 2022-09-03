li R1, 65533 ; dir_mem botones 
li R2, 65535 ; dir_mem LEDS rojos
li R3, 65532 ; dir_mem switches
li R4, 65534 ; dir_mem LEDS verdes
li R5, 1

bucle:
load R7, R1

subi R8, R7, 1
jz grabar

subi R8, R7, 2
jz reproduce

subi R8, R7, 4
jz pause
j bucle

grabar:
li R14, 0
li R15, 1
li R12, 0
j bucle

reproduce:
li R15, 0
li R14, 1
li R12, 0
j bucle

pause:
li R15, 0
li R14, 0
j bucle

infinite:
addi R0, R0, 0
j infinite