if exists(global.ercf_servo_engaged) && global.ercf_servo_engaged
  abort "Cannot home while servo engaged"

echo >{global.ercf_tmp_file} "G1 H1 F6000 " ^ global.ercf_selector_axis ^ "-355"
echo >>{global.ercf_tmp_file} "G1 F6000 " ^ global.ercf_selector_axis ^ "5"
echo >>{global.ercf_tmp_file} "G1 H1 F360 " ^ global.ercf_selector_axis ^ "-355"
echo >>{global.ercf_tmp_file} "M84 " ^ global.ercf_selector_axis

G91               ; relative positioning
M98 P"ercf/lib/execute-tmp.g"
G90               ; absolute positioning
M98 P"ercf/lib/select.g" S0
