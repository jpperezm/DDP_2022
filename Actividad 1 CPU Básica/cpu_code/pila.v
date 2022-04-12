`timescale 1 ns / 10 ps

module pila(input wire clk, reset, push, pop, s_intr, input wire [9:0] dato, output wire [9:0] data_out);
  reg [9:0] stackmem[0:15]; //memoria de 16 palabras de 10 bits de ancho
  reg [15:0] sp;

  initial
    sp <= 16'b0;

  always @(posedge clk, posedge reset)
    begin
      if(reset)
        sp <= 16'b0;
      else if(push == 1'b1)
        begin
          sp <= sp + 16'b1;
          stackmem[sp + 16'b1] <= dato + 10'b1;
        end
      else if(pop == 1'b1)
        sp <= sp - 16'b1;
    end

    assign data_out = s_intr ? stackmem[sp] - 10'b1 : stackmem[sp];

endmodule