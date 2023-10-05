//Branch unit
module Branch(
  input wire [31:0]A, 
  input wire [31:0]B,
  input wire [2:0]fun3,
  input wire en,
  output reg res
);
  
	always @(*) begin
    if (en) begin
      case (fun3)
  	    3'b000: begin//beq
  	      if(A==B)
            res=1;
          else res=0;
  	    end
  	    3'b001: begin//bne
          if (A!=B)
             res=1;
          else res=0;
  	    end
  	    3'b100:begin//blt
          if (A<B)
             res=1;
          else res=0;
  	    end
  	    3'b101: begin//bge
          if (A>=B)
             res=1;
          else res=0;
  	    end
  	    3'b110: begin//bltu
          if (($unsigned (A)) < ($unsigned (B)))
             res=1;
          else res=0;
  	    end
  	    3'b111: begin //bgeu
          if (($unsigned (A)) >= ($unsigned (B)))
             res=1;
          else res=0;
  	    end
  	    default: res=0;
  	  endcase
  	end
    else  res=0;
  end
endmodule  

