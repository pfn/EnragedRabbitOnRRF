M98 P"ercf/lib/pulse-counting.g"
echo >{global.ercf_tmp_file} "G92 " ^ global.ercf_extruder_axis ^ "0"
echo >>{global.ercf_tmp_file} "G1 F360 " ^ global.ercf_extruder_axis ^ "2"
echo >>{global.ercf_tmp_file} "M400"
echo >>{global.ercf_tmp_file} "G1 F360 " ^ global.ercf_extruder_axis ^ "-2"
echo >>{global.ercf_tmp_file} "M400"
echo >>{global.ercf_tmp_file} "M84 " ^ global.ercf_extruder_axis


G91
M98 P"ercf/lib/execute-tmp.g"
G90
M98 P"ercf/lib/filament-sensing.g"
