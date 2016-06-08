//---------------
// Example to illustrate usage and behavrior of virtual and non-virtual method
//  - Ramdas (www.verificationexcellence.in)
//--------------
//Base class packet
//--------------
class BasePacket;
  int A = 1;
  int B = 2;

  function void printA;
   $display("BasePacket::A is %d", A);
  endfunction : printA

  virtual function void printB;
    $display("BasePacket::B is %d", B);
  endfunction : printB

endclass : BasePacket

//-------------------
//Derived class packet
//-------------------
class My_Packet extends BasePacket;
   int A = 3; 
   int B = 4; 

   function void printA;
     $display("My_Packet::A is %d", A);
   endfunction: printA

   virtual function void printB;
     $display("My_Packet::B is %d", B);
   endfunction : printB

 endclass : My_Packet

//----------------
// Test
//----------------
module test;

 initial begin
   BasePacket P1;
   My_Packet P2;
   P1 = new;
   P2 = new;
   P1.printA; // displays 'BasePacket::A is 1'
   P1.printB; // displays 'BasePacket::B is 2'
   P1 = P2;   // P1 has a handle to a My_packet object
   P1.printA; // displays 'BasePacket::A is 1'
   P1.printB; // displays 'My_Packet::B is 4' \u2013 latest derived method
   P2.printA; // displays 'My_Packet::A is 3'
   P2.printB; // displays 'My_Packet::B is 4'
 end

endmodule
