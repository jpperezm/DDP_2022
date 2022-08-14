
load R6, R2
subi R6, R6, 1
jz apaga
j enciende

apaga:
store R0, R2
jrintr

enciende:
store R5, R2
jrintr