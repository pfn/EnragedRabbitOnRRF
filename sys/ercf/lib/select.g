if !exists(param.S)
  abort "No Slot selected"

if exists(global.ercf_servo_engaged) && global.ercf_servo_engaged
  abort "Cannot select while servo engaged"

var axis = -1

while var.axis == -1
  if iterations >= #move.axes
    break
  if move.axes[iterations].letter == global.ercf_selector_axis
    set var.axis = iterations

if var.axis == -1
  abort "Cannot find selector axis"

echo >{global.ercf_tmp_file} "var slot_position = 0"
echo >>{global.ercf_tmp_file} "if !exists(global.ercf_slot" ^ param.S ^ "_pos)"
echo >>{global.ercf_tmp_file} "  abort ""Invalid slot selected: " ^ param.S ^ """"
echo >>{global.ercf_tmp_file} "set var.slot_position = global.ercf_slot" ^ param.S ^ "_pos"
echo >>{global.ercf_tmp_file} "set global.ercf_selector_pos = " ^ param.S
echo >>{global.ercf_tmp_file} "G92 " ^ global.ercf_selector_axis ^ move.axes[var.axis].userPosition
echo >>{global.ercf_tmp_file} "G1 F6000 " ^ global.ercf_selector_axis ^ "{var.slot_position}"
echo >>{global.ercf_tmp_file} "M84 " ^ global.ercf_selector_axis

G90
M98 P"ercf/lib/execute-tmp.g"
