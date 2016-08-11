## Design of Experiments - The Sprinkler experiment

Authors: Ghizlaine Bennani, [Jason Helgren](https://github.com/jhelgren), [Jaime Pastor](https://github.com/jaimeps) <br />
*(Report available upon request)*

### Problem description

Optimize the design of a lawn sprinkler, such that coverage range is maximized.
<p align="center">
	<img src="https://github.com/jaimeps/design-of-experiments-sprinkler/blob/master/images/sprinkler.png" width = 300> <br />
</p>

### Data

Simulations were obtained from the [Garden Sprinkler Simulation](https://perswww.kuleuven.be/~u0059569/doe/sprinkler/default.php)

The factors that influence the response variable are shown below:
<img src="https://github.com/jaimeps/design-of-experiments-sprinkler/blob/master/images/factors.png" width = 800> 

### Screening experiment

In our first experiment,we used a **2<sup>8-4</sup> fractional factorial design** with the goal of discriminating the most relevant factors and interactions. Once we obtained the result of the 16 runs, we built a model including the 8 factors of the experiment and 7 two-way interactions. The remaining 21 two-way interactions were aliased. A q-q plot suggested six significant effects (effect size is twice the absolute value of the model coefficient):
<img src="https://github.com/jaimeps/design-of-experiments-sprinkler/blob/master/images/significant_factors.png" width = 600> 

### Optimization experiment

We ran a second **2<sup>4</sup> full factorial experiment** with only the four significant factors: the vertical nozzle angle, the nozzle profile, the head diameter and the entrance pressure. The remaining factors, determined to be insignificant in the screening experiment, were arbitrarily set to their low values. We assumed that 3 replicates, for a total of 48 runs, to be reasonable and affordable. We built a model including the factors and all the two-way and three-way interactions, and then used backwards elimination to remove the following interaction terms.

Our resulting model yields the following relevant variables:
<img src="https://github.com/jaimeps/design-of-experiments-sprinkler/blob/master/images/final_model.png" width = 450> 

### Results
The main effects plot suggest that  higher values of the vertical nozzle angle, the nozzle profile and the entrance pressure increase the range of the sprinkler. In contrast, a  low diameter of the head is preferred in this context. Further analysis of the interaction plots confirm these recommendations.

### Prediciton
Selecting the estimated optimal parameters, we obtain the following prediction and confidence interval for the range of the sprinkler: <br />
<img src="https://github.com/jaimeps/design-of-experiments-sprinkler/blob/master/images/prediction.png" width = 600>  <br />
Conducting 10 confirmation runs with the above mentioned levels, we obtain a mean range of  6.9592 , which falls between our 95% confidence interval.

### References
- Nathaniel Stevens - *Design of Experiments: Course notes*
- Douglas C. Montgomery. - *Design and Analysis of Experiments*