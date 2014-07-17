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
   eth_packet_c pkt;
   int count;
   count=0;
   forever @(posedge rtl_intf.clk) begin
     if(rtl_intf.eth_mon_cb.inSopA) begin
       $display("time=%t packet_mon::seeing Sop on PortA input",$time);
       pkt = new();
       count=1;
       pkt.dst_addr=rtl_intf.eth_mon_cb.inDataA;
     end else if (count==1) begin
       pkt.src_addr=rtl_intf.eth_mon_cb.inDataA;
       count++;
     end else if (rtl_intf.eth_mon_cb.inEopA) begin
       pkt.pkt_crc=rtl_intf.eth_mon_cb.inDataA;
       $display("time=%0t packet_mon: Saw packet on port A input: pkt=%s",$time, pkt.to_string());
       mbx_out[0].put(pkt);
       count=0;
     end else if(count >0) begin
       pkt.pkt_data.push_back(rtl_intf.eth_mon_cb.inDataA);
       count++;
     end
   end
 endtask

 task sample_portA_output_pkt();
   eth_packet_c pkt;
   int count;
   count=0;
   forever @(posedge rtl_intf.clk) begin
     if(rtl_intf.eth_mon_cb.outSopA) begin
       $display("time=%t packet_mon::seeing Sop on PortA output",$time);
       pkt = new();
       count=1;
       pkt.dst_addr=rtl_intf.eth_mon_cb.outDataA;
     end else if (count==1) begin
       pkt.src_addr=rtl_intf.eth_mon_cb.outDataA;
       count++;
     end else if (rtl_intf.eth_mon_cb.outEopA) begin
       pkt.pkt_crc=rtl_intf.eth_mon_cb.outDataA;
       $display("time=%0t packet_mon: Saw packet on port A output: pkt=%s",$time, pkt.to_string());
       mbx_out[2].put(pkt);
       count=0;
     end else if(count >0) begin
       pkt.pkt_data.push_back(rtl_intf.eth_mon_cb.outDataA);
       count++;
     end
   end
 endtask

 task sample_portB_input_pkt();
   eth_packet_c pkt;
   int count;
   count=0;
   forever @(posedge rtl_intf.clk) begin
     if(rtl_intf.eth_mon_cb.inSopB) begin
       $display("time=%t packet_mon::seeing Sop on PortB input",$time);
       pkt = new();
       count=1;
       pkt.dst_addr=rtl_intf.eth_mon_cb.inDataB;
     end else if (count==1) begin
       pkt.src_addr=rtl_intf.eth_mon_cb.inDataB;
       count++;
     end else if (rtl_intf.eth_mon_cb.inEopB) begin
       pkt.pkt_crc=rtl_intf.eth_mon_cb.inDataB;
       $display("time=%0t packet_mon: Saw packet on port B input: pkt=%s",$time, pkt.to_string());
       mbx_out[1].put(pkt);
       count=0;
     end else if(count >0) begin
       pkt.pkt_data.push_back(rtl_intf.eth_mon_cb.inDataB);
       count++;
     end
   end
 endtask

 task sample_portB_output_pkt();
   eth_packet_c pkt;
   int count;
   count=0;
   forever @(posedge rtl_intf.clk) begin
     if(rtl_intf.eth_mon_cb.outSopB) begin
       $display("time=%t packet_mon::seeing Sop on PortB output",$time);
       pkt = new();
       count=1;
       pkt.dst_addr=rtl_intf.eth_mon_cb.outDataB;
     end else if (count==1) begin
       pkt.src_addr=rtl_intf.eth_mon_cb.outDataB;
       count++;
     end else if (rtl_intf.eth_mon_cb.outEopB) begin
       pkt.pkt_crc=rtl_intf.eth_mon_cb.outDataB;
       $display("time=%0t packet_mon: Saw packet on port B output: pkt=%s",$time, pkt.to_string());
       mbx_out[3].put(pkt);
       count=0;
     end else if(count >0) begin
       pkt.pkt_data.push_back(rtl_intf.eth_mon_cb.outDataB);
       count++;
     end
   end
 endtask

endclass
