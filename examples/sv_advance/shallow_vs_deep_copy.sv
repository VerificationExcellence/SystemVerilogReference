//--------------------------
// SV Shallow copy vs. Deep copy
// Mayur Kubavat
//--------------------------


//--------------------
// Shallow copy
//--------------------
class Preamble;

   bit [7:0] value;

endclass //Preamble


class Packet;

   int data;

   Preamble pr1 = new();

endclass //Packet


//--------------------
// Deep copy
//--------------------
class PreambleDC;

   bit [7:0] value;

   // to perform deep copy on PreambleDC
   function PreambleDC copy();

      // Create class object
      // copy is handle of class PreambleDC
      // copy value field to the object and return the 
      // object handle(copy)
      copy = new();
      copy.value = this.value;

   endfunction

endclass //PreambleDC


class PacketDC;

   int data;

   PreambleDC pr1 = new();

   function PacketDC copy();

      // copy is handle of class PacketDC
      // and copy data to the object
      copy = new();
      copy.data = this.data;

      // call to copy method of PreambleDC creates and return 
      // objects of PreambleDC 
      copy.pr1 = pr1.copy();

   endfunction

endclass //PacketDC
   


//--------------------
// module to test
//--------------------
module test;


   // Copy method not implemented in Packet/Premable class
   Packet pkt1, pkt2;

   // Copy method implemented for deep copy
   PacketDC pkt_dc1, pkt_dc2;
      
   
   initial
   begin
   
      $display("\n\n\tShallow copy..");
   
      // Create packet 1
      pkt1 = new();
      pkt1.data = 'hFFFF;
      pkt1.pr1.value = 'hAA;
   
      // Performs shallow copy
      pkt2 = new pkt1;

      pkt2.data = 'hCCCC;

      // pkt1 and pkt2 points to same object of Preamble class: pkt2 = new pkt1
      // Updating sub-class field(Preamble::value) in pkt2 changes pkt1 sub-class field
      pkt2.pr1.value = 'h55; 
   
      $display("\tPacket 1: Data %h, Preamble %h", pkt1.data, pkt1.pr1.value);
      $display("\tPacket 2: Data %h, Preamble %h\n", pkt2.data, pkt2.pr1.value);
   
   
      $display("\tDeep copy..");
      
      // Create packet 1
      pkt_dc1 = new();
      pkt_dc1.data = 'hFFFF;
      pkt_dc1.pr1.value = 'hAA;
   
      // Performs deep copy
      pkt_dc2 = pkt_dc1.copy();

      pkt_dc2.data = 'hCCCC;
      pkt_dc2.pr1.value = 'h55;
   
      $display("\tPacket 1: Data %h, Preamble %h", pkt_dc1.data, pkt_dc1.pr1.value);
      $display("\tPacket 2: Data %h, Preamble %h\n\n", pkt_dc2.data, pkt_dc2.pr1.value);
   
   end

endmodule //test

