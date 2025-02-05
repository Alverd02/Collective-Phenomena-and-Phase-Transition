# Ising Model
The report called "Model_de_Ising.pdf" is in catalan. I'm going to make a short version here so you can understand what's going on.
## -Physics behind the program
The Ising model consists of discrete variables located in a grid (2D) which represent the spin of the particles with values +1 or -1.
<p align="center">
  <img src="Practica%201/MontaneAlbert/ex2.jpeg" alt="ex2" width="400" height="300"/>
</p>
The Hamiltionian of this system is:

$$ H = -J\sum_{ij}S_iS_j - h\sum_{i=1}^NS_i  $$

Where J is the interaction with first neighbors, h is an external magnetic field, $$S_i$$ and $$S_j$$ are the spins of the particle i and j and N is the number of particles. In this case I will work with  h = 0 and J > 0 (ferromagnetic interaction).

The study is centered in the mark of the canonical collectivity that has the partitional function:

$$Z=\sum_ie^{\frac{E_i}{KbT}}$$

This function gives a "weight" to each state of the system given its energy $E_i$ and temperature T. Each state has a probability:

$$P_i=\frac{e^{\frac{E_i}{KbT}}}{Z}$$

Given a temperature T the system will evolve in order to minimize the energy. We will be using the Metropolis algorithm, a single spin direction of the system will be changed. If this change decreases the energy, we accept it, otherwise, we will accept the change with a distribution $e^{\frac{\Delta H}{KbT}}$, i. e. we will generate a random number $q$ between (0,1) and accept the change if $q<e^{\frac{\Delta H}{KbT}}$.


We will run this algorithm MCSTEP(Monte-Carlo steps) number of times and each one of this will have N (number of spins) spin changes. At the end of each MCSTEP we will compute the physics variables desired and make the average.


## -Details


<p>
  <img src="Practica%202/MontaneAlbert/conv_e.png" alt="ex2" width="400" height="300"/>
</p>
