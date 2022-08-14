`timescale 1 ns / 10 ps

//################# GESTOR_INTR SOLICITUD ####################
module manager_s (input wire [7:0] intr_in, intr_s, s_return_intr,
                  output wire [7:0] min_bit_s, data_s);

assign data_s = (~s_return_intr & intr_s) | intr_in;
assign min_bit_s = (-intr_s & intr_s);
endmodule

//################# GESTOR_INTR ATENCIÓN ####################

module manager_a (input wire [7:0] intr_a, s_return_intr, call_intr,
                  output wire [7:0] min_bit_a, data_a);

assign data_a = (~s_return_intr & intr_a) | call_intr;
assign min_bit_a = (-intr_a & intr_a);
endmodule

//################# GESTOR_INTR ####################
module intr_manager(input wire [7:0] interrupt_in, s_return_intr, call_intr,
                    input wire clk, reset,
                    output wire [7:0] min_bit_a, min_bit_s, interrupt_out);

wire [7:0] data_s, data_a, intr_s, intr_a;

manager_s gestor_s(interrupt_in, intr_s, s_return_intr, min_bit_s, data_s);
manager_a gestor_a(intr_a, s_return_intr, call_intr, min_bit_a, data_a);
registro #(8) request (clk, reset, data_s, intr_s);
registro #(8) atencion (clk, reset, data_a, intr_a);

assign interrupt_out = data_a;

endmodule

