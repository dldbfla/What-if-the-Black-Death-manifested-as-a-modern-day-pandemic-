# What-if-the-Black-Death-manifested-as-a-modern-day-pandemic-
What if the Black Death manifested as a modern-day pandemic? 
### SIRD Model Simulation Project
This project involves the implementation of a SIRD (Susceptible, Infected, Recovered, Deceased) model to model the spread of an infectious disease. The simulation can help predict the effectiveness of public health policies by visualizing changes in infection rates before and after policy implementation.


### The project consists of
- src/: Contains the R script files for the SIRD model.
- data/: A folder of data files that can be used to store the results of model runs.
- docs/: Contains project documentation and how-to's.
- README.md: A file that describes the project overview, how to install it, and how to use it.

### Installation.

1. Clone the project:
   ```
   git clone https://github.com/yourusername/sird-model-simulation.git
   ```
3. Start an R session, and navigate to the project directory:
 ```
setwd("/path/to/sird-model-simulation")
```
5. Install the required packages (if they are not already installed):
```
if(!require(deSolve)) install.packages("deSolve")
if(!require(ggplot2)) install.packages("ggplot2")
if(!require(reshape2)) install.packages("reshape2") 
```
