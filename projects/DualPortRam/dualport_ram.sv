//A synchronous dual port RAM that has two ports
//One port for reading while one port for writing with seperate address
//One data input port for writes
//One data output port for reads
//Memory contents are not initialized

module dual_port_ram(
              input  logic           clock       ,       // Clock
              input  logic  [7:0]    data_in     ,       // input data
              output logic  [7:0]    data_out    ,       // Output data
              input  logic           write_en    ,       // 1 => write port enabled
               input  logic  [7:0]   write_address ,     // Memory Write port address
              input  logic           read_en,            // 1 => read port enabled
              input  logic  [7:0]    read_address       // Memory Read port address
              );
 

//Memory array 
logic [7:0] mem [255:0];
 
//If enabled, write to the memory array
always @ (posedge clock)
begin
  if(write_en)                      //Write port
    mem[write_address] = data_in;
  if(read_en)                       //Read port
    data_out = mem[read_address];
end
 
endmodule
