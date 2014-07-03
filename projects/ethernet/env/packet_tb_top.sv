//----------------------
//Top level module
//----------------------
import packet_tb_env_pkg::*; 

module packet_tb_top;

  wire clk;
  wire resetN;
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
  eth_sw eth_sw(.*);

  //Instantiate the interface
  eth_sw_if  eth_sw_if(.*);

  //Instantiate top level env class
  packet_tb_env_c packet_tb_env;


  initial begin
    //Create env object
    packet_tb_env_c packet_tb_env = new("sample_env", eth_sw_if);
    fork
      begin
        packet_tb_env.run();
      end
    join

  end

endmodule
