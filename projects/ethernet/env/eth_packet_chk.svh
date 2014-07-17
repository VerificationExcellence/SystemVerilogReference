//--------------
//Packet checker class
//--------------
typedef eth_packet_c ;
class eth_packet_chk_c ;

 //Use four mailboxes to see what packets goes in and comes out
 //Mailbox 0 => packets seen on input port A
 //Mailbox 1 => packets seen on input port B
 //Mailbox 2 => packets seen on output port A
 //Mailbox 3 => packets seen on output port B
  mailbox mbx_in[4];

  //For each port - get  a packet form input port.
  //Then call Function 1 (generateExpectedPkt)  and generate expected packets (Maintain 2 expected packet queue for 2 ports)

  //queue of expected packets on port A and B
  eth_packet_c exp_pkt_A_q[$];
  eth_packet_c exp_pkt_B_q[$];

  function new(mailbox mbx[4]);
    for(int i=0;i<4;i++) begin
      this.mbx_in[i] = mbx[i];
    end
  endfunction

  //--------------------
  //Main evaluation task
  //4 threads - 2 of them keeps getting packets on port A and processes them to generate expected packet in A/B queue
  //          - 2 of them keeps getting packets seen on output ports A and B and compares/checks agains expected packet Q
  //--------------------
  task run;
    $display("packet_chk::run() called");
      fork
         get_and_process_pkt(0);
         get_and_process_pkt(1);
         get_and_process_pkt(2);
         get_and_process_pkt(3);
      join_none
  endtask

  task get_and_process_pkt(int port);
    eth_packet_c pkt;
    $display("packet_chk::process_pkt on port=%0d called", port);
    forever begin
      mbx_in[port].get(pkt);
      $display("time=%0t packet_chk::got packet on port=%0d packet=%s",$time, port, pkt.to_string());
      if(port <2) begin //input packets
        gen_exp_packet_q(pkt);
      end else begin //output packets
        chk_exp_packet_q(port, pkt);
      end
    end
  endtask

  function void gen_exp_packet_q(eth_packet_c pkt);
    if(pkt.dst_addr == `PORTA_ADDR) begin
        exp_pkt_A_q.push_back(pkt);
    end else if(pkt.dst_addr == `PORTB_ADDR) begin
        exp_pkt_B_q.push_back(pkt);
    end else begin
        $error("Illegal Packet received");
    end
   endfunction

   function void chk_exp_packet_q(int port, eth_packet_c pkt);
     eth_packet_c exp;
     if(port==2) begin
       exp = exp_pkt_A_q.pop_front();
     end else if (port==3) begin
       exp = exp_pkt_B_q.pop_front();
     end
     if(pkt.compare_pkt(exp)) begin
       $display("Packet on port 2 (output A) matches");
     end else begin
       $display("Packet on port 2 (output A) mismatches");
     end
   endfunction

endclass
