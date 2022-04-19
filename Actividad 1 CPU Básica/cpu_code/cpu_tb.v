`timescale 1 ns / 10 ps

module cpu_tb;


reg clk, reset;
reg [7:0] intr;
wire [15:0] Datos;
wire [17:0] Direcciones;
wire [4:0] sram_control;
reg [3:0] buttons;
reg [9:0] switches;
wire [7:0] g_led;
wire [9:0] r_led;


// generación de reloj clk
always //siempre activo, no hay condición de activación
begin
  clk = 1'b1;
  #30;
  clk = 1'b0;
  #30;
end

// instanciación del procesador
dataloger micpu(clk, reset, buttons, switches, sram_control, g_led, r_led, Direcciones, Datos);

integer regid;

initial
begin
  $dumpfile("cpu_tb.vcd");
  $dumpvars;
  for (regid = 0; regid < 16; regid = regid + 1)
    begin
      $dumpvars(16'b0, cpu_tb.micpu.procesador.cam_dat.banco_registros.regb[regid]);
      $dumpvars(10'b0, cpu_tb.micpu.procesador.cam_dat.stack.stackmem[regid]);
    end
  reset = 1;  //a partir del flanco de subida del reset empieza el funcionamiento normal
  #10;
  buttons = 4'b1111;
  reset = 0;  //bajamos el reset 


  #200
  buttons = 4'b1110;
  #600
  buttons = 4'b1111;

  #200
  buttons = 4'b1101;
  #600
  buttons = 4'b1111;

end

reg signed [15:0] registros [15:0];

initial
begin
  #(600*90);  //Esperamos 9 ciclos o 9 instrucciones  
  for (regid = 0; regid < 16; regid = regid + 1)
    registros[regid] = cpu_tb.micpu.procesador.cam_dat.banco_registros.regb[regid];

  for (regid = 0; regid < 16; regid = regid + 1)
    $write("R%d = %d\n", regid, registros[regid]);  

  
  $finish;
end

endmodule