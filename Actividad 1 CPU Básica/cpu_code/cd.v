module cd(input wire clk, reset, s_inc, s_mux_alu, s_mux_datos, we3, wez, input wire [15:0] Datos, input wire [2:0] op_alu, output wire [15:0] Direcciones, output wire z, output wire [5:0] opcode);
//Camino de datos de instrucciones de un solo ciclo

wire [31:0] instruccion;
wire [9:0] salida_pc, mux_pc, sum_mux;
wire [15:0] rd1, rd2, mux_alu, alu_mux;
wire [15:0] wd3;
wire aluffz;

memprog memoria_prog(clk, salida_pc, instruccion);
registro #(10) pc (clk, reset, mux_pc, salida_pc);
sum sumador(salida_pc, 10'b0000000001, sum_mux);
mux2 #(10) mux_a(instruccion[9:0], sum_mux, s_inc, mux_pc);
regfile banco_registros(clk, we3, instruccion[25:22], instruccion[21:18], instruccion[17:14], wd3, rd1, rd2);
alu alu_cpu(mux_alu, rd2, op_alu, alu_mux, aluffz);
mux2 mux_b(Datos, alu_mux, s_mux_datos, wd3);
mux2 mux_inm(instruccion[15:0], rd1, s_mux_alu, mux_alu);
ffd ffz(clk, reset, aluffz, wez, z);

assign opcode = instruccion[31:26];

endmodule
