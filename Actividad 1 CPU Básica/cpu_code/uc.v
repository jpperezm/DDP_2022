module uc(input wire [5:0] opcode, input wire z, output reg s_mux_datos, s_inc, s_inm, we3, wez, output reg [2:0] op_alu);

always @(opcode)
  casex (opcode)
// ##################################### TRAJANDO CON INMEDIATO ##############################################
	  6'b1000xx:            // Oper. Alu (A)
      begin
        s_inc = 1'b1;
        s_inm = 1'b1;
        s_mux_datos = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b000; 
      end
    6'b1001xx:            // Oper. Alu (A negado) 
      begin
        s_inc = 1'b1;
        s_inm = 1'b1;
        s_mux_datos = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b001; 
      end
    6'b1010xx:            // Oper. Alu (A + B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b1;
        s_mux_datos = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b010; 
      end
    6'b1011xx:            // Oper. Alu (A - B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b1;
        s_mux_datos = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b011; 
      end
    6'b1100xx:            // Oper. Alu (A AND B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b1;
        s_mux_datos = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b100; 
      end
    6'b1101xx:           // Oper. Alu (A OR B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b1;
        s_mux_datos = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b101; 
      end
    6'b1110xx:            // Oper. Alu (-A)
      begin
        s_inc = 1'b1;
        s_inm = 1'b1;
        s_mux_datos = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b110; 
      end
// ###################################### TRABAJANDO CON REGISTROS ##########################################	
	  6'b010000:            // Oper. Alu (A) MOV
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        s_mux_datos = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b000; 
      end
	  6'b010001:            // Oper. Alu (A negado) 
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        s_mux_datos = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b001; 
      end 
	  6'b010010:            // Oper. Alu (A + B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        s_mux_datos = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b010; 
      end
    6'b010011:            // Oper. Alu (A - B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        s_mux_datos = 1'b0; 
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b011; 
      end   
    6'b010100:            // Oper. Alu (A AND B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        s_mux_datos = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b100; 
      end
    6'b010101:            // Oper. Alu (A OR B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        s_mux_datos = 1'b0; 
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b101; 
      end
    6'b010110:            // Oper. Alu (-A)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        s_mux_datos = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b111; 
      end

// ################################ INSTRUCCIONES DE SALTO #####################################
    6'b000100:            // Salto incondicional
      begin
        s_inc = 1'b0;
        s_inm = 1'b0;
        s_mux_datos = 1'b0;
        we3 = 1'b0;
        wez = 1'b0;
        op_alu = 3'b000; 
      end
    6'b000101:            // Salto condicional si z
      begin
        s_inc = z ? 1'b0:1'b1;
        s_inm = 1'b0;
        s_mux_datos = 1'b0; 
        we3 = 1'b0;
        wez = 1'b0;
        op_alu =3'b000;
      end
    6'b000110:            // Salto condicional si no z
      begin
        s_inc = z ? 1'b1:1'b0;
        s_inm = 1'b0;
        s_mux_datos = 1'b0; 
        we3 = 1'b0;
        wez = 1'b0;
        op_alu = 3'b000;
      end
    default: 
      begin
        s_inc = 1'b0;
        s_inm = 1'b0;
        s_mux_datos = 1'b0;
        we3 = 1'b0;
        wez = 1'b0;
        op_alu = 3'b000; 
      end
  endcase

endmodule