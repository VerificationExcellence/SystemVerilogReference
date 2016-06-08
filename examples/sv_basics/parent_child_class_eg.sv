//-----------------
// Basic parent child class example
// Ramdas M (www.verificationexcellence.in)
//-----------------
class Packet;
  bit [31:0] addr;
  bit err=0;
  function int get_addr();
  //virtual function int get_addr();
    get_addr = 'hABCD;
  endfunction

endclass

class ErrPacket extends Packet; 
  bit err=1;
  function int get_addr();
    get_addr = 'hCDEF;
  endfunction
endclass

module test;
  initial begin
    Packet p;
    ErrPacket  ep;  
    ep = new();
    p = ep;
    $display("packet addr=%h err=%b", p.get_addr, p.err);
    $display("ep_packet addr=%h err=%b", ep.get_addr, ep.err);
  end  
endmodule
