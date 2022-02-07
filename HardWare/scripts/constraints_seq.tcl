#7nm
set MAX_LOAD [load_of asap7sc7p5t_INVBUF_RVT_TT_ccs_201020/INVx3_ASAP7_75t_R/A]
set_load [expr $MAX_LOAD*5] [all_outputs]

create_clock -name top_clk -period 1000 [get_ports iClk]
set dont_touch_network [get_ports iClk]
set_drive 0 iClk
set_ideal_network [get_ports iClk]
set_input_delay 0 -clock top_clk [all_inputs]
set_output_delay 0 -clock top_clk [all_outputs]

set_dont_touch_network [get_ports iRst]
set_drive 0 iRst
set_ideal_network [get_ports iRst]
set_false_path -from [get_ports iRst]