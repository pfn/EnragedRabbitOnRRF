if !global.ercf_servo_engaged
  M280 P{global.ercf_servo_num} S{global.ercf_servo_engage}
  G4 P150
  M98 P"ercf/lib/buzz.g"
  M400
  M42 P{global.ercf_servo_num} S0

set global.ercf_servo_engaged = true
