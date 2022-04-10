module dataloger(input wire clk, reset,
                 input wire [3:0] buttons,
                 input wire [9:0] switches,
                 output wire [4:0] sram_control, // ce, oe, we, ub, lb,
                 output wire [7:0] g_led,
                 output wire [9:0] r_led,
                 output wire [17:0] direcciones,
                 inout [15:0] datos);

reg [7:0] intr;
wire [15:0] direcciones_cpu;

initial
  begin
    intr = 8'b0;
  end

cpu procesador(clk, reset, intr, oe, direcciones_cpu, datos);
io_manager entrada_salida(direcciones_cpu, oe, clk, reset, sram_control, r_led, g_led, direcciones, datos);

always @(*)
  case (buttons) // presionas un botón
    4'b1110: intr = 8'b00000001 | intr;
    4'b1101: intr = 8'b00000010 | intr;
    4'b1011: intr = 8'b00000100 | intr;
    4'b0111: intr = 8'b00001000 | intr;
    default: intr = 8'b00000000;
  endcase

endmodule