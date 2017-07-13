module test;

   bit [3:0] nibble;

   initial
   begin

      repeat(10)
      begin
         void'(std::randomize(nibble));

         $display("Nibble Value is: %0d", nibble);
      end

   end //initial

endmodule //test
