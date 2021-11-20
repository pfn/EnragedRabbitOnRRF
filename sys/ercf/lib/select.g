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

var slot_position = 0
if param.S == 0
  set var.slot_position = global.ercf_slot0_pos
elif param.S == 1
  set var.slot_position = global.ercf_slot1_pos
elif param.S == 2
  set var.slot_position = global.ercf_slot2_pos
elif param.S == 3
  set var.slot_position = global.ercf_slot3_pos
elif param.S == 4
  set var.slot_position = global.ercf_slot4_pos
elif param.S == 5
  set var.slot_position = global.ercf_slot5_pos
else
  abort {"Invalid slot selected: " ^ param.S}

echo >{global.ercf_tmp_file} "G92 " ^ global.ercf_selector_axis ^ move.axes[var.axis].userPosition
echo >>{global.ercf_tmp_file} "G1 F6000 " ^ global.ercf_selector_axis ^ var.slot_position
echo >>{global.ercf_tmp_file} "M84 " ^ global.ercf_selector_axis
M98 P"ercf/lib/execute-tmp.g"
