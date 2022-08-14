`timescale 1 ns / 10 ps

module pila(input wire clk, reset, push, pop, s_intr, input wire [9:0] dato, output wire [9:0] data_out);
  reg [9:0] stackmem[0:15]; //memoria de 16 palabras de 10 bits de ancho
  reg [3:0] sp;
  wire[3:0] spinc, spdec;
  
  assign spinc = sp + 5'b1;
  assign spdec = sp - 5'b1;

  always @(posedge clk, posedge reset)
    begin
      if(reset)
        sp <= 4'b0;
      else if(push == 1'b1)
        begin
          sp <= spinc;
          stackmem[spinc] <= dato + 10'b1;
        end
      else if(pop == 1'b1)
        sp <= spdec;
    end

    assign data_out = s_intr ? stackmem[sp] - 10'b1 : stackmem[sp];

endmodule