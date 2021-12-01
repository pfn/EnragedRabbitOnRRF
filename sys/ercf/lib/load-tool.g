M98 R1
if global.ercf_selector_pos == -1 && (!exists(param.H) || param.H != 1)
  abort "Home selector first"

if !exists(param.T)
  abort "No Tool selected"

if global.ercf_selector_pos == param.T && global.ercf_extruder_loaded
  echo {"Filament already loaded into tool " ^ param.T}
  M99

echo "Switching to T" ^ param.T

if global.ercf_extruder_loaded
  M98 P"ercf/lib/unload.g"

M98 P"ercf/lib/select.g" S{param.T}

if !global.ercf_extruder_loaded
  M98 P"ercf/lib/load.g"
