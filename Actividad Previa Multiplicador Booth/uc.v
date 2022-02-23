module uc (input wire q1, q0, q_1, clk, start, output wire mux_selec, carga_a, carga_qm, desplaza, resta, fin, reset_out);

reg [2:0] state, nextstate;

//Codificación de los estados

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;


always @ (posedge clk, posedge start)
  if (start)
    state <= S0;
  else
    state <= nextstate;
   
always @(*)
  case (state)
    S0: nextstate = S1;
    S1: nextstate = S2;
    S2: nextstate = S3;
    S3: nextstate = S4;
    S4: nextstate = S5;
    S5: nextstate = S5;
    default: nextstate = S0;
  endcase

assign carga_qm = (state == S0) ? 1'b1:1'b0;
assign mux_selec = ((!q1 & q0 & q_1)|(q1 & !q0 & !q_1)) & ((state == S1)|(state == S3)) ? 1'b0:1'b1;
assign carga_a = (!((q1 & q0 & q_1)|(!q1 & !q0 & !q_1)) & ((state == S1)|(state == S3))) ? 1'b1:1'b0;
assign desplaza = ((state == S2)|(state == S4)) ? 1'b1:1'b0;
assign resta = ((q1) & ((state == S1)|(state == S3))) ? 1'b1:1'b0;
assign reset_out = (start) ? 1'b1:1'b0;
assign fin = (state == S5) ? 1'b1:1'b0;

endmodule