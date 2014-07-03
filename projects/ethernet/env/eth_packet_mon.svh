//---------------------
// Monitor class
//---------------------
class eth_packet_mon_c;

 //Virtual interface to sample signals
 virtual interface eth_sw_if  rtl_intf;

 //Use a mailbox to put the packets monitored on both input
 //Mailbox 0 => packets seen on input port A
 //Mailbox 1 => packets seen on input port B
 //Mailbox 2 => packets seen on output port A
 //Mailbox 3 => packets seen on output port B
 mailbox mbx_out[4];

 //constructor
 function new(mailbox mbx[4], virtual interface eth_sw_if rtl_intf);
   this.mbx_out = mbx;
   this.rtl_intf = rtl_intf;
 endfunction

 //Method to sample signal on a port and then
 //create a packet class and print it and put it to the mailbox
 task run;
   fork
     sample_portA_input_pkt();
     sample_portA_output_pkt();
     sample_portB_input_pkt();
     sample_portB_output_pkt();
   join
 endtask

 task sample_portA_input_pkt();
 endtask
 task sample_portA_output_pkt();
 endtask
 task sample_portB_input_pkt();
 endtask
 task sample_portB_output_pkt();
 endtask

endclass
