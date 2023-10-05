// CU
module control_unit (
  input wire [6:0]opcode,
  input wire [2:0]fun3,
  input wire func7,
  output reg [3:0]ALU_C,
  output reg [1:0]N_PC,
  output reg [1:0]IMM_sel,
  output reg [1:0]OP_A,
  output reg OP_B,
  output reg Mem2Reg,
  output reg store,
  output reg branch,
  output reg reg_write
); 
  always @(*) begin
    case (opcode)
      7'b0110011: begin
      //       R-Type
        reg_write=1'b1;
        branch=1'b0;
        store=1'b0;
        Mem2Reg=1'b1;
        OP_A=2'b00;
        OP_B=1'b0;
        IMM_sel=2'b11;
        N_PC=2'b00;
        case (fun3) 
          3'b000:begin 
            ALU_C=(!func7)?4'b0000:4'b0001;
            // if (!func7)
            //   ALU_C=4'b0000;   //add
            // else 
            //   ALU_C=4'b0001;   //sub
          end
          3'b001: begin               //sll
            ALU_C=(!func7)?4'b0101:4'b0000;
            // if (!func7)
            //   ALU_C=4'b0101;
          end
          3'b010:begin              //slt
            ALU_C=(!func7)?4'b0111:4'b0000;
            // if (!func7)
            //   ALU_C=4'b0111;
          end
          3'b011: begin             //sltu
            ALU_C=(!func7)?4'b1000:4'b0000;
            // if (!func7)
            //   ALU_C=4'b1000;
          end
          3'b100:begin                 //xor
            ALU_C=(!func7)?4'b0100:4'b0000;
            // if (!func7)
            //   ALU_C=4'b0100;
          end
          3'b101: begin       
            ALU_C=(!func7)?4'b0110:4'b1001;
            // if (!func7)
            //   ALU_C=4'b0110;       //srl
            // else 
            //   ALU_C=4'b1001;       //sra
          end
          3'b110:begin                    //or
            ALU_C=(!func7)?4'b0011:4'b0000;
            // if (!func7)
            //   ALU_C=4'b0011;
          end
          3'b111: begin                   //and
            ALU_C=(!func7)?4'b0010:4'b0000;
            // if (!func7)
            //   ALU_C=4'b0010;
          end
          default: begin
            ALU_C=4'b0000;
          end
        endcase
      end

      7'b1100111: begin
      //       JALR
        reg_write=1'b1;
        branch=1'b0;
        store=1'b0;
        Mem2Reg=1'b1;
        OP_A=2'b10;
        OP_B=1'b1;
        IMM_sel=2'b00;
        N_PC=2'b11;
        ALU_C=4'b1111;
      end
      7'b0010011: begin
      //       I-type
        reg_write=1'b1;
        branch=1'b0;
        store=1'b0;
        Mem2Reg=1'b1;
        OP_A=2'b00;
        OP_B=1'b1;
        IMM_sel=2'b00;
        N_PC=2'b00;
        case (fun3) 
          3'b000: ALU_C=4'b0000;//addi
          3'b001: ALU_C=4'b0101;//slli
          3'b010: ALU_C=4'b0111;//slti
          3'b011: ALU_C=4'b1000;//sltiu
          3'b100: ALU_C=4'b0100;//xori
          3'b101: ALU_C=(!func7)?4'b0110:4'b1001;//srli/srai
          // begin
          //   if (!func7)
          //     ALU_C=4'b0110;
          //   else 
          //     ALU_C=4'b1001;
          // end
          3'b110: ALU_C=4'b0011;//ori
          3'b111: ALU_C=4'b0010;//andi
          default: ALU_C=4'b0000;
        endcase
      end
      7'b0000011: begin
      //       load
        reg_write=1'b1;
        branch=1'b0;
        store=1'b0;
        Mem2Reg=1'b0;
        OP_A=2'b00;
        OP_B=1'b1;
        IMM_sel=2'b00;
        N_PC=2'b00;
        ALU_C=4'b0000;
      end
      7'b0100011: begin
      //       S-type
        reg_write=1'b0;
        branch=1'b0;
        store=1'b1;
        Mem2Reg=1'b1;
        OP_A=2'b00;
        OP_B=1'b1;
        IMM_sel=2'b01;
        N_PC=2'b00;
        ALU_C=4'b0000;
      end
      7'b1100011: begin
      //       Sb-type
        reg_write=1'b0;
        branch=1'b1;
        store=1'b0;
        Mem2Reg=1'b1;
        OP_A=2'b00;
        OP_B=1'b0;
        IMM_sel=2'b11;
        N_PC=2'b10;
        ALU_C=4'b0000;
      end
      7'b0110111: begin
      //       LUI
        reg_write=1'b1;
        branch=1'b0;
        store=1'b0;
        Mem2Reg=1'b1;
        OP_A=2'b00;
        OP_B=1'b1;
        IMM_sel=2'b10;
        N_PC=2'b00;
        ALU_C=4'b0000;
      end
      7'b0010111: begin 
      //       AUIPC
        reg_write=1'b1;
        branch=1'b0;
        store=1'b0;
        Mem2Reg=1'b1;
        OP_A=2'b01;
        OP_B=1'b1;
        IMM_sel=2'b10;
        N_PC=2'b00;
        ALU_C=4'b0000;
      end
      
      7'b1101111: begin
      //       Uj-type
        reg_write=1'b1;
        branch=1'b0;
        store=1'b0;
        Mem2Reg=1'b1;
        OP_A=2'b10;
        OP_B=1'b0;
        IMM_sel=2'b11;
        N_PC=2'b01;
        ALU_C=4'b1111;
      end
      default: begin
        reg_write=1'b1;
        branch=1'b0;
        store=1'b0;
        Mem2Reg=1'b1;
        OP_A=2'b00;
        OP_B=1'b0;
        IMM_sel=2'b11;
        N_PC=2'b00;
        ALU_C=4'b0000;
      end
    endcase
  end
endmodule

