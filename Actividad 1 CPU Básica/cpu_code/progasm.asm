li R1, 65533 ; dir_mem botones 
li R2, 65535 ; dir_mem LEDS rojos
li R3, 65532 ; dir_mem switches
li R4, 65534 ; dir_mem LEDS verdes
li R5, 1

infinite:
addi R0, R0, 0
j infinite