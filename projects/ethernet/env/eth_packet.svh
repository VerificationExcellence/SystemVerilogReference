//--------------------
// Defines the packet class
//--------------------
class packet_c;

  rand bit[31:0]  src_addr;
  rand bit[31:0]  dst_addr;
  rand byte[] pkt_data;
  bit [31:0]  pkt_crc;

  //constraints for small/large/medium packets
  //TBD

  //constraints for data patterns
  // fixed pattern
  // random pattern
  // incrementing pattern
  //TBD


 function compute_crc();
   //TBD
 endfunction

 function post_randomize();
   compute_crc();
 endfunction


endclass
