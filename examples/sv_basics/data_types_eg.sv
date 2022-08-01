//------------------------------------
// This will be a stand alone module that illustrates usages of several of
// SV basic data types and usages
// This can be compiled as a stand alone file
// Students can experiment  by compiling and simulating this file
// and observing the behavior
//   @ - Ramdas M
//------------------------------------
module test;

//bit vs logic difference
task test_bit_logic;
  bit req_bit_valid;
  logic req_logic_valid;
  byte req_attr;
  $display("req_bit_valid=%b req_logic_valid=%b req_attr=%h",req_bit_valid, req_logic_valid,req_attr);
  req_logic_valid = 'bz; 
  req_bit_valid = 'b1; 
  $display("req_bit_valid=%b req_logic_valid=%b",req_bit_valid, req_logic_valid);
endtask

//demo for user defined types
task test_user_defined_types;
 typedef longint unsigned uint64;
 uint64 abc; 
 abc = 64'hFFFFFFFFFFFFFFFF;
 $display("uint64 abc = %h",abc);
endtask

//----------------------
// Illustrate equality operator difference
//-----------------------
task test_equality_operator;
  logic [2:0] abc, def; 
  logic eq;
  abc= 3'b01x;
  def= 3'b01x;
  if(abc == def) begin
    $display(" abc and def equal (==) eq=%b ",(abc==def));
  end else begin
   $display(" abc and def not equal (==) eq=%b", (abc==def));
  end  
  if(abc === def) begin
    $display(" abc and def equal (===) eq=%b ",(abc===def));
  end else begin
    $display(" abc and def not equal (===)");
  end  
endtask

//----------------------------
//Run the examples to see diff
//----------------------------
initial begin
  test_bit_logic();
  test_user_defined_types();
  test_equality_operator();
end

endmodule
