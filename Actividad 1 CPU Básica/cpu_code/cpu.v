module cpu(input wire clk, reset);
//module cd(input wire clk, reset, s_inc, s_mux_alu, s_mux_datos, we3, wez, input wire [15:0] Datos, input wire [2:0] op_alu output wire [15:0] Direcciones, output wire z, output wire [5:0] opcode);
//module uc(input wire [5:0] opcode, input wire z, output reg s_inc, s_inm, we3, wez, output reg [2:0] op_alu);
wire [5:0] opcode;
wire [2:0] op_alu;
wire [15:0] Datos, Direcciones;
wire s_inc, s_inm, s_mux_datos, we3, wez, z, s_stack_mux, push, pop;

cd cam_dat(clk, reset, push, pop, transceiver_oe, s_stack_mux, s_inc, s_inm, s_mux_datos, we3, wez, Datos, op_alu, Direcciones, z, opcode);
uc uni_control(opcode, z, s_mux_datos, s_inc, s_inm, we3, wez, s_stack_mux, transceiver_oe, push, pop, op_alu);

endmodule
