M98 P"ercf/lib/engage.g"
M98 P"ercf/lib/pulse-counting.g"

var pulse_count = global.ercf_pulse_count
var retracted = false

echo >{global.ercf_tmp_file} "G92 " ^ global.ercf_extruder_axis ^ "0"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_slow_speed ^ " " ^ global.ercf_extruder_axis ^ "-5"
echo >>{global.ercf_tmp_file} "M400"

G91
M98 P{global.ercf_tmp_file}
while var.pulse_count != global.ercf_pulse_count
  set var.pulse_count = global.ercf_pulse_count
  set var.retracted = true
  M98 P{global.ercf_tmp_file}

if var.retracted
  echo >{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_slow_speed ^ " " ^ global.ercf_extruder_axis ^ "-18" ; allow a little more than 23mm to leave the gears
  echo >>{global.ercf_tmp_file} "G92 " ^ global.ercf_extruder_axis ^ "0"
  echo >>{global.ercf_tmp_file} "M84 " ^ global.ercf_extruder_axis
  M98 P"ercf/lib/execute-tmp.g"
else
  echo >{global.ercf_tmp_file} "M84 " ^ global.ercf_extruder_axis
  M98 P"ercf/lib/execute-tmp.g"

G90
M98 P"ercf/lib/disengage.g"
set global.ercf_extruder_loaded = false
M98 P"ercf/lib/save-selector-state.g"
