// Immediate generation
module Immediate(
  input wire [31:7]inst,
  input wire [31:0]PC,
  output reg [31:0]I,
  output reg [31:0]S,
  output reg [31:0]Sb,
  output reg [31:0]Uj,
  output reg [31:0]U
);
  	always @(*) begin
//     i type
    I[11:0]=inst[31:20];
    if(inst[31]==1'b1)
      I[31:12]=20'b11111111111111111111;
    else
      I[31:12]=20'b0; 
//     S type
    S[4:0]=inst[11:7];
    S[11:5]=inst[31:25];
    if(inst[31]==1'b1)
      S[31:12]=20'b11111111111111111111;
    else begin
      S[31:12]=20'b0;
    end
//     Sb type
    Sb[11]=inst[7];
    Sb[4:1]=inst[11:8];
    Sb[10:5]=inst[30:25];
    Sb[12]=inst[31];
    Sb[0]=1'b0;
    if(inst[31]==1'b1)
      Sb[31:12]=20'b11111111111111111111;
    else
      Sb[31:12]=20'b00000000000000000000;
    Sb=Sb+PC;
//     Uj type
    Uj[19:12]=inst[19:12];
    Uj[11]=inst[20];
    Uj[10:1]=inst[30:21];
    Uj[20]=inst[31];
    Uj[0]=1'b0;
    if(inst[31]==1'b1)
      Uj[31:21]=11'b11111111111;
    else
      Uj[31:21]=11'b00000000000;
    Uj=Uj+PC;
//     U type
    U[19:0]=inst[31:12];
    if(inst[31]==1'b1)
      U[31:20]=12'b111111111111;
    else
      U[31:20]=12'b000000000000;
      U[31:0]=U[31:0]<<12;
  end
endmodule

