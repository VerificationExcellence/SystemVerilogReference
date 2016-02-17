//-------------------------------------------------------
//Synchronous FIFO with depth of 32 and width of 16 bits
//Defines can be changed to vary depth and width
//-------------------------------------------------------
`define FIFO_WIDTH 16  //width of each location
`define FIFO_SIZE_BITS 5  //5 bits for counter => 32 deep FIFO
`define FIFO_SIZE ( 1<<`FIFO_SIZE_BITS)

//FIFO ports
module sync_fifo(
  input logic  reset,
  input logic clk,
  input logic write,
  input logic read,   
  input logic [`FIFO_WIDTH-1:0] data_in,                  
  output logic [`FIFO_WIDTH-1:0] data_out,                  
  output logic fifo_empty,
  output logic fifo_full,      
  output logic [`FIFO_SIZE_BITS-1:0] fifo_counter
);             

  //rd and wr pointer for internally writing/read from memory
  logic[`FIFO_SIZE_BITS-1] wr_ptr;
  logic[`FIFO_SIZE_BITS-1] rd_ptr;
  
  //fifo array
  logic [`FIFO_WIDTH-1:0] fifo_mem [`FIFO_SIZE-1:0];
  
  
always @(fifo_counter)
begin
  fifo_empty = (fifo_counter==0);
  fifo_full = (fifo_counter== `FIFO_SIZE);
end

always @(posedge clk or posedge reset)
begin
  if( reset )
     fifo_counter <= 0;
  //write and read happening same clk
  else if( (!fifo_full && write) && ( !fifo_empty && read) )
     fifo_counter <= fifo_counter;
  //write only
  else if( !fifo_full && write)
     fifo_counter <= fifo_counter + 1;
  //read only
  else if( !fifo_empty && read )
     fifo_counter <= fifo_counter - 1;
  else
     fifo_counter <= fifo_counter;
end

always @( posedge clk or posedge reset)
begin
  if( reset )
    data_out <= 0;
  else
  begin
    if( read && !fifo_empty )
      data_out <= fifo_mem[rd_ptr];
    else
      data_out <= data_out;
   end
end

always @(posedge clk)
begin
  if( write && !fifo_full )
    fifo_mem[wr_ptr] <= data_in;
  else
    fifo_mem[wr_ptr] <= fifo_mem[wr_ptr];
end

always@(posedge clk or posedge reset)
begin
  if( reset )
   begin
      wr_ptr <= 0;
      rd_ptr <= 0;
   end
   else
   begin
     if( !fifo_full && write )    
       wr_ptr <= wr_ptr + 1;
     else  wr_ptr <= wr_ptr;

     if( !fifo_empty && read )
       rd_ptr <= rd_ptr + 1;
     else
       rd_ptr <= rd_ptr;
   end
end
  
endmodule
