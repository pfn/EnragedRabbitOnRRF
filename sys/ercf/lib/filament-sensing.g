M591 D0 S0 P0
M581 T{global.ercf_encoder_trigger} P-1
M950 J{global.ercf_encoder_trigger} C"nil"
M30 {"/sys/" ^ "trigger" ^ global.ercf_encoder_trigger ^ ".g"}
M591 D0 P7 C{global.ercf_encoder_pin} S1 R70:700 E{global.ercf_pulse_distance * 3} A0 L{global.ercf_pulse_distance}
