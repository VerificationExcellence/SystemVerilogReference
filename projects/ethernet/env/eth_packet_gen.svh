//-----------------------------
//Packet generator class
//-----------------------------
typedef eth_packet_c;
class eth_packet_gen_c;

  //Implement a random member for number of packets to be generated
  int num_pkts;

  //Use a mail box and put these generated packets into that
  //This mailbox will be later used by the driver
  mailbox mbx_out;

  function new (mailbox mbx);
    mbx_out =  mbx;
  endfunction

  //Method
  task run;
    eth_packet_c pkt;
    num_pkts = 2; // $urandom_range(2,3);
    for (int i=0; i < num_pkts; i++) begin
      //Create packet , randomize and put to mailbox
      pkt = new();
`ifdef NO_RANDOMIZE
      pkt.build_custom_random();
`else
      assert(pkt.randomize());
`endif
      mbx_out.put(pkt);
    end
  endtask

endclass
