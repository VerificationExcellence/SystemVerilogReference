class counter_wr_bfm;

	virtual counter_if.WR_BFM wr_if;

	mailbox #(counter_trans) gen2wr;

	counter_trans trans_h;

	function new(	virtual counter_if.WR_BFM wr_if,
			mailbox #(counter_trans) gen2wr);
		this.wr_if = wr_if;
		this.gen2wr = gen2wr;
		this.trans_h = new;
	endfunction

	task drive();
		@(wr_if.wr_cb);
			wr_if.wr_cb.rst <= trans_h.rst;
			wr_if.wr_cb.load <= trans_h.load;
			wr_if.wr_cb.updown <= trans_h.updown;
			wr_if.wr_cb.data <= trans_h.data;
	endtask

	task start();
		fork
			forever
			begin
				gen2wr.get(trans_h);
				drive();
			end
		join_none
	endtask

endclass: counter_wr_bfm

