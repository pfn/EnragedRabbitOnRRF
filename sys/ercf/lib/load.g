M98 R1

if state.macroRestarted
  if !global.ercf_extruder_loaded
    if state.status == "processing"
      M291 P{"Filament not yet loaded: T" ^ global.ercf_selector_pos} R"Load Filament" S1 T0
      M98 R1
      M226
  M99

if global.ercf_extruder_loaded
  echo "Extruder already loaded, skipping; restarted=" ^ state.macroRestarted
  M99

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
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_slow_speed ^ " " ^ global.ercf_extruder_axis ^ "40"
echo >>{global.ercf_tmp_file} "M400"
G91
M98 P"ercf/lib/execute-tmp.g"

if global.ercf_pulse_count - var.pulse_count < 3 ; filter false pulse
  echo >{global.ercf_tmp_file} "M84 " ^ global.ercf_extruder_axis
  M98 P"ercf/lib/execute-tmp.g"
  M98 P"ercf/lib/disengage.g"
  G90
  var errmsg = "No filament detected during selector load: T" ^ global.ercf_selector_pos
  if state.status == "processing"
    echo var.errmsg
    M291 P{var.errmsg} R"Load Filament" S1 T0
    M98 R1
    M226
  else
    abort var.errmsg

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
    echo "No filament movement detected during load: T" ^ global.ercf_selector_pos
    break

echo >{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_slow_speed ^ " " ^ global.ercf_extruder_axis ^ "5"
echo >>{global.ercf_tmp_file} "M400"
while var.pulse_count != global.ercf_pulse_count
  set var.pulse_count = global.ercf_pulse_count
  M98 P{global.ercf_tmp_file}

M98 P"ercf/lib/load-extruder.g"
if !global.ercf_extruder_loaded
  var errmsg = "Load into extruder not detected: T" ^ global.ercf_selector_pos
  if state.status == "processing"
    echo var.errmsg
    M291 P{var.errmsg} R"Load Filament" S1 T0
    M98 R1
    M226
  else
    abort var.errmsg

echo >{global.ercf_tmp_file} "M84 E0 " ^ global.ercf_extruder_axis
M98 P"ercf/lib/execute-tmp.g"
M98 P"ercf/lib/disengage.g"

G90
