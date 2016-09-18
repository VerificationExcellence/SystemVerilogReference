import counter_pkg::*;


class counter_trans_load extends counter_trans;

	randc logic [3:0] data;

	constraint r1 {rst inside {0, 1};}
	constraint l1 {load inside {0, 1};}
	constraint d1{super.data == data;}

endclass

	
class test;
	
	virtual counter_if.WR_BFM wr_if;
	virtual counter_if.WR_MON wrmon_if;
	virtual counter_if.RD_MON rdmon_if;

	counter_env env;

	counter_trans_load trans_ld_h;

	function new(	virtual counter_if.WR_BFM wr_if,
			virtual counter_if.WR_MON wrmon_if,
			virtual counter_if.RD_MON rdmon_if);
		
		this.wr_if = wr_if;
		this.wrmon_if = wrmon_if;
		this.rdmon_if = rdmon_if;

		env = new(wr_if, wrmon_if, rdmon_if);
	endfunction



	task build_and_run;
		if($test$plusargs("TEST1"))
		begin
			no_of_transaction = 250;
			env.build();
			env.run();
			$finish;
		end
		if($test$plusargs("TEST2"))
		begin
			trans_ld_h = new();
			no_of_transaction = 250;
			env.build();
			env.gen_h.trans_h = trans_ld_h;
			env.run();
			$finish;
		end
	endtask

endclass :test
			

	
