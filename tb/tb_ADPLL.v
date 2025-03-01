`timescale 1ns/1ps
//=====================================================================
// Description:
// Digital Phase Detector
// Designer : Huang Chaofan, extraordinary.h@sjtu.edu.cn
// Revision History:
// V0 date: 2025.3.1 Initial version, Huang Chaofan
// ====================================================================

`timescale 1ns/1ps

module tb_ADPLL;

// Parameters
parameter CLK_PERIOD = 2;    // System clock period: 2ns (500MHz)
parameter REF_PERIOD = 120;  // Reference signal period

// Signals
reg clk;
reg rst_n;
reg ref_signal;

wire ctrl_signal;

// Instantiate the DUT (Device Under Test)
ADPLL dut (
    .clk(clk),
    .rst_n(rst_n),
    .ref_signal(ref_signal),
    .ctrl_signal(ctrl_signal)
);

// Clock generation (2ns period = 500MHz)
initial begin
    clk = 0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end

// Reference signal generation (100ns period = 10MHz)
initial begin
    ref_signal = 0;
    forever #(REF_PERIOD/2) ref_signal = ~ref_signal;
end

// Reset generation
initial begin
    rst_n = 0;
    #10;        // Hold reset for 10ns
    rst_n = 1;  // Release reset
end

// Simulation control
initial begin
    // Simulation will run for a reasonable time to observe behavior
    #10000;  // Run for 1000ns (adjust if necessary)
    $finish;
end

// Optional waveform dump for VCD (if needed for debugging)
initial begin
    $dumpfile("tb_ADPLL.vcd");
    $dumpvars(0, tb_ADPLL);
end

endmodule
