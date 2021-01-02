# turning-control-sim
Turning Control System for a Wheeled Rover assigned in Simulation of Engineering Systems 3

System modeled using nine state variables in a state space model and integrated using the Runge Kutta integration method with a fixed step size of 0.001s.
An additional euler integration term was included within the control section of the main code to improve performance of the coupler. Appropriate gain values were selected to improve the stability and speed of response of the system (see below). 

![](/Pictures/Output.png)

Variable forward velocity was introduced to simulate the variable longitudinal dynamics of the rover. The Newton's Divided Difference interpolation method is used to estimate the velocity curve given by a set of data points (see below).   

![](/Pictures/Velocity.png)
