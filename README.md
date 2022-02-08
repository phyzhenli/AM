# Adaptable Approximate Multiplier Design Driven by Input Distribution and Polarity

## ApproxFlow

ApproxFlow is a toolbox to evaluate the DNN accuracy with the approximate multiplier. In ApproxFlow, each approximate multiplier is described by a look-up table. A DNN is represented by a directional acyclic graph (DAG), where each vertex denotes a DNN layer and the edges indicate the data flow. When a vertex in the DAG is executed, its dependencies will be executed automatically.

The code is available at: https://github.com/FDU-ME-ARC/ApproxFlow

## Multipliers

The C++ and Verilog models of reproduced multipliers and generated multipliers.

### unsigned 8-bit multipliers

#### AC
; AC is a multiplier with two approximate 4-2 compressors.

A. Momeni, J. Han, P. Montuschi and F. Lombardi, "[Design and Analysis of Approximate Compressors for Multiplication](https://ieeexplore.ieee.org/abstract/document/6748013)," in IEEE Transactions on Computers, vol. 64, no. 4, pp. 984-994, April 2015, doi: 10.1109/TC.2014.2308214.

#### CR
; CR leverages a newly-designed approximate adder that limits its carry propagation to the nearest neighbors for fast partial product accumulation. Different levels of accuracy can be achieved through a configurable error recovery by using different numbers of most significant bits (MSBs) for error reduction.

C. Liu, J. Han and F. Lombardi, "[A low-power, high-performance approximate multiplier with configurable partial error recovery](https://ieeexplore.ieee.org/abstract/document/6800309)," 2014 Design, Automation & Test in Europe Conference & Exhibition (DATE), 2014, pp. 1-4, doi: 10.7873/DATE.2014.108.

#### DesignW
DesignW is an exact multiplier implemented using Verilog star operator, which is usually built from DesignWare library in Synopsys Design Compiler tool.

#### EvoApprox8b
[EvoApprox8b](http://www.fit.vutbr.cz/research/groups/ehw/approxlib/) is a library that contains 500 Pareto optimal 8-bit approximate multipliers evolved by a multi-objective Cartesian Genetic Programming (CGP). The library provides Verilog, Matlab, and C models of all approximate circuits. In addition to standard circuit parameters, circuit error is given for seven different error metrics.

V. Mrazek, R. Hrbacek, Z. Vasicek and L. Sekanina, "[EvoApprox8b:  Library of Approximate Adders and Multipliers for Circuit Design and Benchmarking of Approximation Methods](https://ieeexplore.ieee.org/abstract/document/7926993)," Design, Automation & Test in Europe Conference & Exhibition (DATE), 2017, 2017, pp. 258-261, doi: 10.23919/DATE.2017.7926993.

#### EvoApproxLib<sup>LITE</sup>
[EvoApproxLib<sup>LITE</sup>](https://ehw.fit.vutbr.cz/evoapproxlib/) is a lightweight library of approximate circuits with formally guaranteed error parameters based on [EvoApprox8b](http://www.fit.vutbr.cz/research/groups/ehw/approxlib/). Hardware as well as software models are provided for each circuit.

V. Mrazek, Z. Vasicek, L. Sekanina, H. Jiang and J. Han, "[Scalable Construction of Approximate Multipliers With Formally Guaranteed Worst Case Error](https://ieeexplore.ieee.org/abstract/document/8423431)," in IEEE Transactions on Very Large Scale Integration (VLSI) Systems, vol. 26, no. 11, pp. 2572-2576, Nov. 2018, doi: 10.1109/TVLSI.2018.2856362.

#### KMap
KMap is a multiplier architecture with tunable error characteristics, that leverages a modified inaccurate 2×2 building block.

P. Kulkarni, P. Gupta and M. Ercegovac, "[Trading Accuracy for Power with an Underdesigned Multiplier Architecture](https://ieeexplore.ieee.org/abstract/document/5718826)," 2011 24th Internatioal Conference on VLSI Design, 2011, pp. 346-351, doi: 10.1109/VLSID.2011.51.

#### OU
OU is an approximate and unbiased floating-point multiplier, which is mathematically proved optimal in terms of square error for the given bases of the space {1, x, y, x<sub>2</sub>, y<sub>2</sub>}. We use the method to generate integer multipliers.

C. Chen, S. Yang, W. Qian, M. Imani, X. Yin and C. Zhuo, "[Optimally Approximated and Unbiased Floating-Point Multiplier with Runtime Configurability](https://dl.acm.org/doi/abs/10.1145/3400302.3415702)," 2020 IEEE/ACM International Conference On Computer Aided Design (ICCAD), 2020, pp. 1-9.

#### RoBA


R. Zendegani, M. Kamal, M. Bahadori, A. Afzali-Kusha and M. Pedram, "[RoBA Multiplier: A Rounding-Based Approximate Multiplier for High-Speed yet Energy-Efficient Digital Signal Processing](https://dl.acm.org/doi/abs/10.1145/3400302.3415702)," in IEEE Transactions on Very Large Scale Integration (VLSI) Systems, vol. 25, no. 2, pp. 393-401, Feb. 2017, doi: 10.1109/TVLSI.2016.2587696.






## Software

The code of our optimization method based on input distribution and polarity. 