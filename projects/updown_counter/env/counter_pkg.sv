package counter_pkg;

	int no_of_transaction;

	`include "counter_trans.sv"
	`include "counter_gen.sv"
	`include "counter_wr_bfm.sv"
	`include "counter_wr_mon.sv"
	`include "counter_rd_mon.sv"
	`include "counter_rm.sv"
	`include "counter_sb.sv"
	`include "counter_env.sv"

endpackage
