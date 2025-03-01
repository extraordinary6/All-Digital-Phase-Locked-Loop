# All-Digital-Phase-Locked-Loop

## Overview
This project is an **All-Digital Phase-Locked Loop (ADPLL)** implementation and has been simulated on QuestaSim 10.6c.  
It is designed purely for practice purposes, aiming to help me understand the core principles behind **Digital Phase-Locked Loops (DPLL)**.  

The design is implemented in **Verilog** and consists of the following key modules:

- `ADPLL.v`: Top-level file, integrating the entire ADPLL system.
- `DPD.v`: Digital Phase Detector, responsible for detecting phase differences between the reference signal and the controlled oscillator signal.
- `DB.v`: Digital Buffer, responsible for converting phase lead/lag signals into frequency adjustment pulses.
- `DCO.v`: Digitally Controlled Oscillator, responsible for generating the controlled signal with an adjustable frequency.

---

## Block Diagram

```text
                +-------------------+
 ref_signal --->|                   |
                |       DPD         |----> lead
ctrl_signal --->|                   |----> lag
                +-------------------+

                      lead  lag
                        |    |
                        v    v
                +-------------------+
                |                   |
                |        DB         |----> add_pulse
                |                   |----> sub_pulse
                +-------------------+

            add_pulse sub_pulse ref_rise
                  |       |        |
                  v       v        v
                +-------------------+
                |                   |
                |        DCO        |----> ctrl_signal (feedback to DPD)
                |                   |
                +-------------------+
