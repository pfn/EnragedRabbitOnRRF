if global.ercf_extruder_loaded
  echo "Cannot load extruder while already loaded; restarted=" ^ state.macroRestarted
  M99

G91
M98 P"ercf/lib/engage.g"
M98 P"ercf/lib/pulse-counting.g"

echo >{global.ercf_tmp_file} "G92 " ^ global.ercf_extruder_axis ^ "0"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_slow_speed ^ " " ^ global.ercf_extruder_axis ^ "-2"
echo >>{global.ercf_tmp_file} "var pulse_count = global.ercf_pulse_count"
echo >>{global.ercf_tmp_file} "M302 P1"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_load_speed ^ " E" ^ {global.ercf_extruder_gear_diameter + 2} ^ " " ^ global.ercf_extruder_axis ^ {global.ercf_extruder_gear_diameter + 2}
echo >>{global.ercf_tmp_file} "M400"
echo >>{global.ercf_tmp_file} "M98 P""ercf/lib/disengage.g"""
echo >>{global.ercf_tmp_file} "set var.pulse_count = global.ercf_pulse_count"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_load_speed ^ " E" ^ {global.ercf_extruder_park}
echo >>{global.ercf_tmp_file} "M400"
echo >>{global.ercf_tmp_file} "M302 P0"
echo >>{global.ercf_tmp_file} "if global.ercf_pulse_count - var.pulse_count < 3"
echo >>{global.ercf_tmp_file} "  M84 E0 " ^ global.ercf_extruder_axis
echo >>{global.ercf_tmp_file} "  M584 P{#move.axes - 2} ; hide ERCF axes"
echo >>{global.ercf_tmp_file} "  M99"
echo >>{global.ercf_tmp_file} "set global.ercf_extruder_loaded = true"
T{global.ercf_tool_number}
M98 P"ercf/lib/execute-tmp.g"
G90
M98 P"ercf/lib/save-selector-state.g"
M98 P"ercf/lib/filament-sensing.g"
