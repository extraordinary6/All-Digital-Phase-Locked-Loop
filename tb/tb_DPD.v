`timescale 1ns/1ps

module tb_DPD;

    reg clk;
    reg rst_n;
    reg ref_signal;
    reg ctrl_signal;

    wire lead;
    wire lag;
    wire ref_rise;


    DPD uut (
        .clk(clk),
        .rst_n(rst_n),
        .ref_signal(ref_signal),
        .ctrl_signal(ctrl_signal),
        .lead(lead),
        .lag(lag),
        .ref_rise(ref_rise)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz
    end


    initial begin
        rst_n <= 0;
        ref_signal <= 0;
        ctrl_signal <= 0;


        #20;
        rst_n <= 1;

        #3;


        #15 ctrl_signal <= 1; 
        #10 ref_signal <= 1;  
        #10 ctrl_signal <= 0;   
        #10 ref_signal <= 0;  

       
        #15 ref_signal <= 1; 
        #6 ctrl_signal <= 1; 
        #10 ref_signal <= 0;  
        #10 ctrl_signal <= 0;


        #15 ref_signal <= 1;
        ctrl_signal <= 1;
        #10 ref_signal <= 0;
        ctrl_signal <= 0;


        #50;
        $stop;
    end


    initial begin
        $dumpfile("dpd_tb.vcd");
        $dumpvars(0, tb_DPD);
    end

endmodule
