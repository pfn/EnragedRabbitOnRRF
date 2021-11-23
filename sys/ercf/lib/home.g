M584 P{#move.axes} ; allow operating on ERCF axes
M98 P"ercf/lib/assert-empty.g"

var hominglimit = -global.ercf_selector_axis_max - 5
echo >{global.ercf_tmp_file} "G1 H1 F6000 " ^ global.ercf_selector_axis ^ var.hominglimit
echo >>{global.ercf_tmp_file} "G1 F6000 " ^ global.ercf_selector_axis ^ "5"
echo >>{global.ercf_tmp_file} "G1 H1 F360 " ^ global.ercf_selector_axis ^ var.hominglimit
echo >>{global.ercf_tmp_file} "M84 " ^ global.ercf_selector_axis

G91               ; relative positioning
M98 P"ercf/lib/execute-tmp.g"
G90               ; absolute positioning
M98 P"ercf/lib/select.g" S0 H1
M584 P{#move.axes - 2} ; hide ERCF axes
