# Adaptable Approximate Multiplier Design Driven by Input Distribution and Polarity

## ApproxFlow

ApproxFlow is a toolbox to evaluate the DNN accuracy with the approximate multiplier. In ApproxFlow, each approximate multiplier is described by a look-up table. A DNN is represented by a directional acyclic graph (DAG), where each vertex denotes a DNN layer and the edges indicate the data flow. When a vertex in the DAG is executed, its dependencies will be executed automatically.

The code is available at: https://github.com/FDU-ME-ARC/ApproxFlow

## Multipliers

The C++ and Verilog models of reproduced multipliers and generated multipliers.

### unsigned 8-bit multipliers

#### AC
[A. Momeni, J. Han, P. Montuschi and F. Lombardi, "Design and Analysis of Approximate Compressors for Multiplication," in IEEE Transactions on Computers, vol. 64, no. 4, pp. 984-994, April 2015, doi: 10.1109/TC.2014.2308214.](https://ieeexplore.ieee.org/abstract/document/6748013)

 CR [C. Liu, J. Han and F. Lombardi, "A low-power, high-performance approximate multiplier with configurable partial error recovery," 2014 Design, Automation & Test in Europe Conference & Exhibition (DATE), 2014, pp. 1-4, doi: 10.7873/DATE.2014.108.](https://ieeexplore.ieee.org/abstract/document/6800309)

 DesignW


## Software

The code of our optimization method based on input distribution and polarity. 