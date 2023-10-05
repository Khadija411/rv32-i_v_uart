// memory
module memory#(parameter width=32, parameter addwidth=12)
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
  
//   data memory
  // assign byte_masking = address[addwidth-1 : addwidth- 2];
//   load
  assign data_out=mem[address];
  always @(posedge clk) begin 
//    store
    if (str) begin
      mem[address]<=data_in;
      case(byte_masking)
        2'b00:mem[address][7:0]<=data_in[7:0];
        2'b01:mem[address][15:8]<=data_in[15:8];
        2'b10:mem[address][23:16]<=data_in[23:16];
        2'b11:mem[address][31:24]<=data_in[31:24];
        default:mem[address]<=data_in;
      endcase
  	end
  end
endmodule

