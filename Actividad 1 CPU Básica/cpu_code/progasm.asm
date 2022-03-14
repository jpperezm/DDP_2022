           li R1, 20
           li R2, 2 
           li R5, -1
code:      add R3, R3, R2
           subi R1, R1, 1
           jnz code
           mov R4, R3
           neg R4, R4
           or R6, R2, R3
pepe:      j pepe