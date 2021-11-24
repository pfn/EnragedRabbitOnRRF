; configure drivers and toolboard
M569 P0.5 S1
M569 P20.0 S0
M584 U0.5
M584 V20.0 R1 S0 P3

set global.ercf_selector_axis = "U"
set global.ercf_extruder_axis = "V"

set global.ercf_bowden_length = 785
set global.ercf_extruder_gear_diameter = 11.4 ; orbiter filament gear diameter
set global.ercf_extruder_slow_speed = 1200
;set global.ercf_extruder_fast_speed = 5400
set global.ercf_extruder_fast_speed = 2400
set global.ercf_extruder_current = 800
set global.ercf_extruder_park = 15
set global.ercf_selector_endstop_pin = "^io3.out"
set global.ercf_servo_num = 2
set global.ercf_servo_pin = "io4.out"
set global.ercf_encoder_pin = "io3.in"
