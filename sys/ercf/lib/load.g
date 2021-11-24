if global.ercf_selector_pos == -1
  abort "Home selector first"
M98 P"ercf/lib/engage.g"
M98 P"ercf/lib/pulse-counting.g"

var pulse_count = global.ercf_pulse_count
var extruded = false

if global.ercf_extruder_loaded || global.ercf_selector_pos == -1
  M98 P"ercf/lib/buzz.g"

  if var.pulse_count != global.ercf_pulse_count
    M98 P"ercf/lib/disengage.g"
    abort "Filament already loaded, unload first"

set var.pulse_count = global.ercf_pulse_count
echo >{global.ercf_tmp_file} "G92 " ^ global.ercf_extruder_axis ^ "0"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_fast_speed ^ " " ^ global.ercf_extruder_axis ^ "30"
echo >>{global.ercf_tmp_file} "M400"
G91
M98 P"ercf/lib/execute-tmp.g"

if var.pulse_count == global.ercf_pulse_count
  echo >{global.ercf_tmp_file} "M84 " ^ global.ercf_extruder_axis
  M98 P"ercf/lib/execute-tmp.g"
  M98 P"ercf/lib/disengage.g"
  G90
  abort "No filament detected during selector load"

set global.ercf_pulse_count = 0
echo >{global.ercf_tmp_file} "G92 " ^ global.ercf_extruder_axis ^ "0"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_fast_speed ^ " " ^ global.ercf_extruder_axis ^ global.ercf_bowden_length
echo >>{global.ercf_tmp_file} "M400"
M98 P"ercf/lib/execute-tmp.g"

var expected = floor(global.ercf_bowden_length / global.ercf_pulse_distance)
echo >{global.ercf_tmp_file} "var remaining = {global.ercf_pulse_distance * (" ^ var.expected ^ " - global.ercf_pulse_count)}"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_fast_speed ^ " " ^ global.ercf_extruder_axis ^ "{var.remaining}"
echo >>{global.ercf_tmp_file} "M400"
while global.ercf_pulse_count < var.expected
  if iterations > 2
    echo {"ercf_bowden_length too high? measured " ^ (global.ercf_pulse_distance * global.ercf_pulse_count)}
    break
  set var.pulse_count = global.ercf_pulse_count
  M98 P{global.ercf_tmp_file}
  if var.pulse_count == global.ercf_pulse_count
    echo "No filament movement detected during load"
    break

echo >{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_slow_speed ^ " " ^ global.ercf_extruder_axis ^ "5"
echo >>{global.ercf_tmp_file} "M400"
while var.pulse_count != global.ercf_pulse_count
  set var.pulse_count = global.ercf_pulse_count
  M98 P{global.ercf_tmp_file}

set var.pulse_count = global.ercf_pulse_count
echo >{global.ercf_tmp_file} "var pulse_count = global.ercf_pulse_count"
echo >>{global.ercf_tmp_file} "M302 P1"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_slow_speed ^ " E" ^ global.ercf_extruder_gear_diameter ^ " " ^ global.ercf_extruder_axis ^ global.ercf_extruder_gear_diameter
echo >>{global.ercf_tmp_file} "M400"
echo >>{global.ercf_tmp_file} "M98 P""ercf/lib/disengage.g"""
echo >>{global.ercf_tmp_file} "set var.pulse_count = global.ercf_pulse_count"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_slow_speed ^ " E5"
echo >>{global.ercf_tmp_file} "M400"
echo >>{global.ercf_tmp_file} "if var.pulse_count == global.ercf_pulse_count"
echo >>{global.ercf_tmp_file} "  M302 P0"
echo >>{global.ercf_tmp_file} "  abort ""Load into extruder failed"""
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_slow_speed ^ " E" ^ {global.ercf_extruder_park}
echo >>{global.ercf_tmp_file} "M302 P0"
T{global.ercf_tool_number}
M98 P"ercf/lib/execute-tmp.g"

set global.ercf_extruder_loaded = true
M98 P"ercf/lib/save-selector-state.g"

echo >{global.ercf_tmp_file} "M84 E0 " ^ global.ercf_extruder_axis
M98 P"ercf/lib/execute-tmp.g"
M98 P"ercf/lib/disengage.g"

G90
M98 P"ercf/lib/filament-sensing.g"
