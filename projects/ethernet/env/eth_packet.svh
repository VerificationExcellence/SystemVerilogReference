//--------------------
// Defines the packet class
//--------------------
class eth_packet_c;

  rand bit[31:0]  src_addr;
  rand bit[31:0]  dst_addr;
  rand byte pkt_data[];
  bit [31:0]  pkt_crc;

  int pkt_size_bytes;
  byte pkt_full[];

  //constraints for small/large/medium packets

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
   pkt_size_bytes = pkt_data.size() + 4+4+4; //data byes + 4B src +4B dest + 4B CRC
   pkt_full = new[pkt_size_bytes];
   for(int i=0; i < 4; i++) begin
       pkt_full[i] = src_addr >> i*8;  //0 to 3 bytes SA
       pkt_full[i+4] = dst_addr >> (i-4)*8; //4 to 7 bytes DA
       pkt_full[i+4+pkt_data.size] = pkt_crc >> (i-4)*8; //last 4 bytes CRC
   end
   //Actual Data bytes
   for(int i=0; i < pkt_data.size; i++) begin
       pkt_full[i+8] = pkt_data[i];
   end
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
