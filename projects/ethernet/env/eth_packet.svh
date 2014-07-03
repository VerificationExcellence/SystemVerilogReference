//--------------------
// Defines the packet class
//--------------------
class eth_packet_c;

  rand bit[31:0]  src_addr;
  rand bit[31:0]  dst_addr;
  rand byte pkt_data[];
  bit [31:0]  pkt_crc;

  //constraints for small/large/medium packets
  //TBD

  //constraints for data patterns
  // fixed pattern
  // random pattern
  // incrementing pattern
  //TBD

 function new();
 endfunction

 function bit[31:0] compute_crc();
   //TBD
 endfunction

 function void post_randomize();
   pkt_crc =  compute_crc();
 endfunction

 //return a string that prints all fields
 function string to_string();
   string msg;
   msg = $sformat("sa=%x da=%x crc=%x",src_addr,dst_addr, pkt_crc);
   return msg;
 endfunction

 function bit compare_pkt(eth_packet_c pkt);
   if((this.src_addr==pkt.src_addr) &&
     (this.dst_addr==pkt.dst_addr) &&
     (this.pkt_crc==pkt.pkt_crc) &&
     is_data_match(this.pkt_data, pkt.pkt_data)) begin
      return 1'b1;
   end
      return 1'b0;
 endfunction

 function bit is_data_match(byte data1[], byte data2[]);
   return 1'b1; //TBD
 endfunction

endclass : eth_packet_c
