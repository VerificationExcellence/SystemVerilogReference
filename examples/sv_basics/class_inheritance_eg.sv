//--------------------------
//Demo for illustrating Class inheritance concepts
// Ramdas M (www.verificationexcellence.in)
//--------------------------
class Packet;

  bit[31:0] src_addr;   //public
  bit[31:0] dst_addr;   //public
  protected bit[2:0] pkt_type; //protected
  local bit pkt_generated;  //local visibility

  function new();
    //Initialize all variables
  endfunction

  //Write methods to access packet type from outside class

  //Write a method that can set a given value to all data members
  function void set_pkt_contents();
  endfunction

endclass

//--------------------
// Derived class with error bit set
//--------------------
class  ErrPacket extends Packet;
  protected bit err;

  //Redefine the base class method set_pkt_contents to set error bit

endclass

//---------------
// Module to test
//---------------
module test;

 initial begin
   Packet pkt;
   ErrPacket err_pkt;
   err_pkt = new();
//   $display("packet type=%h", err_pkt.pkt_type);  //Error as protected
   $display("packet src=%h", err_pkt.src_addr);  //OK as public
//   $display("packet generated=%b", err_pkt.pkt_generated); //Error as local to class
 end

 initial begin
   Packet pkt;
   Packet pkt1;
   ErrPacket err_pkt;
   ErrPacket err_pkt1;
   bit success;
   err_pkt = new(); //derived class object
   pkt = err_pkt;   //ok to assign to base class object
   success = $cast(err_pkt1, pkt); //since base class handle
               //is referring to derived class object, ok to assign to another derived class obj
   $display("success= %b err_pkt1.src_addr=%h  err_pkt.src_addr=%h", success, err_pkt1.src_addr, err_pkt.src_addr);
   pkt1 = new(); //base class object
   success = $cast(err_pkt1, pkt1); //since base class handle is referring to derived class object, ok to assign to another derived class obj
   $display("success= %b attempt to cast base class object to a derviced class handle", success);
 end

endmodule

