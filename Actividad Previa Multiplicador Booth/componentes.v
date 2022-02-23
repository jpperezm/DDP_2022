`timescale 1 ns / 10 ps

// Registro de 4 bits, soporta Carga de entrada, reseteo y desplazamiento aritmético o lógico
// La línea de Carga indica que se va a asignar un nuevo valor al registro que viene por "entrada"
// La línea de Desplaza indica que se va a desplazar el contenido del registro. El bit más significativo se completa con la entrada "bit_en_desp"
module registro4 (input wire [3:0] entrada, input wire bit_en_desp, input wire Carga, Desplaza, clk, reset, output wire [3:0] salida);
  wire enable;

  assign enable = Carga | Desplaza; //Si se carga o desplaza se habilitan en modificación los biestables

  cdaff ff0(Carga, entrada[0], salida[1], clk, reset, enable, salida[0]);
  cdaff ff1(Carga, entrada[1], salida[2], clk, reset, enable, salida[1]);
  cdaff ff2(Carga, entrada[2], salida[3], clk, reset, enable, salida[2]);
  cdaff ff3(Carga, entrada[3], bit_en_desp, clk, reset, enable, salida[3]); //entra un bit en el desplaz
endmodule

// Registro de 6 bits, soporta Carga de entrada, reseteo y desplazamiento aritmético o lógico
// La línea de Carga indica que se va a asignar un nuevo valor al registro que viene por "entrada"
// La línea de Desplaza indica que se va a desplazar el contenido del registro. El bit más significativo se completa con la entrada "bit_en_desp"
module registro6 (input wire [5:0] entrada, input wire bit_en_desp, input wire Carga, Desplaza, clk, reset, output wire [5:0] salida);
  wire enable;
  
  assign enable = Carga; //Si se carga o desplaza se habilitan en modificación los biestables

  cdaff ff0(Carga, entrada[0], salida[1], clk, reset, enable, salida[0]);
  cdaff ff1(Carga, entrada[1], salida[2], clk, reset, enable, salida[1]);
  cdaff ff2(Carga, entrada[2], salida[3], clk, reset, enable, salida[2]);
  cdaff ff3(Carga, entrada[3], salida[4], clk, reset, enable, salida[3]);
  cdaff ff4(Carga, entrada[4], salida[5], clk, reset, enable, salida[4]);
  cdaff ff5(Carga, entrada[5], bit_en_desp, clk, reset, enable, salida[5]); //entra un bit en el desplaz
endmodule

//################################################ REGISTROS CON DOBLE DESPLAZAMIENTO #################################################################################
module registro6_2desp (input wire [5:0] entrada, input wire [1:0] bit_en_desp, input wire Carga, Desplaza, clk, reset, output wire [5:0] salida);
  wire enable;
  
  assign enable = Carga | Desplaza; //Si se carga o desplaza se habilitan en modificación los biestables

  cdaff ff0(Carga, entrada[0], salida[2], clk, reset, enable, salida[0]);
  cdaff ff1(Carga, entrada[1], salida[3], clk, reset, enable, salida[1]);
  cdaff ff2(Carga, entrada[2], salida[4], clk, reset, enable, salida[2]);
  cdaff ff3(Carga, entrada[3], salida[5], clk, reset, enable, salida[3]);
  cdaff ff4(Carga, entrada[4], bit_en_desp[0], clk, reset, enable, salida[4]);
  cdaff ff5(Carga, entrada[5], bit_en_desp[1], clk, reset, enable, salida[5]); //entra un bit en el desplaz
endmodule

module registro4_2desp (input wire [3:0] entrada, input wire [1:0] bit_en_desp, input wire Carga, Desplaza, clk, reset, output wire [3:0] salida);
  wire enable;

  assign enable = Carga | Desplaza; //Si se carga o desplaza se habilitan en modificación los biestables

  cdaff ff0(Carga, entrada[0], salida[2], clk, reset, enable, salida[0]);
  cdaff ff1(Carga, entrada[1], salida[3], clk, reset, enable, salida[1]);
  cdaff ff2(Carga, entrada[2], bit_en_desp[0], clk, reset, enable, salida[2]);
  cdaff ff3(Carga, entrada[3], bit_en_desp[1], clk, reset, enable, salida[3]); //entra un bit en el desplaz
endmodule
//####################################################################################################################################################################

//Biestable con entrada de mux para aceptar dos entradas posibles
module cdaff (input wire selc_d, inp_c, inp_d, clk, reset, carga, output wire salida);
  wire inp;
  
  ffdc ff0(clk, reset, carga, inp, salida);
  mux2_1_i1 mux0(inp, inp_d, inp_c, selc_d);
endmodule

//Mux de dos entradas de 1 bit realizado a partir de puertas 
module mux2_1_i1(output wire out, input wire a, b, s);
  //Declaración de conexiones internas
  wire  s_n, sa, sb;     
  //Instancias de puertas y sus conexiones
  not inv1 (s_n, s);
  and and1 (sa, a, s_n);
  and and2 (sb, b, s);
  or or1 (out, sa, sb);
endmodule

//Mux de dos entradas de 6 bits
module mux2_1_M(output reg [5:0] out, input wire[5:0] a, b, input wire s);
  always @(s, a, b)
    if (s == 1'b0)
      out = a;
    else
      out = b;

//assign out = (s == 1'b0) ? a:b;

endmodule

module ffdc #(parameter retardo = 0)(input wire clk, reset, carga, d, output reg q);
  //reset asíncrono, carga síncrona
  always @(posedge clk, posedge reset)
    if (reset)
      q <= #retardo 1'b0; //asignación no bloqueante q=0
    else
      if (carga)
        q <= #retardo d; //asignación no bloqueante q=d
endmodule

// Sumador/Restador de 6 bits
module sum_resta4(output wire[5:0] S, output wire c_out, input wire[5:0] A, input wire[5:0] B, input wire resta);
  assign {c_out, S} = (resta == 1) ? A - B + 0 : A + B + 0;
endmodule
