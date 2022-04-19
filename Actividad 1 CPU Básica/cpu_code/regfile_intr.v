`timescale 1 ns / 10 ps

module reg_intr(input wire [7:0] intr_selec, 
                output reg [9:0] intr_dir_out);

always @(intr_selec)
  begin
    casex (intr_selec)                
      8'bxxxxxxx1: intr_dir_out = 10'b1101011100;
      8'bxxxxxx10: intr_dir_out = 10'b1101110000;
      8'bxxxxx100: intr_dir_out = 10'b1110000100;
      8'bxxxx1000: intr_dir_out = 10'b1110011000;
      8'bxxx10000: intr_dir_out = 10'b1110101100;
      8'bxx100000: intr_dir_out = 10'b1111000000;
      8'bx1000000: intr_dir_out = 10'b1111010100;
      8'b10000000: intr_dir_out = 10'b1111010100;
      default: intr_dir_out = 10'bx;
    endcase
  end
endmodule

