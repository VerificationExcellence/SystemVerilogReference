//--------------------------
//Example to illustrate case/casex/casez
// - @ Ramdas M (www.verificationexcellence.in)
//--------------------------
module test;

function void test_casez(logic [2:0] irq);
  logic int0, int1, int2;
  int0=0;
  int1=0;
  int2=0;
  casez (irq) 
    3'b1?? : int2 = 1'b1;
    3'b?1? : int1 = 1'b1;
    3'b??1 : int0 = 1'b1;
  endcase 
  $display("int0=%b int1=%b int2=%b",int0,int1,int2);
endfunction

function void test_casex(logic [2:0] irq);
  logic int0, int1, int2;
  int0=0;
  int1=0;
  int2=0;
  casex (irq) 
    3'b1?? : int2 = 1'b1;
    3'b?1? : int1 = 1'b1;
    3'b??1 : int0 = 1'b1;
  endcase 
  $display("int0=%b int1=%b int2=%b",int0,int1,int2);
endfunction
