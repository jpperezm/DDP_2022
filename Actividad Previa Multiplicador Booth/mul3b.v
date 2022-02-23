module multiplicador(input wire [3:0] multiplicando, multiplicador, input wire clk, start, output wire [7:0] resultado, output wire fin);

wire mux_selec, carga_a, carga_qm, desplaza, reset, resta;
wire q1, q0, q_1;

camdat cd(carga_a, carga_qm, mux_selec, clk, desplaza, reset, multiplicador, multiplicando, resta, q1, q0, q_1, resultado);
uc uni_control(q1, q0, q_1, clk, start, mux_selec, carga_a, carga_qm, desplaza, resta, fin, reset);

endmodule