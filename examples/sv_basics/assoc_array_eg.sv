//----------
// Sample code to illustrate usage of associative arrays
//  - Ramdas M  (www.verificationexcellence.in)
//----------
module test;

//Associative array indexed with integer
function void test_assoc_array();
  //An associative array of integers indexed with some string
  int assoc_test[string];
  string indx;
  assoc_test["A"] = 1; 
  assoc_test["B"] = 2; 
  assoc_test["C"] = 3; 
  if(assoc_test.first(indx)) begin
    do begin
      $display("assoc_test[%s]=%0d",indx,assoc_test[indx]);
    end while (assoc_test.next(indx));
  end  
endfunction

initial begin
  test_assoc_array();
end

endmodule
