module test;


    //Callback driver/Facade class implementing empty virtual method. 
    //These methods are extended by specific drivers to implement
    //scenarios on available hooks.
    class Driver_cbs;

        virtual task pre_run(); endtask
        virtual task post_run(); endtask

    endclass //Driver_cbs


    //Protocol driver
    class Driver;

        Driver_cbs drv_cb_h = new();

        //Pre-planned hooks in Driver class
        //By default does nothing.
        task pre_run();
            drv_cb_h.pre_run();
        endtask

        task post_run();
            drv_cb_h.post_run();
        endtask

        task run();

            //Hook1
            pre_run();

            //Protocol specific logic
            $display("Driver protocol execution.\n");

            //Hook2
            post_run();

        endtask //run

    endclass //Driver

    class test extends Driver_cbs;

        task pre_run();
            $display("\n\nExecute test specific functionality.\n");
        endtask 

    endclass //test

    Driver drv_h;
    test t_h;

    initial
    begin

        drv_h = new();

        //
        //To achieve callback
        //
        t_h = new();
        drv_h.drv_cb_h = t_h;

        drv_h.run();

        #100;
        $display("End of simulation..\n");
        $finish;
    end

endmodule //testbench
