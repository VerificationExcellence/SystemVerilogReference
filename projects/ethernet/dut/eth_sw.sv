//-------------------------
// DUT for testing an ethernet switch example
//-------------------------
module eth_sw(
  input clk,
  input resetN,
  input [31:0] inDataA, //Port A input data, start and end of packet pulses
  input inSopA,
  input inEopA,
  input [31:0] inDataB,
  input inSopB,
  input inEopB,
  ouput [31:0] outDataA, //output Data and Sop and Eop packet pulses
  output outSopA,
  output outEopA,
  ouput [31:0] outDataB, 
  output outSopB,
  output outEopB,
  output portAStall, //Backpressure or stall signals on portA/B
  output portBStall

);


endmodule : eth_sw
