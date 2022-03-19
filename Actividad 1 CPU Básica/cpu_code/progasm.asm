j main                           
pepe:  addi R1 R1 2
jcall jaime
jr 
j main
pedro: addi R8 R8 4
jr
main: addi R2 R2 1
jcall pepe
j end
end: addi R7 R7 7
acabao: add R0, R0, R0
j acabao
jaime: addi R6 R6 3
jcall pedro
jr