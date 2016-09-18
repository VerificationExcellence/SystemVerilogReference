class counter_rm;

	mailbox #(counter_trans) rm2sb, wrmon2rm;

	counter_trans wrmon2rm_h, temp_h;

	int count;

	function new(mailbox #(counter_trans) wrmon2rm, mailbox #(counter_trans) rm2sb);
		this.rm2sb = rm2sb;
		this.wrmon2rm = wrmon2rm;
		temp_h = new();
	endfunction

	task model();
		++count;
		if(count > 1)
		begin
		temp_h.rst = wrmon2rm_h.rst;		
		temp_h.load = wrmon2rm_h.load;		
		temp_h.updown = wrmon2rm_h.updown;		
		temp_h.data = wrmon2rm_h.data;	
			if(wrmon2rm_h.rst)
				temp_h.data_out = 0;
			else if(wrmon2rm_h.load)
				temp_h.data_out = wrmon2rm_h.data;
			else if(wrmon2rm_h.updown)
				temp_h.data_out = ++temp_h.data_out;
			else if(!wrmon2rm_h.updown)
				temp_h.data_out = --temp_h.data_out;
		end
	endtask

	task start();
		fork
			forever
			begin
				wrmon2rm.get(wrmon2rm_h);
				rm2sb.put(temp_h);
				temp_h = new temp_h;
				model();
			end
		join_none
	endtask

endclass :counter_rm
			
