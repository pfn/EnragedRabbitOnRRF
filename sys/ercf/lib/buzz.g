echo >{global.ercf_tmp_file} "G92 " ^ global.ercf_extruder_axis ^ "0"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_slow_speed ^ " " ^ global.ercf_extruder_axis ^ "5"
echo >>{global.ercf_tmp_file} "M400"
echo >>{global.ercf_tmp_file} "G1 F" ^ global.ercf_extruder_slow_speed ^ " " ^ global.ercf_extruder_axis ^ "-5"
echo >>{global.ercf_tmp_file} "M400"
echo >>{global.ercf_tmp_file} "M84 " ^ global.ercf_extruder_axis


G91
M98 P"ercf/lib/execute-tmp.g"
G90
