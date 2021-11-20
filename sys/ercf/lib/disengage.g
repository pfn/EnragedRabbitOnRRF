M280 P{global.ercf_servo_num} S{global.ercf_servo_disengage}
G4 P100
M400
M42 P{global.ercf_servo_num} S0
set global.ercf_servo_engaged = false
