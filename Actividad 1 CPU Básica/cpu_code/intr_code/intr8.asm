subi R9, R15, 1
jz readmode

subi R9, R14, 1
jz showdata

j idel

showdata:
store R0, R5
subi R9, R13, 0
jz memerror
load R6, R13
store R6, R2
subi R13, R13, 1
jrintr

readmode:
sub R9, R13, R7
jz memerror
load R6, R3
store R6, R13
addi R13, R13, 1
load R6, R5
sub R9, R6, R8
jz turnoffgled
store R8, R5
jrintr

idel:
jrintr

memerror:
store R0, R5
li R9, 1023
load R6, R2
sub R9, R6, R9
jz turnoffrled
store R6, R2
jrintr

turnoffrled:
store R0, R2
jrintr

turnoffgled:
store R0, R5
jrintr