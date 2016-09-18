class counter_gen;

	counter_trans trans_h;
	counter_trans trans2wr_h;

	mailbox #(counter_trans) gen2wr;

	function new(mailbox #(counter_trans) gen2wr);
		this.gen2wr = gen2wr;
		trans_h = new;
	endfunction

	virtual task start();
		fork
		begin
				trans_h.trans_id++;
				trans_h.load = 1;
				trans_h.data = 0;
				trans2wr_h = new trans_h;
				gen2wr.put(trans2wr_h);

			for(int i = 0; i < (no_of_transaction - 1); i++)
			begin
				trans_h.trans_id++;
				assert(trans_h.randomize());
				trans2wr_h = new trans_h;
				gen2wr.put(trans2wr_h);
			end
		end
		join_none
	endtask

endclass: counter_gen
