# Adaptable Approximate Multiplier Design Driven by Input Distribution and Polarity

This repository contains:
- software: the code of the optimization method.
- multipliers: Verilog models of reproduced multipliers and generated multipliers.
- ApproxFlow: a toolbox to evaluate the DNN accuracy with the approximate multiplier.
- accelerators: three DNN accelerators with unsigned 8-bit multipliers.
- fir: an adaptive least mean square (LMS)-based finite impulse response (FIR) filter implemented by python.
- scripts: the scripts to synthesize multipliers and accelerators with [Arizona State Predictive PDK (ASAP) 7nm process library](https://github.com/The-OpenROAD-Project/asap7) in Synopsys Design Compiler (DC).

## software


The goal of the method is to generate approximate multipliers based on the data distributions extracted from the target application with consideration of the input polarity.

### src

The 'software/src' folder contains the template of the algorithm. Please follow the steps to generate multipliers:

- Step-1: select the unsigned multiplier or the signed multiplier.

- Step-2: decide the number of rows of the partial products to be compressed.

- Step-3: run 'gencode/unsigned/main.cpp' or 'gencode/signed/main.cpp' to generate alternative compressed terms.

- Step-4: extract the data distributions from the target application.

- Step-5: combine the alternative compressed terms of Step-3 and the data distributions of Step-4 in 'LogicCompress.m'.

- Step-6: run 'LogicCompress.m' to generate 'objectMat.mat'.

- Step-7: find a a control parameter $\lambda$ for a given desired area reduction ratio by 'findLamb.m'. It should be noted that you can adjust the parameter to control the number of compressed terms.

- Step-8: run 'GA.m' to solve the optimization objective and generate multipliers.

By modifying the number of rows of the partial products to be compressed, reversing the input polarity, or adding different control parameters, the mthod can generate multipliers with different qualities .

### example

The 'software/example' folder contains an example to generate unsigned 8-bit multipliers for uniform distributions. The first six rows of the partial products are compressed. Please run 'GA.m' to generate multipliers.


## multipliers

<!--- The Verilog models of reproduced multipliers and generated multipliers are provided. -->

### open source

- [EvoApprox8b](http://www.fit.vutbr.cz/research/groups/ehw/approxlib/)

<!--- [EvoApprox8b](http://www.fit.vutbr.cz/research/groups/ehw/approxlib/) is a library that contains 500 Pareto optimal 8-bit approximate multipliers evolved by a multi-objective Cartesian Genetic Programming (CGP). The library provides Verilog, Matlab, and C models of all approximate circuits. -->
[//]: # (In addition to standard circuit parameters, circuit error is given for seven different error metrics.)

V. Mrazek, R. Hrbacek, Z. Vasicek and L. Sekanina, "EvoApprox8b:  Library of Approximate Adders and Multipliers for Circuit Design and Benchmarking of Approximation Methods," Design, Automation & Test in Europe Conference & Exhibition (DATE), 2017, 2017, pp. 258-261, doi: 10.23919/DATE.2017.7926993.

- [EvoApproxLib<sup>LITE</sup>](https://ehw.fit.vutbr.cz/evoapproxlib/)

<!--- [EvoApproxLib<sup>LITE</sup>](https://ehw.fit.vutbr.cz/evoapproxlib/) is a lightweight library of approximate circuits with formally guaranteed error parameters based on [EvoApprox8b](http://www.fit.vutbr.cz/research/groups/ehw/approxlib/). Hardware as well as software models are provided for each circuit. -->

V. Mrazek, Z. Vasicek, L. Sekanina, H. Jiang and J. Han, "Scalable Construction of Approximate Multipliers With Formally Guaranteed Worst Case Error," in IEEE Transactions on Very Large Scale Integration (VLSI) Systems, vol. 26, no. 11, pp. 2572-2576, Nov. 2018, doi: 10.1109/TVLSI.2018.2856362.

- DRUM

S. Hashemi, R. I. Bahar and S. Reda, "DRUM: A Dynamic Range Unbiased Multiplier for approximate applications," 2015 IEEE/ACM International Conference on Computer-Aided Design (ICCAD), 2015, pp. 418-425, doi: 10.1109/ICCAD.2015.7372600.

Available at: https://github.com/scale-lab/DRUM and https://github.com/phyzhenli/DRUM.

### generated multipliers

#### unsigned 8-bit multipliers

The multipliers are generated for three different-scale quantized DNNs including LeNet, AlexNet, and VGG16.
In addition, this folder also contains multipliers generated for uniform distributions with different $l$ and $\lambda$.

#### unsigned 32-bit multipliers

#### signed 16-bit multipliers

The multipliers are generated for an adaptive least mean square (LMS)-based finite impulse response (FIR) filter.

### reproduced unsigned 8-bit multipliers

- AC

<!--- AC is a multiplier with two approximate 4-2 compressors. -->

A. Momeni, J. Han, P. Montuschi and F. Lombardi, "Design and Analysis of Approximate Compressors for Multiplication," in IEEE Transactions on Computers, vol. 64, no. 4, pp. 984-994, April 2015, doi: 10.1109/TC.2014.2308214.

- CR

<!--- CR leverages a newly-designed approximate adder that limits its carry propagation to the nearest neighbors for fast partial product accumulation. Different levels of accuracy can be achieved through a configurable error recovery by using different numbers of most significant bits (MSBs) for error reduction. -->

C. Liu, J. Han and F. Lombardi, "A low-power, high-performance approximate multiplier with configurable partial error recovery," 2014 Design, Automation & Test in Europe Conference & Exhibition (DATE), 2014, pp. 1-4, doi: 10.7873/DATE.2014.108.

- KMap

<!--- KMap is a multiplier architecture with tunable error characteristics, that leverages a modified inaccurate 2×2 building block. -->

P. Kulkarni, P. Gupta and M. Ercegovac, "Trading Accuracy for Power with an Underdesigned Multiplier Architecture," 2011 24th International Conference on VLSI Design, 2011, pp. 346-351, doi: 10.1109/VLSID.2011.51.

- OU

<!--- OU is an approximate and unbiased floating-point multiplier, which is mathematically proved optimal in terms of square error for the given bases of the space {1, x, y, x<sub>2</sub>, y<sub>2</sub>}. We use the method to generate integer multipliers. -->

C. Chen, S. Yang, W. Qian, M. Imani, X. Yin and C. Zhuo, "Optimally Approximated and Unbiased Floating-Point Multiplier with Runtime Configurability," 2020 IEEE/ACM International Conference On Computer Aided Design (ICCAD), 2020, pp. 1-9.

- RoBA

<!--- RoBA is a multiplier that rounds the operands to the nearest exponent of two. -->

R. Zendegani, M. Kamal, M. Bahadori, A. Afzali-Kusha and M. Pedram, "RoBA Multiplier: A Rounding-Based Approximate Multiplier for High-Speed yet Energy-Efficient Digital Signal Processing," in IEEE Transactions on Very Large Scale Integration (VLSI) Systems, vol. 25, no. 2, pp. 393-401, Feb. 2017, doi: 10.1109/TVLSI.2016.2587696.

- SDLC

<!--- SDLC is an energy-efficient approximate multiplier design using a significance-driven logic compression approach. Fundamental to this approach is an algorithmic and configurable lossy compression of the partial product rows based on their progressive bit significance. -->

I. Qiqieh, R. Shafik, G. Tarawneh, D. Sokolov and A. Yakovlev, "Energy-efficient approximate multiplier design using bit significance-driven logic compression," Design, Automation & Test in Europe Conference & Exhibition (DATE), 2017, 2017, pp. 7-12, doi: 10.23919/DATE.2017.7926950.

I. Haddadi, I. Qiqieh, R. Shafik, F. Xia, M. Al-hayanni and A. Yakovlev, "Run-time Configurable Approximate Multiplier using Significance-Driven Logic Compression," 2021 IEEE 39th International Conference on Computer Design (ICCD), 2021, pp. 117-124, doi: 10.1109/ICCD53106.2021.00029.

- TOSAM

S. Vahdat, M. Kamal, A. Afzali-Kusha and M. Pedram, "TOSAM: An Energy-Efficient Truncation- and Rounding-Based Scalable Approximate Multiplier," in IEEE Transactions on Very Large Scale Integration (VLSI) Systems, vol. 27, no. 5, pp. 1161-1173, May 2019, doi: 10.1109/TVLSI.2018.2890712.

- PPAM

G. Zervakis, K. Tsoumanis, S. Xydis, D. Soudris and K. Pekmestzi, "Design-Efficient Approximate Multiplication Circuits Through Partial Product Perforation," in IEEE Transactions on Very Large Scale Integration (VLSI) Systems, vol. 24, no. 10, pp. 3105-3117, Oct. 2016, doi: 10.1109/TVLSI.2016.2535398.

- Wallace

An exact multiplier implemented by Wallace Tree technique.

- DesignW

An exact multiplier implemented using Verilog star operator, which is usually built from DesignWare library in Synopsys Design Compiler tool.


## ApproxFlow

ApproxFlow is a toolbox to evaluate the DNN accuracy with the approximate multiplier. In ApproxFlow, each approximate multiplier is described by a look-up table. A DNN is represented by a directional acyclic graph (DAG), where each vertex denotes a DNN layer and the edges indicate the data flow. When a vertex in the DAG is executed, its dependencies will be executed automatically.

Available at: https://github.com/FDU-ME-ARC/ApproxFlow.

## accelerators

- Systolic Array

Systolic Array (SA) is a popular accelerator adopted by Google Tensor Processing Unit (TPU). We implement a 16×16 SA. The top module is systolic_array and the multiplier can be changed in 'multiplier.v'. The names of the clock and the reset signals are 'clk' and 'rst_n' respectively.

<!--- N. Jouppi, C. Young, N. Patil and D. Patterson, "Motivation for and Evaluation of the First Tensor Processing Unit," in IEEE Micro, vol. 38, no. 3, pp. 10-19, May./Jun. 2018, doi: 10.1109/MM.2018.032271057. -->

- Systolic Cube

Systolic Cube (SC) is an efficient accelerator of convolution operations in DNNs. The top module is systolic_cube_without_fifo and the multiplier can be changed in 'mad_unit_test.v'. The names of the clock and the reset signals are 'iClk' and 'iRst' respectively.

<!--- Yongchen Wang, Ying Wang, Huawei Li, Cong Shi, and Xiaowei Li. 2019. Systolic Cube: A Spatial 3D CNN Accelerator Architecture for Low Power Video Analysis. In Proceedings of the 56th Annual Design Automation Conference 2019 (DAC '19). Association for Computing Machinery, New York, NY, USA, Article 210, 1–6. DOI:https://doi.org/10.1145/3316781.3317919 -->

- TASU

TASU is a DNN accelerator for DoReFa-Net. The top module is conv0 and the multiplier can be changed in "mad_unit_test.v". The names of the clock and the reset signals are 'clk' and 'rst_n' respectively.

<!--- L. Jiao, C. Luo, W. Cao, X. Zhou and L. Wang, "Accelerating low bit-width convolutional neural networks with embedded FPGA," 2017 27th International Conference on Field Programmable Logic and Applications (FPL), 2017, pp. 1-4, doi: 10.23919/FPL.2017.8056820. -->

## scripts

The files 'constraints_comb.tcl' and 'constraints_seq.tcl' work for synthesis of multipliers and accelerators respectively.
