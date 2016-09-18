class counter_trans;

	rand bit [3:0] data;
	rand bit rst;
	rand bit load;
	rand bit updown;

	bit [3:0] data_out;

	static int trans_id;


	//Constraints to control frequency of reset and load
	constraint r1{rst dist {0:=50, 1:=1};}
	constraint l1{load dist {0:=20, 1:=1};}

	function void post_randomize();
		this.display("RANDOMIZED DATA");
	endfunction

	function void display(string message);
		$display("-------------------------------------------------");
		$display("%s",message);
		$display("\tTransaction ID: %d", trans_id);
		$display("\tRESET = %d\n\tLOAD = %d\n\tUP-DOWN = %d\n\tDATA = %d", rst, load, updown, data);
		$display("-------------------------------------------------");
	endfunction

	function bit compare(counter_trans rcvd);
		compare = 1'b1;
		if(this.data_out != rcvd.data_out)
		begin
			compare = 1'b0;
			$display("DATA MISMATCH");
			$display(this.data_out, " != ", rcvd.data_out);
			$stop;
		end
	endfunction

endclass: counter_trans

