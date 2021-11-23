set global.ercf_pulse_count = 0

; disassociate the pin first
M950 J{global.ercf_encoder_trigger} C"nil"
M591 D0 S0 P0
M581 T{global.ercf_encoder_trigger} P-1

M950 J{global.ercf_encoder_trigger} C{global.ercf_encoder_pin}
M581 T{global.ercf_encoder_trigger} P{global.ercf_encoder_trigger}
echo >{"trigger" ^ global.ercf_encoder_trigger ^ ".g"} "set global.ercf_pulse_count = global.ercf_pulse_count + 1"

M584 P{#move.axes} ; allow operating on ERCF axes
