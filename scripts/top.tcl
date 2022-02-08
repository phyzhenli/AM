set TOP ubit8_designware

set SRC_FILE                scripts/read.tcl
set CONSTRAINT_FILE         scripts/constraints_comb.tcl

set CONSTRAINT_VIOLATION    reports/${TOP}_vio.rpt
set TIMING_RPT              reports/${TOP}_timing.rpt
set AREA_RPT                reports/${TOP}_area.rpt
set POWER_RPT		        reports/${TOP}_power.rpt
set QoR_RPT                 reports/${TOP}_qor.rpt
set SAIF_RPT                reports/${TOP}_saif.rpt

set NETLIST                 outputs/${TOP}_gate_v.v
set DDC                     outputs/${TOP}_ddc.ddc
set SDF                     outputs/${TOP}_sdf.sdf


source $SRC_FILE

link

uniquify

source $CONSTRAINT_FILE

compile_ultra

report_constraints  > $CONSTRAINT_VIOLATION
report_timing       > $TIMING_RPT
report_area         > $AREA_RPT
report_power        > $POWER_RPT
report_qor          > $QoR_RPT
report_saif         > $SAIF_RPT

write_file -hierarchy -format verilog -output $NETLIST
write_file -hierarchy -format ddc -output $DDC
write_sdf $SDF


quit