`timescale 1 ns / 10 ps

module cpu(input wire clk, reset, 
           output wire oe, 
           output wire [15:0] Direcciones, 
           inout wire [15:0] Datos);

wire [5:0] opcode;
wire [2:0] op_alu;
wire [1:0] s_inc;
wire [7:0] intr, intr_out, s_return_intr, s_call_intr, min_bit_a, min_bit_s;
wire s_inm, s_mux_datos, we3, wez, z, s_stack_mux, push, pop, s_intr, transceiver_oe;

intr_manager gestor_intr(intr, s_return_intr, s_call_intr, clk, reset, min_bit_a, min_bit_s, intr_out);
cd cam_dat(clk, reset, push, pop, transceiver_oe, s_stack_mux, s_inm, s_mux_datos, we3, wez, s_intr, s_inc, intr_out, op_alu, Direcciones, z, opcode, Datos);
uc uni_control(opcode, z, min_bit_a, min_bit_s, s_return_intr, s_call_intr, s_mux_datos, s_inm, we3, wez, s_stack_mux, transceiver_oe, push, pop, s_intr, s_inc, op_alu);

assign oe = transceiver_oe;

endmodule
