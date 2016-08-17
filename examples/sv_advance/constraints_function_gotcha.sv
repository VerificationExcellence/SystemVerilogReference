
class constraints_gotcha;
	
	rand bit[7:0] a;
	
	function int get(bit[7:0] x);
		return x;
	endfunction
	
	constraint c1{	
		get(a) inside {[50:200]}; // Gotcha - Intended value a inside 50..200
	}

endclass
	
module top;

	constraints_gotcha cg_h;
	
	initial
	begin
		cg_h = new();
		
		repeat(10)
		begin
			assert(cg_h.randomize());
			$display("Value of a = %0d", cg_h.a);
		end
		
		$finish;
	end
	
endmodule
