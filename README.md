# Adaptable Approximate Multiplier Design Driven by Input Distribution and Polarity

## ApproxFlow

ApproxFlow is a toolbox to evaluate the DNN accuracy with the approximate multiplier. In ApproxFlow, each approximate multiplier is described by a look-up table. A DNN is represented by a directional acyclic graph (DAG), where each vertex denotes a DNN layer and the edges indicate the data flow. When a vertex in the DAG is executed, its dependencies will be executed automatically.

The code is available at: https://github.com/FDU-ME-ARC/ApproxFlow

## Multipliers

The C++ and Verilog models of reproduced multipliers and generated multipliers.

### unsigned 8-bit multipliers

#### AC
A. Momeni, J. Han, P. Montuschi and F. Lombardi, "[Design and Analysis of Approximate Compressors for Multiplication](https://ieeexplore.ieee.org/abstract/document/6748013)", in IEEE Transactions on Computers, vol. 64, no. 4, pp. 984-994, April 2015, doi: 10.1109/TC.2014.2308214.

#### CR
C. Liu, J. Han and F. Lombardi, "[A low-power, high-performance approximate multiplier with configurable partial error recovery](https://ieeexplore.ieee.org/abstract/document/6800309)", 2014 Design, Automation & Test in Europe Conference & Exhibition (DATE), 2014, pp. 1-4, doi: 10.7873/DATE.2014.108.

#### DesignW
DesignW is a exact multiplier implemented using Verilog star operator, which is usually built from DesignWare library in Synopsys Design Compiler tool.

#### EvoApprox8b
[EvoApprox8b](http://www.fit.vutbr.cz/research/groups/ehw/approxlib/) is a library that contains 500 Pareto optimal 8-bit approximate multipliers evolved by a multi-objective Cartesian Genetic Programming (CGP).

V. Mrazek, R. Hrbacek, Z. Vasicek and L. Sekanina, "[EvoApprox8b:  Library of Approximate Adders and Multipliers for Circuit Design and Benchmarking of Approximation Methods](https://ieeexplore.ieee.org/abstract/document/7926993)", Design, Automation & Test in Europe Conference & Exhibition (DATE), 2017, 2017, pp. 258-261, doi: 10.23919/DATE.2017.7926993.

#### EvoApproxLib^LITE








## Software

The code of our optimization method based on input distribution and polarity. 