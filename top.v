module top(
    input wire clk,
    input wire reset,
    input wire send,
    input rx,
    output reg [5:0]led,
    output reg tx
);


wire [31:0]rdata;


single_cycle core(
    .clk(clk),
    .reset(reset),
    .data(rdata)
);
uart uart(
    .clk(clk),
    .uart_rx(rx),
    .uart_tx(tx),
    .led(led),
    .send(send)
);

// always @(posedge clk ) begin
//     led<=rdata[5:0];
// end
    
endmodule
