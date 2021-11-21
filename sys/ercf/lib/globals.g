; global declarations, some relatively sane defaults included
; value overrides should go in ercf/settings.g
if !exists(global.ercf_settings_loaded)
  ;
  ; selector axis settings
  ;
  global ercf_selector_axis = "U"
  global ercf_selector_endstop_pin = "xstop"
  global ercf_selector_current = 750
  global ercf_selector_steps = 80
  global ercf_selector_axis_min = 0
  global ercf_selector_axis_max = 115
  ;
  ; filament drive settings
  ;
  global ercf_extruder_axis = "V"
  global ercf_extruder_current = 800
  global ercf_extruder_steps = 574.28
  ;
  ; selector servo settings
  ;
  global ercf_servo_pin = "exp.heater3"
  global ercf_servo_num = 0
  global ercf_servo_disengage = 0
  global ercf_servo_engage = 90
  ;
  ; filament block positions
  ;
  global ercf_slot0_pos = 2
  global ercf_slot1_pos = 23
  global ercf_slot2_pos = 45
  global ercf_slot3_pos = 71
  global ercf_slot4_pos = 92
  global ercf_slot5_pos = 113
  ;
  ; filament sensor settings
  ;
  global ercf_encoder_pin = "e0stop"
  global ercf_encoder_trigger = 2
  global ercf_pulse_distance = 1.43
  ;
  ; DO NOT EDIT
  ; non-configurable system state variables
  ;
  global ercf_pulse_count = 0
  global ercf_tmp_file = "ercf/lib/tmp.g"
  global ercf_selector_pos = -1
  global ercf_servo_engaged = false
  global ercf_settings_loaded = 1
