module reg_intr(input wire [7:0] intr_selec, 
                output reg [9:0] intr_dir_out);

always @(intr_selec)
  begin
    casex (intr_selec)
      8'bxxxxxxx1: intr_dir_out = 10'b1111110000;
      8'bxxxxxx10: intr_dir_out = 10'b1111110010;
      8'bxxxxx100: intr_dir_out = 10'b1111110100;
      8'bxxxx1000: intr_dir_out = 10'b1111110110;
      8'bxxx10000: intr_dir_out = 10'b1111111000;
      8'bxx100000: intr_dir_out = 10'b1111111010;
      8'bx1000000: intr_dir_out = 10'b1111111100;
      8'b10000000: intr_dir_out = 10'b1111111110;
      default: intr_dir_out = 10'bx;
    endcase
  end
endmodule

