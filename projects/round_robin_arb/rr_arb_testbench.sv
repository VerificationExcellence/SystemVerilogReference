//----------------------------
// Testbench for a round robing arbiter
// add assertions
//----------------------------

`include "round_robin_arbiter.svh"
`include "round_robin_assertions.svh"


module  rr_arbiter_test;

  logic [3:0] req;
  logic [3:0] grant;
  logic clk;
  logic reset;
  
  
  rr_arbiter rr_arbiter(.*);
  
  bind rr_arbiter rr_assert_if  asser_inst (.*);
  
  initial begin
    clk=0;
    reset =1;
    #40 reset=0;
  end
    
  //Generate a clock
  always begin
    #10 clk = ~clk;
  end
  
  //-----------
  // Test sequence
  //  Modify this to drive  req in whatever order you want
  //
  //-----------
  initial begin
   for (int count=0; count< 10; count++) begin
      @(posedge clk);
      req = count;
      count++;            
   end
   $finish;  
  end
  
  //Check/monitor
  always @(posedge clk) begin
    if(!reset) begin
      $display("req=%h gnt=%h",req,grant);
    end
  end
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
