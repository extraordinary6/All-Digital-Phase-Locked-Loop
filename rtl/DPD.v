`timescale 1ns/1ps
//=====================================================================
// Description:
// Digital Phase Detector
// Designer : Huang Chaofan, extraordinary.h@sjtu.edu.cn
// Revision History:
// V0 date: 2025.3.1 Initial version, Huang Chaofan
// ====================================================================

module DPD(
    input            clk,
    input            rst_n,
    input            ref_signal,
    input            ctrl_signal,

    output reg       lead,
    output reg       lag,
    output           ref_rise,
    output reg [9:0] ref_period
);

reg flag;
reg [9:0] cnt;
reg ref_signal_d1, ctrl_signal_d1;

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        flag <= 1'b0;
    else if(ref_rise)
        flag <= 1'b1;
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        cnt <= 0;
    else if(ref_rise)
        cnt <= 0;
    else if(flag)
        cnt <= cnt + 1;
end

always @(posedge clk or negedge rst_n) 
begin
    if(!rst_n)
        ref_period <= 0;
    else if(ref_rise && !flag)
        ref_period <= 0; 
    else if(ref_rise)
        ref_period <= cnt;
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        ref_signal_d1 <= 1'b0;
    else
        ref_signal_d1 <= ref_signal;
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        ctrl_signal_d1 <= 1'b0;
    else
        ctrl_signal_d1 <= ctrl_signal;
end

assign ref_rise = (ref_signal_d1 == 1'b0 && ref_signal == 1'b1);


always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        lead <= 1'b0;
    end
    else if(ref_rise)
    begin
        if(ctrl_signal_d1 == 1'b0 && ctrl_signal == 1'b1)
            lead <= 1'b0;
        else if(ctrl_signal == 1'b1)
            lead <= 1'b1;
        else
            lead <= 1'b0;
    end
    else
        lead <= 1'b0;
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        lag <= 1'b0;
    end
    else if(ref_rise == 1'b1)
    begin
        if(ctrl_signal == 1'b0)
            lag <= 1'b1;
        else
            lag <= 1'b0;
    end
    else
        lag <= 1'b0;
end 


endmodule
