class counter_rd_mon;

	virtual counter_if.RD_MON rdmon_if;

	mailbox #(counter_trans) rdmon2sb;

	counter_trans trans_h;
	counter_trans rd2sb_h;

	function new(	virtual counter_if.RD_MON rdmon_if,
			mailbox #(counter_trans) rdmon2sb);
		this.rdmon_if = rdmon_if;
		this.rdmon2sb = rdmon2sb;
		trans_h = new;
	endfunction

	task monitor();
		@(rdmon_if.rdmon_cb)
			trans_h.data_out = rdmon_if.rdmon_cb.data_out;
			if($isunknown(rdmon_if.rdmon_cb.data_out))
				trans_h.data_out = 0;
	endtask

	task start();
		fork
			forever
			begin
				monitor();
				trans_h.display("DATA FROM READ MONITOR");
				rd2sb_h = new trans_h;
				rdmon2sb.put(rd2sb_h);
			end
		join_none
	endtask

endclass: counter_rd_mon

