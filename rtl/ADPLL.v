`timescale 1ns/1ps
//=====================================================================
// Description:
// ADPLL: All Digital Phase Locked Loop
// Designer : Huang Chaofan, extraordinary.h@sjtu.edu.cn
// Revision History:
// V0 date: 2025.3.1 Initial version, Huang Chaofan
// ====================================================================

module ADPLL(
    input      clk,
    input      rst_n,
    input      ref_signal,
    
    output     ctrl_signal
);

wire lead, lag, ref_rise;
wire add_pulse, sub_pulse;
wire [9:0] ref_period;


DPD u_DPD(
    .clk         (clk         ),
    .rst_n       (rst_n       ),
    .ref_signal  (ref_signal  ),
    .ctrl_signal (ctrl_signal ),
    .lead        (lead        ),
    .lag         (lag         ),
    .ref_rise    (ref_rise    ),
    .ref_period  (ref_period  )
);


DB #(
    .C   (1   ),
    .D   (1   ),
    .MAX (1000)
) u_DB(
    .clk       (clk       ),
    .rst_n     (rst_n     ),
    .lead      (lead      ),
    .lag       (lag       ),
    .add_pulse (add_pulse ),
    .sub_pulse (sub_pulse )
);


DCO #(
    .C (100)
) u_DCO(
    .clk         (clk         ),
    .rst_n       (rst_n       ),
    .sub_pulse   (sub_pulse   ),
    .add_pulse   (add_pulse   ),
    .ref_rise    (ref_rise    ),
    .ref_period  (ref_period  ),
    .ctrl_signal (ctrl_signal )
);



endmodule