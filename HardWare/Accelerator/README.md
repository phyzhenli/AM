# DNN accelerators with 8-bit unsigned multiplier

## SA [1]

Top module is systolic_array and the multiplier can be changed in 'multiplier.v'.

The names of clock and reset signals are 'clk' and 'rst_n' respectively.

## SC [1]

Top module is systolic_cube_without_fifo and the multiplier can be changed in 'mad_unit_test.v'.

The names of clock and reset signals are 'iClk' and 'iRst' respectively.

## TASU [3]

Top module is conv0 and the multiplier can be changed in "mad_unit_test.v".

The names of clock and reset signals are 'clk' and 'rst_n' respectively.

### Reference

[1] N. Jouppi, C. Young, N. Patil and D. Patterson, "Motivation for and Evaluation of the First Tensor Processing Unit," in IEEE Micro, vol. 38, no. 3, pp. 10-19, May./Jun. 2018, doi: 10.1109/MM.2018.032271057.

[2] Yongchen Wang, Ying Wang, Huawei Li, Cong Shi, and Xiaowei Li. 2019. Systolic Cube: A Spatial 3D CNN Accelerator Architecture for Low Power Video Analysis. In Proceedings of the 56th Annual Design Automation Conference 2019 (DAC '19). Association for Computing Machinery, New York, NY, USA, Article 210, 1–6. DOI:https://doi.org/10.1145/3316781.3317919

[3] L. Jiao, C. Luo, W. Cao, X. Zhou and L. Wang, "Accelerating low bit-width convolutional neural networks with embedded FPGA," 2017 27th International Conference on Field Programmable Logic and Applications (FPL), 2017, pp. 1-4, doi: 10.23919/FPL.2017.8056820.

