class counter_env;

	virtual counter_if.WR_BFM wr_if;
	virtual counter_if.WR_MON wrmon_if;
	virtual counter_if.RD_MON rdmon_if;
	
	mailbox #(counter_trans) gen2wr = new;
	mailbox #(counter_trans) wrmon2rm = new;
	mailbox #(counter_trans) rm2sb = new;
	mailbox #(counter_trans) rdmon2sb = new;

	counter_gen gen_h;
	counter_wr_bfm wr_h;
	counter_wr_mon wrmon_h;
	counter_rd_mon rdmon_h;
	counter_rm rm_h;
	counter_sb sb_h;

	function new(	virtual counter_if.WR_BFM wr_if,
			virtual counter_if.WR_MON wrmon_if,
			virtual counter_if.RD_MON rdmon_if);
		this.wr_if = wr_if;
		this.wrmon_if = wrmon_if;
		this.rdmon_if = rdmon_if;
	endfunction


	task build();
		gen_h = new(gen2wr);
		wr_h = new(wr_if, gen2wr);
		wrmon_h = new(wrmon_if, wrmon2rm);
		rdmon_h = new(rdmon_if, rdmon2sb);
		rm_h = new(wrmon2rm, rm2sb);
		sb_h = new(rm2sb, rdmon2sb);
	endtask

	task reset();
		@(wr_if.wr_cb);
			wr_if.wr_cb.rst <= 1;
		@(wr_if.wr_cb);
		@(wr_if.wr_cb);
		@(wr_if.wr_cb);
		@(wr_if.wr_cb);
		@(wr_if.wr_cb);
			wr_if.wr_cb.rst <= 0;

	endtask

	task start();
		gen_h.start();
		wr_h.start();
		wrmon_h.start();
		rdmon_h.start();
		rm_h.start();
		sb_h.start();
	endtask

	task stop();
		wait(sb_h.DONE.triggered);
	endtask

	task run();
		reset();
		start();
		stop();
		sb_h.report();
	endtask

endclass: counter_env
