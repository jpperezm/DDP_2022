module pila(input wire clk, reset, push, pop, input wire [9:0] dato, output wire [9:0] data_out);
  reg [9:0] stackmem[0:15]; //memoria de 16 palabras de 10 bits de ancho
  reg [15:0] sp;

  initial
    sp <= 16'b0;

  always @(posedge clk, posedge reset)
    begin
      if(push == 1'b1)
        begin
          sp <= sp + 16'b1;
          stackmem[sp + 16'b1] <= dato + 10'b1;
        end

      if(pop == 1'b1)
        sp <= sp - 16'b1;
    end

    assign data_out = stackmem[sp];

endmodule