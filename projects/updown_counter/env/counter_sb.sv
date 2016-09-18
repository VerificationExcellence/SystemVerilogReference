class counter_sb;
	
	mailbox #(counter_trans) rm2sb, rdmon2sb;

	event DONE;

	int count_transaction, data_verified;

	counter_trans cov_h, rcvd_h;

	covergroup counter_cov;
		option.per_instance = 1;
		RST: coverpoint cov_h.rst {bins r[] = {0,1};}
		LD: coverpoint cov_h.load {bins l[] = {0,1};}
		UD: coverpoint cov_h.updown {bins ud[] = {0,1};}
		DATA: coverpoint cov_h.data {bins d[] = {[0:15]};}
		DOUT: coverpoint cov_h.data_out {bins dout[] = {[0:15]};}

		LDxDATA: cross LD, DATA;
		UDxDOUT: cross UD, DOUT;
		RSTxLDxDATA: cross RST, LD, DATA;
		RSTxLDxUD: cross RST, LD, UD;
	endgroup

	function new(mailbox #(counter_trans) rm2sb, mailbox #(counter_trans) rdmon2sb);
		this.rm2sb = rm2sb; 
		this.rdmon2sb = rdmon2sb;
		counter_cov = new();		
	endfunction
	
	task start;
		fork
			forever
			begin
				rm2sb.get(rcvd_h);
				cov_h = rcvd_h;
				counter_cov.sample();
			      //--------------------//	
				rdmon2sb.get(cov_h);
				check(rcvd_h);
			end
		join_none
	endtask

	task check(counter_trans rcvd_h);
		
		count_transaction++;
			
		if(cov_h.compare(rcvd_h))
		begin
			counter_cov.sample();
			data_verified++;
		end
		
		if(count_transaction >= no_of_transaction)
			->DONE;
	endtask

	function void report;
		$display("--------------SCOREBOARD REPORT----------------");
		$display("Number of transactions received : %0d", count_transaction);
		$display("Number of transactions verified : %0d", data_verified);
		$display("-----------------------------------------------");
	endfunction

		
		

endclass :counter_sb
