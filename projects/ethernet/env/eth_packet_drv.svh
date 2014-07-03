//----------------
//Packet driver class
//----------------
typedef eth_packet_c;
class eth_packet_drv_c;

  //Use a virtual interface that points to same interface
  virtual interface eth_sw_if  rtl_intf;

  //Use a mailbox to receive packets from generator
  mailbox mbx_input;

  function new (mailbox mbx, virtual interface eth_sw_if intf);
     mbx_input = mbx;
     this.rtl_intf = intf;
  endfunction

  //Implement a function that can drive the design interface signals
  //as per the packet fields
  task run;
    eth_packet_c pkt;
    forever begin
      pkt = mbx_input.get();
      $display("Got packet = %s", pkt.to_string());
      drive_pkt(pkt);
    end
  endtask

  task drive_pkt(eth_packet_c pkt);
    //Get the packet DA
    //Find which port to drive
    //Drive signals as per protocol on that packet
  endtask

endclass
