//----------------------
//Top level module
//----------------------
`include "packet_tb_env.svh"
`include "eth_sw_if.svh"

import packet_tb_env_pkg::*; 

module packet_tb_top;

  reg clk;
  reg resetN;
  wire [31:0] inDataA; //Port A input data, start and end of packet pulses
  wire inSopA;
  wire inEopA;
  wire [31:0] inDataB;
  wire inSopB;
  wire inEopB;
  wire [31:0] outDataA; //output Data and Sop and Eop packet pulses
  wire outSopA;
  wire outEopA;
  wire [31:0] outDataB; 
  wire outSopB;
  wire outEopB;
  wire portAStall; //Backpressure or stall signals on portA/B
  wire portBStall;

  //Instantiate DUT
  eth_sw eth_sw1(
  .clk(clk),
  .resetN(resetN),
  .inDataA(inDataA), 
  .inSopA(inSopA),
  .inEopA(inEopA),
  .inDataB(inDataB),
  .inSopB(inSopB),
  .inEopB(inEopB),
  .outDataA(outDataA),
  .outSopA(outSopA),
  .outEopA(outEopA),
  .outDataB(outDataB), 
  .outSopB(outSopB),
  .outEopB(outEopB),
  .portAStall(portAStall),
  .portBStall(portBStall)
 );

  //Instantiate the interface
  eth_sw_if  eth_sw_if1(
  .clk(clk),
  .resetN(resetN),
  .inDataA(inDataA), 
  .inSopA(inSopA),
  .inEopA(inEopA),
  .inDataB(inDataB),
  .inSopB(inSopB),
  .inEopB(inEopB),
  .outDataA(outDataA),
  .outSopA(outSopA),
  .outEopA(outEopA),
  .outDataB(outDataB), 
  .outSopB(outSopB),
  .outEopB(outEopB),
  .portAStall(portAStall),
  .portBStall(portBStall)
);

  //Instantiate top level env class
  packet_tb_env_c packet_tb_env;

  always begin
    #5 clk = ~clk;
  end

  initial begin
    resetN=0;
    clk=0;
    repeat (5) @(posedge clk);
    resetN=1;
    //Create env object
    packet_tb_env = new("sample_env", eth_sw_if1);
    $display("Created Packet TB Env");
    fork
      begin
        packet_tb_env.run();
      end
    join
  end

endmodule
