subi R10, R15, 1
jz recordmode
subi R10, R14, 1
jz showmode
add R10, R14, R15
jz stopmode
jrintr

recordmode:
load R9, R4
load R11, R3

addi R0, R0, 0

store R11, R12
addi R12, R12, 1

subi R9, R9, 1
jz apagaled
store R5, R4
jrintr

showmode:
load R9, R4
load R13, R12
addi R12, R12, 1
store R13, R2
subi R9, R9, 85
jz apagaled
store R6, R4
jrintr

stopmode:
store R0, R4
store R0, R2
jrintr

apagaled:
store R0, R4
jrintr