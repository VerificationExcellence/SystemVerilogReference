//--------------
//--------------
class eth_packet_chk_c ;

  //Create an input queue - where driver pushes all packets send in
  //

  //Function 1: Take an input packet and write a function that looks at DA 
  //in packet to determine output port
  //Accordingly push into 2 expected output queues - golden

  //Create another queue for output ports that monitor populates
  //Check that this matches the golden queues

  //Use four mailboxes instead of queues
  //For each port - get  a packet form input port. Then call Function 1 and generate expected packets
  //For each port - get a packet from  output port. then call Function 2 and check for correctness
  
endclass
