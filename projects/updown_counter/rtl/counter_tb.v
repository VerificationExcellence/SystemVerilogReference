module tb;

	reg clk, rst, load;
	reg updown;
	reg [3:0] data;

	wire [3:0] data_out;

	counter c(clk, rst, data, updown, load, data_out);

	//Generate Clock
	initial
	begin
		clk = 0;
		forever #10 clk = ~clk;
	end

	//Reset
	task reset_t;
	begin
		rst = 0;
		@(negedge clk)
		rst = 1;
		@(negedge clk)
		rst = 0;
	end
	endtask

	//Load
	task load_t;
	input [3:0] data_in;
	begin
		@(negedge clk)
		load = 1;
		data = data_in;
		@(negedge clk)
		load = 0;
	end
	endtask

	initial
	begin
		reset_t;
		updown = 1;
		#200;
		load_t(7);
		#200;
		load_t(15);
		#200;
		updown = 0;
		load_t(0);
		#200;
		#200 $stop;
	end

endmodule

