`timescale 1ns/1ps
//=====================================================================
// Description:
// Digital Buffer: Adjusting the C/D ratio can achieve a trade off between speed and accuracy
// Designer : Huang Chaofan, extraordinary.h@sjtu.edu.cn
// Revision History:
// V0 date: 2025.3.1 Initial version, Huang Chaofan
// ====================================================================

module DB#(
    parameter C = 1,     // The larger the C/D ratio, 
                         // the faster the speed, but the accuracy (noise resistance) decreases
    parameter D = 1,     // The smaller the C/D ratio, 
                         // the slower the speed, but the accuracy (noise resistance) increases
    parameter MAX = 1000 // cnt max value
)(
    input      clk,
    input      rst_n,
    input      lead,
    input      lag,

    output reg add_pulse,
    output reg sub_pulse
);

reg [15:0] cnt1; //cnt1 is responsible for lead signal & add_pulse signal
reg [15:0] cnt2; //cnt2 is responsible for lag signal & sub_pulse signal

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        cnt1 <= 0;
    else if(lead == 1 && cnt1 < D)
    begin
        if(cnt1 + C >= MAX)
            cnt1 <= MAX;
        else
            cnt1 <= cnt1 + C;
    end
    else if(lead == 0 && cnt1 >= D)
    begin
        if(cnt1 - D <= 0)
            cnt1 <= 0;
        else
            cnt1 <= cnt1 - D;
    end
    else if(lead == 1 && cnt1 >= D)
    begin
        if(cnt1 + C - D >= MAX)
            cnt1 <= MAX;
        else if(cnt1 + C - D <= 0)
            cnt1 <= 0;
        else
            cnt1 <= cnt1 + C - D;
    end
    else
        cnt1 <= cnt1;
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        add_pulse <= 0;
    else if(cnt1 >= D)
        add_pulse <= 1;
    else
        add_pulse <= 0;
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        cnt2 <= 0;
    else if(lag == 1 && cnt2 < D)
    begin
        if(cnt2 + C >= MAX)
            cnt2 <= MAX;
        else
            cnt2 <= cnt2 + C;
    end
    else if(lag == 0 && cnt2 >= D)
    begin
        if(cnt2 - D <= 0)
            cnt2 <= 0;
        else
            cnt2 <= cnt2 - D;
    end
    else if(lag == 1 && cnt2 >= D)
    begin
        if(cnt2 + C - D >= MAX)
            cnt2 <= MAX;
        else if(cnt2 + C - D <= 0)
            cnt2 <= 0;
        else
            cnt2 <= cnt2 + C - D;
    end
    else
        cnt2 <= cnt2;
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        sub_pulse <= 0;
    else if(cnt2 >= D)
        sub_pulse <= 1;
    else
        sub_pulse <= 0;
end

endmodule