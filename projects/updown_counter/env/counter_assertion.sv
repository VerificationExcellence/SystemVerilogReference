module counter_assertion(clk, rst, data, updown, load, count);

	input logic clk, rst;
	input logic updown, load;
	input logic [3:0] data, count;


	property reset_prpty;
		@(posedge clk) rst |=> (count == 4'b0);
	endproperty

	sequence up_seq;
		!load && updown;
	endsequence
	
	sequence down_seq;
		!load && !updown;
	endsequence

	property up_count_prpty;
		@(posedge clk) disable iff(rst)
		up_seq |=> (count == ($past(count, 1) + 1'b1));
	endproperty

	property down_count_prpty;
		@(posedge clk) disable iff(rst)
		down_seq |=> (count == ($past(count, 1) - 1'b1));
	endproperty

	property count_Fto0_prpty;
		@(posedge clk) disable iff(rst)
		(!load && updown) && (count == 4'hF) |=> (count == 4'b0);
	endproperty

	property count_0toF_prpty;
		@(posedge clk) disable iff(rst)
		(!load && !updown) && (count == 4'b0) |=> (count == 4'hF);
	endproperty

	property load_prpty;
		@(posedge clk) disable iff(rst)
		load |=> (count == $past(data, 1));
	endproperty




	RST: assert property (reset_prpty);
	UP_COUNT: assert property (up_count_prpty);
	DOWN_COUNT: assert property (down_count_prpty);
	F2O: assert property (count_Fto0_prpty);
	O2F: assert property (count_0toF_prpty);
	LOAD: assert property (load_prpty);

endmodule

