module camdat (input wire carga_a, carga_qm, mux_selec, input wire clk, desplaza, reset, input wire [3:0] entrada_Q, entrada_M, input wire resta, output wire q1, q0, q_1, output wire [7:0] result);

wire [5:0] salida_sum, salida_a, salida_m, salida_m2, salida_mux;
wire [3:0] salida_q;
wire c_sum; //No estoy seguro del carry del sumador

registro6_2desp A(salida_sum, {salida_a[5],salida_a[5]}, carga_a, desplaza, clk, reset, salida_a);
registro6 M({entrada_M[3], entrada_M[3], entrada_M}, 1'b0, carga_qm, 1'b0, clk, reset, salida_m);
registro6 M2({entrada_M[3], entrada_M, 1'b0}, 1'b0, carga_qm, 1'b0, clk, reset, salida_m2);    
registro4_2desp Q(entrada_Q, {salida_a[1], salida_a[0]}, carga_qm, desplaza, clk, reset, salida_q);
mux2_1_M M2_o_M(salida_mux, salida_m2, salida_m, mux_selec);
ffdc ff_q(clk, reset, desplaza, salida_q[1], q_1);
 
sum_resta4 Sum(salida_sum, c_sum, salida_a, salida_mux, resta);

assign q0 = salida_q[0];
assign q1 = salida_q[1];
assign result = {salida_a[3], salida_a[2], salida_a[1], salida_a[0], salida_q};

endmodule 
