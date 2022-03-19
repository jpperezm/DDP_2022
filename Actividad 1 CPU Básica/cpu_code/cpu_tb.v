`timescale 1 ns / 10 ps

module cpu_tb;


reg clk, reset;


// generación de reloj clk
always //siempre activo, no hay condición de activación
begin
  clk = 1'b1;
  #30;
  clk = 1'b0;
  #30;
end

// instanciación del procesador
cpu micpu(clk, reset);

integer regid;

initial
begin
  $dumpfile("cpu_tb.vcd");
  $dumpvars;
  for (regid = 0; regid < 16; regid = regid + 1)
    begin
      $dumpvars(16'b0, cpu_tb.micpu.cam_dat.banco_registros.regb[regid]);
      $dumpvars(10'b0, cpu_tb.micpu.cam_dat.stack.stackmem[regid]);
    end
  reset = 1;  //a partir del flanco de subida del reset empieza el funcionamiento normal
  #10;
  reset = 0;  //bajamos el reset 
end

reg signed [15:0] registros [15:0];

initial
begin
  #(600*90);  //Esperamos 9 ciclos o 9 instrucciones  
  for (regid = 0; regid < 16; regid = regid + 1)
    registros[regid] = cpu_tb.micpu.cam_dat.banco_registros.regb[regid];

  for (regid = 0; regid < 16; regid = regid + 1)
    $write("R%d = %d\n", regid, registros[regid]);  

  
  $finish;
end

endmodule