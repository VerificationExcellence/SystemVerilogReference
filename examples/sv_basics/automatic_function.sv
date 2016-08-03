//--------------------------
// Automatic/reentrant function
// Mayur Kubavat
//--------------------------

module test;

   // Automatic functions is re-entrant and have separate
   // function variable scope for each funciton call

   // Module functions are by default static, use automatic 
   // identifier to make function re-entrant
   function automatic int factorial(int num);
      if(num > 1)
         factorial = factorial(num - 1) * num;
      else
         factorial = 1;
   endfunction


   int result;

   initial
   begin
      
      $display("\n\n\tFactorial from 1 to 5..\n");

      for(int i = 0; i < 6; i++)
      begin

         // Function calls itself recursively with different 
         // variable scope for 'int num' each time
         result = factorial(i);

         $display("\t%0d factorial = %0d", i, result);
      end

      $display("\n\tEnd of simulation..\n\n");

   end //initial

endmodule //test
