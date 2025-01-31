# Ising Model
The report called "Model_de_Ising.pdf" is in catalan. I'm going to make a short version here so you can understand what's going on.
## -Physics behind the program
The Ising model consists of discrete variables located in a grid (2D) which represent the spin of the particles with values +1 or -1.
<p align="center">
  <img src="Practica%201/MontaneAlbert/ex2.jpeg" alt="ex2" width="400" height="300"/>
</p>
The Hamiltionian of this system is:

$$ H = -J\sum_{ij}S_iS_j - h\sum_{i=1}^NS_i  $$

Where J is the interaction with first neighbors, h is an external magnetic field, $$S_i$$ and $$S_j$$ are the spins of the particle i and j and N is the number of particlesS. In this case I will work with  h = 0 and J > 0 (ferromagnetic interaction).


This study is about the evolution of the system given a temperature
