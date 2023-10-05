module inst_mem#(parameter width=32, parameter addwidth=12)
  (
    input wire [addwidth-1 : 0] address,
    input wire clk,
    input wire [31:0] data_in,
    input wire str,
    input wire [1:0] byte_masking,
    output reg [31:0] data_out
  );
  
  parameter depth=2**addwidth;
  reg [width-1:0]mem[0:depth-1];
  
  always @(posedge clk) begin 
    if (str) begin
      case(byte_masking)
        2'b00:mem[0][7:0]<=data_in[7:0];
        2'b01:mem[0][15:8]<=data_in[15:8];
        2'b10:mem[0][23:16]<=data_in[23:16];
        2'b11:mem[0][31:24]<=data_in[31:24];
      endcase
  	end
  end
  initial begin
    $readmemh("/home/merllab/tangNanoCore/TEST/assembly/fabonacci.mem",mem);
  end
  assign data_out=mem[address];
endmodule

