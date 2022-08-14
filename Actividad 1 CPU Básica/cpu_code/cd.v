`timescale 1 ns / 10 ps

module cd(input wire clk, reset, push, pop, transceiver_oe, s_stack_mux, s_mux_alu, s_mux_datos, we3, wez, s_intr, 
          input wire [1:0] s_inc,
          input wire [7:0] intr,
          input wire [2:0] op_alu, 
          output wire [15:0] Direcciones,
          output wire z, 
          output wire [5:0] opcode,
          inout wire [15:0] Datos);
//Camino de datos de instrucciones de un solo ciclo

wire [31:0] instruccion;
wire [9:0] salida_pc, mux2mux, mux_pc, sum_mux, stack_mux, dir_intr;
wire [15:0] rd1, rd2, mux_alu, alu_mux, trans_mux;
wire [15:0] wd3;
wire aluffz;

wire wez_i, wez_ni;
assign wez_i = s_intr & wez;
assign wez_ni = !s_intr & wez;

assign z = s_intr ? out_z_i : out_z;

reg_intr intr_deco(intr, dir_intr);
memprog memoria_prog(clk, salida_pc, instruccion);
registro #(10) pc (clk, reset, mux_pc, salida_pc);
sum sumador(salida_pc, 10'b0000000001, sum_mux);
mux4 #(10) mux_a(instruccion[9:0], sum_mux, dir_intr, s_inc, mux2mux);
regfile banco_registros(clk, we3, instruccion[25:22], instruccion[21:18], instruccion[17:14], wd3, rd1, rd2);
alu alu_cpu(mux_alu, rd2, op_alu, s_mux_alu, alu_mux, aluffz);
mux2 mux_b(alu_mux, trans_mux, s_mux_datos, wd3);
mux2 mux_inm(rd1, instruccion[15:0], s_mux_alu, mux_alu);
ffd ffz(clk, reset, aluffz, wez_ni, out_z);
ffd ffz_i(clk, reset, aluffz, wez_i, out_z_i);
transceiver transc1(clk, reset, transceiver_oe, rd2, trans_mux, Datos);
pila stack(clk, reset, push, pop, s_intr, salida_pc, stack_mux);
mux2 #(10) mux_pila(mux2mux, stack_mux, s_stack_mux, mux_pc);

assign Direcciones = alu_mux;
assign opcode = instruccion[31:26];

endmodule
