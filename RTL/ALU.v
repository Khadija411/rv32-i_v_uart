
module ALU1(
  input wire [31:0]A, 
  input wire [31:0]B,
  input wire [3:0]Data_sel,
  output reg [31:0]res
);
  	always @(*) begin
    case (Data_sel)
      4'b0000:  res=A+B;                    //add
      4'b0001:  res=$signed(A)- $signed(B); //sub
      4'b0010:  res=A&B;                    //and
      4'b0011:  res=A|B;                    //or
      4'b0100:  res=A^B;                    //xor
      4'b0101:  res=A<<B[4:0];              //sll
      4'b0110:  res=A>>B[4:0];              //srl
      4'b0111:  res=(A<B)?1:0;              //slt
      4'b1000:  res=$unsigned(A<B)?1:0;     //sltu
      4'b1001:  res=A>>B[4:0];              //sra
      4'b1111:  res=A;                      //JAL/JALR
      default:  res=A+B;
    endcase
  end
endmodule

