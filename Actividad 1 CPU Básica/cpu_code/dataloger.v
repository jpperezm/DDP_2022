`timescale 1 ns / 10 ps

module dataloger(input wire clk, reset,
                 input wire [3:0] buttons,
                 input wire [8:0] switches,
                 output wire [4:0] sram_control, // ce, oe, we, ub, lb,
                 output wire [7:0] g_led,
                 output wire [9:0] r_led,
                 output wire [17:0] direcciones,
                 inout [15:0] datos);

wire [15:0] direcciones_cpu;
wire [7:0] intr_wire;
wire [9:0] link_pc_leds;
wire oe;

cpu procesador(clk, reset, oe, direcciones_cpu, link_pc_leds, datos);
io_manager entrada_salida(direcciones_cpu, buttons, switches, link_pc_leds, oe, clk, reset, sram_control, r_led, g_led, direcciones, datos);

endmodule