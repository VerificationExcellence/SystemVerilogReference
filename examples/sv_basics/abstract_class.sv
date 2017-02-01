//---------------------------------
// Abstract/Virtual Class
// Abstract class is generic class which is used by extnded 
// classes, primary role is to define set of common methods. 
// For e.g. uvm_object class in UVM BCL is abstract class.
//
// - Mayur Kubavat
//---------------------------------


module test;

	virtual class A;

		virtual function void my_display();
			$display("PROTOTYPE");
		endfunction
	endclass

	class B extends A;
		virtual function void my_display();
			$display("Hello! from B");
		endfunction
	endclass


	A a_h;
	B b_h;

	initial
	begin
		b_h = new();
		b_h.my_display();

		a_h = b_h;
		a_h.my_display();
	end


endmodule //test
