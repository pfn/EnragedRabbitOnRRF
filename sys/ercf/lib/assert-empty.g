if global.ercf_extruder_loaded || global.ercf_selector_pos == -1
  M98 P"ercf/lib/engage.g"
  M98 P"ercf/lib/pulse-counting.g"
  var pulse_count = global.ercf_pulse_count
  M98 P"ercf/lib/buzz.g"
  if var.pulse_count != global.ercf_pulse_count
    M98 P"ercf/lib/disengage.g"
    abort "Filament already loaded, unload first"
  set global.ercf_extruder_loaded = false
  M98 P"ercf/lib/disengage.g"
