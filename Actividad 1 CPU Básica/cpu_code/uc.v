module uc(input wire [5:0] opcode, input wire z, output reg s_inc, s_inm, we3, wez, output reg [2:0] op_alu);

always @(opcode)
  casex (opcode)
	
    6'b0000xx:            // Carga Inm
      begin
        s_inc = 1'b1;     // s_inc a 1 en todos los opcodes que no son saltos
        s_inm = 1'b1;     // s_inm a 1 para que te pille el dato inmediato en el mux
        we3 = 1'b1;
        wez = 1'b0;
        op_alu = 3'b000; 
      end
	  6'b1000xx:            // Oper. Alu (A)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b000; 
      end
	  6'b1001xx:            // Oper. Alu (A negado)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b001; 
      end 
	  6'b1010xx:            // Oper. Alu (A + B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b010; 
      end
    6'b1011xx:            // Oper. Alu (A - B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b011; 
      end   
    6'b1100xx:            // Oper. Alu (A AND B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b100; 
      end
    6'b1101xx:            // Oper. Alu (A OR B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b101; 
      end
    6'b1110xx:            // Oper. Alu (-A)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b110; 
      end
	  6'b1111xx:            // Oper. Alu (-B)
      begin
        s_inc = 1'b1;
        s_inm = 1'b0;
        we3 = 1'b1;
        wez = 1'b1;
        op_alu = 3'b111; 
      end
    6'b000100:            // Salto incondicional
      begin
        s_inc = 1'b0;
        s_inm = 1'b0;
        we3 = 1'b0;
        wez = 1'b0;
        op_alu = 3'b000; 
      end
    6'b000101:            // Salto condicional si z
      begin
        s_inc = z ? 1'b0:1'b1;
        s_inm = 1'b0;
        we3 = 1'b0;
        wez = 1'b0;
        op_alu =3'b000;
      end
    6'b000110:            // Salto condicional si no z
      begin
        s_inc = z ? 1'b1:1'b0;
        s_inm = 1'b0;
        we3 = 1'b0;
        wez = 1'b0;
        op_alu = 3'b000;
      end
    default: 
      begin
        s_inc = 1'b0;
        s_inm = 1'b0;
        we3 = 1'b0;
        wez = 1'b0;
        op_alu = 3'b000; 
      end
  endcase

endmodule