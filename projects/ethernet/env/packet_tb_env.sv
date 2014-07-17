//-----------------------
//Package for Top level env class
//-----------------------
package packet_tb_env_pkg;

`define NUMPORTS 2
`define PORTA_ADDR 'hABCD
`define PORTB_ADDR 'hBEEF

//Include env components
//You could alternatively wrap them in a package and import as well
`include "eth_packet.svh"
`include "eth_packet_gen.svh"
`include "eth_packet_drv.svh"
`include "eth_packet_mon.svh"
`include "eth_packet_chk.svh"

//Top level env class
class packet_tb_env_c;

  //A name for the env
  string env_name;

  //packet generator object
  eth_packet_gen_c packet_gen;

  //Packet driver
  eth_packet_drv_c packet_driver;

  //Packet Monitor - monitors all ports 
  eth_packet_mon_c packet_mon;

  //Packet checker object
  eth_packet_chk_c packet_checker;
  
  //-------------------
  //Mailboxes for connectivity
  //-------------------
  //Gen to driver connectivity
  mailbox mbx_gen_drv;

  //Mail boxes from monitor to checker
  mailbox mbx_mon_chk[4];

  //Virtual interface
  virtual interface eth_sw_if  rtl_intf;

  //Constructor
  function new(string name , virtual interface eth_sw_if intf);
    this.env_name = name;
    this.rtl_intf = intf;
    //Create a mailbox instance used by driver and gerator to communicate
    mbx_gen_drv =new();
    packet_gen = new(mbx_gen_drv);
    packet_driver = new (mbx_gen_drv,intf);
    //Create monitor and mailbox to connect checker and monitor
    for(int i=0; i < 4; i++) begin
      mbx_mon_chk[i] = new();
      $display("Create mailbox =%0d for mon-check",i);
    end
    packet_mon = new (mbx_mon_chk,intf);
    //Create a checker instance and pass the 4 mailboxes from which it can get packets
    packet_checker = new(mbx_mon_chk);
  endfunction

  //Main evaluation method - run()
  task run();
    //Fork all component run();
    $display("packet_tb_env::run() called");
    fork 
      packet_gen.run();
      packet_driver.run();
      packet_mon.run();
      packet_checker.run();
    join
  endtask

endclass : packet_tb_env_c

endpackage: packet_tb_env_pkg
