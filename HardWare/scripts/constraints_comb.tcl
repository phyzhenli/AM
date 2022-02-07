#7nm
set MAX_LOAD [load_of asap7sc7p5t_INVBUF_RVT_TT_ccs_201020/INVx3_ASAP7_75t_R/A]
set_load [expr $MAX_LOAD*5] [all_outputs]

create_clock -period 2000 -name VCLK
set_input_delay 0 -clock VCLK [all_inputs]
set_output_delay 0 -clock VCLK [all_outputs]