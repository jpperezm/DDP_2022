module cd(input wire clk, reset, s_inc, s_inm, we3, wez, input wire [2:0] op_alu, output wire z, output wire [5:0] opcode);
//Camino de datos de instrucciones de un solo ciclo

wire [15:0] instruccion;
wire [9:0] salida_pc, mux_pc, sum_mux;
wire [7:0] rd1, rd2, alu_mux;
wire [7:0] wd3;
wire aluffz;

memprog memoria_prog(clk, salida_pc, instruccion);
registro #(10) pc (clk, reset, mux_pc, salida_pc);
sum sumador(salida_pc, 10'b0000000001, sum_mux);
mux2 #(10) mux_a(instruccion[9:0], sum_mux, s_inc, mux_pc);
regfile banco_registros(clk, we3, instruccion[11:8], instruccion[7:4], instruccion[3:0], wd3, rd1, rd2);
alu alu_cpu(rd1, rd2, op_alu, alu_mux, aluffz);
mux2 mux_b(alu_mux, instruccion[11:4], s_inm, wd3);
ffd ffz(clk, reset, aluffz, wez, z);

assign opcode = instruccion[15:10];

endmodule
