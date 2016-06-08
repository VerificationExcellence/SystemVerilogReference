//---------------------
//A simple ethernet packet class
//Example for class definition, members
// Creating objects
// @ Ramdas M  (www.verificationexcellence.in)
//---------------------
class eth_packet_c;

  bit[31:0]  src_addr;
  bit[31:0]  dst_addr;
  byte pkt_data[$];
  bit [31:0]  pkt_crc;

  int pkt_size_bytes;
  byte pkt_full[$];

  function new();
  endfunction

  function void fill_pkt_data();
    int pkt_data_size;
    pkt_data_size = $urandom_range(8,24);
    //make it dword aligned (multiple of 4)
    pkt_data_size = (pkt_data_size >> 2) <<2; 
    for(int i=0; i < pkt_data_size;i++) begin
      pkt_data.push_back($urandom());
    end  
  endfunction

  function bit[31:0] compute_crc();
    //TBD
    return 'hABCDDEAD;
  endfunction
function void fill_pkt_crc();
    pkt_crc =  compute_crc();
    pkt_size_bytes = pkt_data.size() + 4+4+4; //data byes + 4B src +4B dest + 4B CRC
    for(int i=0; i < 4; i++) begin
      pkt_full.push_back( dst_addr >> i*8);  //0 to 3 bytes DA
    end
    for(int i=0; i < 4; i++) begin
      pkt_full.push_back(src_addr >> i*8); //4 to 7 bytes SA
    end
    //Actual Data bytes
    for(int i=0; i < pkt_data.size; i++) begin
      pkt_full.push_back(pkt_data[i]);
     end
    for(int i=0; i < 4; i++) begin
      pkt_full.push_back(pkt_crc >> i*8); //last 4 bytes CRC
    end
  endfunction

  //return a string that prints all fields
  function string to_string();
    string msg;
    msg = $psprintf("sa=%x da=%x crc=%x",src_addr,dst_addr, pkt_crc);
    return msg;
  endfunction

 //Compare two packets
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

//-------------------------------
//Create instances of packet class
//---------------------------------
module test;

 initial begin
   eth_packet_c pkt;
   for(int i=0; i <10; i++) begin
     //what happens if new is outside for loop? why?
     pkt = new();
     $display("i=%0d pkt=%s", i,pkt.to_string());
   end
 end

endmodule
