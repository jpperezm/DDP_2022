module io_manager(input wire [15:0] dir_in,
                  input wire oe, clk, reset,
                  output reg [4:0] sram_control,
                  output wire [9:0] LED_R, 
                  output wire [7:0] LED_G,
                  output reg [17:0] dir_out,
                  inout wire [15:0] data_inout);

wire [9:0] rled_out;
wire [7:0] gled_out;
reg ce_g, ce_r;
reg [15:0] data_reg;

initial
  begin
    data_reg = 16'b0;
  end

registro_ce #(10) r_reg (clk, reset, ce_r, data_inout[9:0] | rled_out, rled_out);
registro_ce #(8) g_reg (clk, reset, ce_g, data_inout[7:0] | gled_out, gled_out);  

always @(dir_in)
  begin
    casex (dir_in)
      16'b1111111111111111:
        begin
          if(oe)
            begin
              sram_control = 5'b1xxxx; 
              ce_r = 1'b1;
              ce_g = 1'b0;
            end
          else
            begin
              sram_control = 5'b1xxxx;
              ce_r = 1'b0;
              ce_g = 1'b0;
              data_reg = rled_out;
            end
        end
      16'b1111111111111110:
        begin 
          if(oe)
            begin
              sram_control = 5'b1xxxx; 
              ce_g = 1'b1;
              ce_r = 1'b0;
            end
          else
            begin
              sram_control = 5'b1xxxx;
              ce_r = 1'b0;
              ce_g = 1'b0;
              data_reg = gled_out;
            end
        end
      default: 
        begin
          dir_out[15:0] = dir_in;
          dir_out[17:16] = 2'b0;
          sram_control = oe ? 5'b0x000 : 5'b00100; 
          ce_g = 1'b0;
          ce_r = 1'b0;
          data_reg = 15'bz;
        end
    endcase
  end

assign data_inout = data_reg;
assign LED_R = rled_out;
assign LED_G = gled_out;
            
endmodule