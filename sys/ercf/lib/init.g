M98 P"ercf/lib/globals.g"
M98 P"ercf/settings.g"
M98 P{global.ercf_selector_file}
M950 S{global.ercf_servo_num} C{global.ercf_servo_pin}
echo >{global.ercf_tmp_file} "M906 " ^ global.ercf_extruder_axis ^ global.ercf_extruder_current ^ " " ^ global.ercf_selector_axis ^ global.ercf_selector_current
echo >>{global.ercf_tmp_file} "M350 " ^ global.ercf_extruder_axis ^ "16 " ^ global.ercf_selector_axis ^ "16"
echo >>{global.ercf_tmp_file} "M92 " ^ global.ercf_extruder_axis ^ global.ercf_extruder_steps ^ " " ^ global.ercf_selector_axis ^ global.ercf_selector_steps
echo >>{global.ercf_tmp_file} "M201 " ^ global.ercf_extruder_axis ^ 400 ^ " " ^ global.ercf_selector_axis ^ 400
echo >>{global.ercf_tmp_file} "M203 " ^ global.ercf_extruder_axis ^ 12000 ^ " " ^ global.ercf_selector_axis ^ 12000
echo >>{global.ercf_tmp_file} "M208 S1 " ^ global.ercf_selector_axis ^ global.ercf_selector_axis_min ^ " " ^ global.ercf_extruder_axis ^ "-9999"
echo >>{global.ercf_tmp_file} "M208 S0 " ^ global.ercf_selector_axis ^ global.ercf_selector_axis_max ^ " " ^ global.ercf_extruder_axis ^ "9999"
echo >>{global.ercf_tmp_file} "M574 S1 " ^ global.ercf_selector_axis ^ "1" ^ " P""" ^ global.ercf_selector_endstop_pin ^ """"
M98 P"ercf/lib/execute-tmp.g"
M591 D0 S0 P0
M950 J{global.ercf_encoder_trigger} C"nil"
M98 P"ercf/lib/filament-sensing.g"
