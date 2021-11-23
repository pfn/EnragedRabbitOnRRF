if !global.ercf_extruder_loaded && global.ercf_selector_pos != -1
  abort "Filament is not loaded"
  
;M98 P"ercf/lib/engage.g"
M98 P"ercf/lib/pulse-counting.g"

var pulse_count = global.ercf_pulse_count
;M98 P"ercf/lib/buzz.g"

;if var.pulse_count == global.ercf_pulse_count
;  M98 P"ercf/lib/disengage.g"
;  abort "Filament already unloaded"
;M98 P"ercf/lib/disengage.g"

T{global.ercf_tool_number}
M302 P1
G1 E{-(10 + global.ercf_extruder_gear_diameter + global.ercf_extruder_park)} F{global.ercf_extruder_slow_speed}
while global.ercf_pulse_count > 0
  set global.ercf_pulse_count = 0
  G1 E-5 F{global.ercf_extruder_slow_speed}
M302 P0

M98 P"ercf/lib/engage.g"
set global.ercf_pulse_count = 0
echo >{global.ercf_tmp_file} "G92 " ^ global.ercf_extruder_axis ^ "0"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_fast_speed ^ " " ^ global.ercf_extruder_axis ^ {-global.ercf_bowden_length}
echo >>{global.ercf_tmp_file} "M400"
M98 P"ercf/lib/execute-tmp.g"
var expected = floor(global.ercf_bowden_length / global.ercf_pulse_distance)
echo >{global.ercf_tmp_file} "var remaining = {global.ercf_pulse_distance * (" ^ var.expected ^ " - global.ercf_pulse_count)}"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_fast_speed ^ " " ^ global.ercf_extruder_axis ^ "{-var.remaining}"
echo >>{global.ercf_tmp_file} "M400"
G91
while global.ercf_pulse_count < var.expected
  if iterations > 5
    echo {"ercf_bowden_length too high? measured " ^ (global.ercf_pulse_distance * global.ercf_pulse_count)}
    break
  set var.pulse_count = global.ercf_pulse_count
  M98 P{global.ercf_tmp_file}
  if var.pulse_count == global.ercf_pulse_count
    echo "No filament movement detected during unload"
    break
if var.pulse_count != global.ercf_pulse_count
  M98 P"ercf/lib/unload-selector.g"

set global.ercf_extruder_loaded = false

M84 E0
M98 P"ercf/lib/disengage.g"

G90

M98 P"ercf/lib/filament-sensing.g"
