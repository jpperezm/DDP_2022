`timescale 1 ns / 10 ps

module io_manager(input wire [15:0] dir_in,
                  input wire [3:0] buttons,
                  input wire [9:0] switches,
                  input wire oe, clk, reset,
                  output reg [4:0] sram_control,
                  output wire [9:0] LED_R, 
                  output wire [7:0] LED_G,
                  output wire [17:0] dir_out,
                  inout wire [15:0] Datos);

wire [9:0] rled_out;
wire [7:0] gled_out;
reg ce_g, ce_r, t_oe;
wire [15:0] data_in;
reg [15:0] data_out;

transceiver transc_io(clk, reset, t_oe, data_out, data_in, Datos);

registro_ce #(10) r_reg (clk, reset, ce_r, data_in[9:0], rled_out);
registro_ce #(8) g_reg (clk, reset, ce_g, data_in[7:0], gled_out);  

always @(*)
  begin
    if (reset) 
    begin
      t_oe = ~oe;
      ce_r = 1'b0;
      ce_g = 1'b0;
    end
    else
    begin
      casex (dir_in)
        16'b1111111111111111:
          begin              
            t_oe = ~oe;
            if(oe)
              begin
                sram_control = 5'b01000; 
                ce_r = 1'b1;
                ce_g = 1'b0;
              end
            else
              begin
                sram_control = 5'b11111;
                data_out = rled_out;
                ce_r = 1'b0;
                ce_g = 1'b0;
              end
          end
        16'b1111111111111110:
          begin 
            t_oe = ~oe;
            if(oe)
              begin
                sram_control = 5'b01000; 
                ce_g = 1'b1;
                ce_r = 1'b0;
              end
            else
              begin
                sram_control = 5'b11111;
                data_out = gled_out;
                ce_r = 1'b0;
                ce_g = 1'b0;
              end
          end

        16'b1111111111111101:
          begin
            t_oe = ~oe;
            if (!oe)
              begin
                sram_control = 5'b11111; 
                ce_g = 1'b0;
                ce_r = 1'b0;
                data_out = {12'b0, ~buttons};
              end
          end

        16'b1111111111111100:
          begin
            t_oe = ~oe;
            if (!oe)
              begin
                sram_control = 5'b11111; 
                ce_g = 1'b0;
                ce_r = 1'b0;
                data_out = switches;
              end
          end

        default: 
          begin
            sram_control = oe ? 5'b01000 : 5'b00100; 
            ce_g = 1'b0;
            ce_r = 1'b0;
            t_oe = 1'b0;
          end
      endcase
    end
  end

assign dir_out = {2'b0, dir_in};
assign LED_R = rled_out;
assign LED_G = gled_out;
            
endmodule