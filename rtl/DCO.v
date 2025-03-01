`timescale 1ns/1ps
//=====================================================================
// Description:
// Digital Oscillator
// Designer : Huang Chaofan, extraordinary.h@sjtu.edu.cn
// Revision History:
// V0 date: 2025.3.1 Initial version, Huang Chaofan
// ====================================================================

module DCO #(
    parameter C = 100  //division factor
)(
    input      clk,
    input      rst_n,
    
    input      sub_pulse,  //cnt_max - 1
    input      add_pulse,  //cnt_max + 1
    input      ref_rise,

    output reg ctrl_signal
);

reg [9:0] cnt;
reg [9:0] cnt_max;

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        cnt_max <= C;
    else if(sub_pulse)
        cnt_max <= cnt_max - 1;
    else if(add_pulse)
        cnt_max <= cnt_max + 1;
    else
        cnt_max <= cnt_max;
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        cnt <= 0;
    else if(ref_rise)
        cnt <= 0;
    else if(cnt >= cnt_max)
        cnt <= 0;
    else
        cnt <= cnt + 1;
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        ctrl_signal <= 1'b1;
    else if(cnt < (cnt_max >> 1) )
        ctrl_signal <= 1'b1;
    else
        ctrl_signal <= 1'b0;
end
endmodule