class counter_wr_mon;

	virtual counter_if.WR_MON wrmon_if;

	mailbox #(counter_trans) wrmon2rm;

	counter_trans trans_h, wrmon2rm_h;

	function new(	virtual counter_if.WR_MON wrmon_if,
			mailbox #(counter_trans) wrmon2rm);
		this.wrmon_if = wrmon_if;
		this.wrmon2rm = wrmon2rm;
		this.trans_h = new;
	endfunction

	task monitor();
		@(wrmon_if.wrmon_cb)
		begin
			trans_h.rst = wrmon_if.wrmon_cb.rst;
			trans_h.load = wrmon_if.wrmon_cb.load;
			trans_h.updown = wrmon_if.wrmon_cb.updown;
			trans_h.data = wrmon_if.wrmon_cb.data;
			trans_h.display("DATA FROM WRITE MONITOR");
		end
	endtask

	task start();
		fork
			forever 
			begin
				monitor();
				wrmon2rm_h = new trans_h;
				wrmon2rm.put(wrmon2rm_h);
			end
		join_none
	endtask

endclass: counter_wr_mon

