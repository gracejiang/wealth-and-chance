# OIDD 325 Case 1 Documentation

**Grace Jiang**



## 📊 2-Cluster Experiment

### 🔎 I. Experiment Overview

I wanted to conduct an experiment that took into account how varying accessibility of resources can affect wealth trends among different groups, **even if the groups start out with the same amount of wealth**.

To do this, I modified the default ExpWealthChance experiment to include 2 different clusters. Each cluster had a specific starting location that has a varying distance from the manna, which represented resources for the group. The blue group represents groups that have more accessibility to resources, and the pink group represents groups that have less accessibility to resources. Additionally, each cluster had a varying starting density. I measured how these two factors affected the final wealth outcomes of the group by looking at the % of total wealth captured by each group, as well as the mean wealth difference between the groups.



### 💭 II. Hypothesis

I hypothesized that groups that are closer to the manna would have significantly higher ending wealth outcomes, such as a higher difference in wealth means and a higher % of total wealth captured. I did not think that the density of the groups would significantly impact the total wealth captured.



### ✏️ III. Independent Variables
I modified two independent variables in this experiment:

- **Pink Cluster’s Distance from Manna** (`pink-distance-from-manna`): This is the variable that I used to represent accessibility to the resources. A lower distance from the manna represented more accessibility to the resources, and vise versa. I tested this variable in the range of 400 to 500 inclusive using increments of 2.
- **Pink Cluster’s Variance from Mean** (`pink-cluster-density`): This is the variable that I used to represent how homogeneous a group is. A lower cluster density represents a less homogeneous group (with each turtle spread farther together from one other), while a higher cluster density represents a more homogeneous group (with each turtle being closer to each other). I tested this variable in the range of 1 to 9 inclusive using increments of 2.



### 📍 IV. Control Variables
I kept several variables the same for the purpose of this experiment:

- **Blue Cluster’s Distance from Manna** (`blue-distance-from-manna`): This is the main control variable of this experiment. I set this value to 400 to have one scenario where the distances of the blue and pink clusters are equal.
- **Blue Cluster’s Density** (`blue-cluster-density`): I set this value to be 5, which is the middle density (and also one of the possible densities of the independent variables).
- **Initial Manna Distribution** (`init-manna`): This variable represents the type of resource distribution my experiment had. I set this value to Single Hill.
- **Initial Manna Amount** (`init-manna-amount`): This variable represents the amount of total resources there are. I arbitrarily set this value to 180.
- **Number of Clusters** (`num-clusters`): This variable represents the number of clusters I had. I set this value to 2.
- **Number of Turtles** (`num-turtles`): This variable represents the total number of individuals I had in the experiment. I set this value to its high end, 100, to decrease variance in my answer and to get closer to the true population mean wealth at the end. Each cluster had 50 turtles.
- **Initial Manna Distribution** (`manna-diffusion-rate`): This variable represents how much manna is diffused (spread out) in the beginning of the experiment. I arbitrarily set this value to 0.025.



### 🔬 V. Dependent Variables

These are the variables I looked at to measure the impacts of the independent variables.

- **Difference in Cluster Mean Wealth** (`blue-wealth-mean - pink-wealth-mean`): This variable showed the raw difference in wealth between the two clusters at the end of each experiment.
- **% of Total Wealth Captured by Pink Cluster** (`pink-pct-wealth`): This variable represents the total percentage of wealth that the pink cluster captures at the end of each experiment.
- **% of Total Wealth Captured by Blue Cluster** (`blue-pct-wealth`): This variable represents the total percentage of wealth that the blue cluster captures at the end of each experiment.

**Figure 1**: Example setup of my experiment.



### 📈 VI. Results

The results of this experiment were as follows.

As expected, when I increased the distance of the pink cluster to the manna, the average difference in the wealth of the two clusters increased. I found that the pink cluster accumulated a lower mean wealth **and** that the blue cluster groups accumulated a higher mean wealth.

**Figure 2:** Average difference in wealths between the two groups increased when `pink-distance-to-manna` increased.

**Figure 3**: Average % of wealth captured by the blue group significantly spiked to nearly 100% with increasing values of `pink-distance-to-manna`.

To my surprise, the density of each cluster had a direct effect on the amount of wealth captured by that cluster. Denser clusters tended to end off with less wealth than less dense clusters. In other words, the more homogenous a cluster was, the less wealth that cluster accumulated by the end of the experiments.

**Figure 4:** Average difference in wealths between the two groups linearly increased when `pink-cluster-density` increased.

**Figure 5**: Average % of wealth captured by the blue group linearly increased with when `pink-cluster-density` increased.



### 📖 **VII. Conclusion**

Overall, my results were in support of my hypothesis that groups with greater access to resources ended up significantly wealthier than groups with less access to resources. However, my results also disproved my hypothesis that density does not have an effect on wealth. Instead, I found that highly dense (homogenous) groups had a less overall wealth than low dense (non-homogeneous) groups. One possible explanation for this is that groups withlower density had more variance, and therefore had more turtles with lower distances to the manna, which led to a higher overall wealth.





## 🌱 **Wealth Growth Experiment** 

### 🔎 **I. Experiment Overview**

This experiment serves to highlight how a difference in one’s initial economic status as well as economic conditions can greatly affect the rate of wealth accumulation. This is meant to simulate how government taxes, inflation, cost of goods, as well as other regular payments affect people in different wealth brackets differently.



### 💭 **II. Hypothesis**

I hypothesized that slightly higher initial wealth accelerates exponential growth of wealth disparity along with factors from the economic environment, such as a higher cost of living and a higher interest rate.



### ✏️ Independent Variables

- **Interest Rate** (`interest-rate`): This is a variable controlling how high the interest rate goes. A higher interest rate means more interest accrued on one’s wealth over time, exponentially growing one’s total wealth.

- **Initial wealth of the Rich population** (`rich-init-wealth`): This is a variable granting the rich group a certain amount of manna to begin with. The poor group is set to 0, and must get manna themselves in order to have any wealth. This variable essentially establishes a higher starting point for the rich group. This variable was **not measured in my actual behavior space experiment, but was a part of my NetLogo model as a factor.** For this experiment, I set the initial wealth to an arbitrary value of 50.

- **Cost of Living** (`cost-of-living`): This variable affects both groups the same amount per step, and is meant to represent various payments people make in daily life that reduces their wealth, such as taxes and mortgages, etc. Higher costs of living will thus reduce more from a turtle’s total wealth at each tick. This variable was **not measured in my actual behavior space experiment, but was a part of my NetLogo model as a factor.** For this experiment, I set the cost of living to 0.

  

### 📍 **IV. Control Variables**

- **Initial Manna Distribution** (`init-manna`): This variable represents the type of resource distribution my experiment had. I set this value to Single Hill.
- **Initial Manna Amount** (`init-manna-amount`): This variable represents the amount of total resources there are. I arbitrarily set this value to 180.

- **Number of Clusters** (`num-clusters`): This variable represents the number of clusters I had. I set this value to 2.

- **Number of Turtles** (`num-turtles`): This variable represents the total number of individuals I had in the experiment. I set this value to its high end, 100, to decrease variance in my answer and to get closer to the true population mean wealth at the end.

- **Initial Manna Distribution** (`manna-diffusion-rate`): This variable represents how much manna is diffused (spread out) in the beginning of the experiment. I arbitrarily set this value to 0.025.

  

### 🔬 **V. Dependent Variables**

- **Difference in Mean Wealth** (`blue-wealth-mean - pink-wealth-mean`): This measures the wealth disparity between the rich and the poor as a result of the independent variables. The larger the number, the greater the inequality between the two groups.

- **% of Wealth Captured by Rich Group** (`blue-pct-wealth`): This tracks the proportion of all wealth concentrated in the hands of the rich.

-  **% of Wealth Captured by Poor Group** (`pink-pct-wealth`): This tracks the proportion of all wealth concentrated in the hands of the poor.

  

### 📈 **VI. Results**

**Figure 6**: Sample experiment.

The results of the experiment showed that higher interest rates and initial wealth help grow wealth at an extremely high exponential rate, widening the wealth disparity between the average wealth of a rich turtle (blue) and that of a poor turtle (pink).

**Figure 7**: Higher interest rates lead to an exponentially higher difference of wealth means between the two groups. However, this graph is not adjusted for inflation, since these are the raw wealth values.

**Figure 8**: Higher interest rates leads to the rich group capturing a higher percentage of overall wealth than the poor group. This graph does account for inflation because it is taken as a percentage graph and not a raw value graph.



### 📖 **VII. Conclusion**

My results indicate that my hypotheses were correct, although the magnitude of interest rate’s effect was a little smaller than anticipated. An explanation for this may be that my relative scaling is not proportional to what it would look like in real life, as my principals are still fairly small and close together when considering the magnitude of income.

My results could have been finer tuned to adjust for inflation by perhaps dividing by the compounded interest rate at each tick. However, I did adjust for some inflation by using proportions of wealth instead of just the raw wealth values in the second graph.

In future experiments, I would like to spend more time researching cost of living and interest rates in order to more closely simulate a person’s experience living in America. I hypothesize that differing costs of living would impact the two populations in a different way, as a higher costs of living lowers wealth and increases overall wealth disparity. This is because I believe it will drop the poor group’s average wealth by a much higher percentage, which in turn lowers the principal used for interest calculations. If taken high enough, the poor group could potentially not increase their wealth, or even decrease over time.