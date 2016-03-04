//----------------------------------------------
//Round Robin Arbiter
//----------------------------------------------
module rr_arbiter (
  input logic reset,
  input logic clk,
  input logic[3:0] req,
  output logic[3:0] grant
  );
  
  logic [1:0] arb_counter;
  
  always@(posedge clk) begin
    if(reset) begin
      arb_counter <=0;
      grant <=0;
    end else begin
      case (arb_counter) 
        2'b00 :
          if (req[0]) grant = 4'b0001;
          else if (req[1]) grant = 4'b0010;
          else if (req[2]) grant = 4'b0100;
          else if (req[3]) grant = 4'b1000;
          else grant = 4'b0000;
        2'b01 :
		  if (req[1]) grant = 4'b0010;
		  else if (req[2]) grant = 4'b0100;
		  else if (req[3]) grant = 4'b1000;
		  else if (req[0]) grant = 4'b0001;
		  else grant = 4'b0000;
	    2'b10 :
		  if (req[2]) grant = 4'b0100;
		  else if (req[3]) grant = 4'b1000;
		  else if (req[0]) grant = 4'b0001;
           else if (req[1]) grant = 4'b0010;  
		  else grant = 4'b0000;
	    2'b11 :
		  if (req[3]) grant = 4'b1000;
		  else if (req[0]) grant = 4'b0001;
		  else if (req[1]) grant = 4'b0010;
		  else if (req[2]) grant = 4'b0100;
		  else grant = 4'b0000;
   	  endcase // case(req)
      arb_counter <= arb_counter+1;
    end
  end


endmodule
