load R3, R2
subi R6, R3, 1
jz turnoffgled
store R1, R2
jrintr

turnoffgled:
store R0, R2
jrintr