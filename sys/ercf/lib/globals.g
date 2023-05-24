; global declarations, some relatively sane defaults included
; value overrides should go in ercf/settings.g
if !exists(global.ercf_settings_loaded)
  ;
  ; general settings
  ;
  global ercf_bowden_length = 525
  global ercf_tool_number = 0
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
  global ercf_extruder_current = 565
  global ercf_extruder_steps = 574.28
  global ercf_extruder_gear_diameter = 7.35
  ; calculated as gear bottom to stopping location
  ; this should be where the filament can be moved while cold
  global ercf_extruder_park = 40
  global ercf_extruder_retract_park = 35
  global ercf_extruder_load_speed = 300
  global ercf_extruder_slow_speed = 1200
  global ercf_extruder_fast_speed = 2400
  ;
  ; selector servo settings
  ;
  global ercf_servo_pin = "exp.heater3"
  global ercf_servo_num = 0
  global ercf_servo_disengage = 0
  global ercf_servo_engage = 140
  ;
  ; filament block positions, additional blocks can be added and removed
  ; additional definitions can go here or in settings.g
  ; removed blocks should be commented/deleted out of this file
  ;
  global ercf_slot0_pos = 1
  global ercf_slot1_pos = 22
  global ercf_slot2_pos = 43
  global ercf_slot3_pos = 69
  global ercf_slot4_pos = 90
  global ercf_slot5_pos = 111
  ;
  ; filament sensor settings
  ;
  global ercf_encoder_pin = "e0stop"
  global ercf_encoder_trigger = 2
  global ercf_pulse_distance = 1.415
  ;
  ; DO NOT EDIT
  ; non-configurable system state variables
  ;
  global ercf_pulse_count = 0
  global ercf_extruder_loaded = false
  global ercf_tmp_file = "ercf/lib/tmp.g"
  global ercf_selector_file = "ercf/lib/selector-state.g"
  global ercf_selector_pos = -1
  global ercf_servo_engaged = false
  global ercf_settings_loaded = true
