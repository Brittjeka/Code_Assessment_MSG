# Code_Assessment_MSG
Code for the assessment of the MSG team of TNO - Britt Krabbenborg

# Assessment goal 
The task is to add a model for the Patriot air defense system. This system consists of three elements: Radar, IFF, and Firing Unit. The radar scans for inbound threats and outputs a line from the `radar_data`. The IFF module checks if a hostile entity is detected by comparing the odd and even value entries in the decimal representation of the radar output. The Firing Unit fires a missile if a hostile entity is detected, and the chance of succesful engagement is simulated by comparing a random number with a Probability of Kill (PK) ratio. This random number is picked from a random number generator with a uniform distribution.


# Run the file case_TNO_Britt_Krabbenborg.m in MATLAB 

The data is stored in a vector called `radar_data` and is included by the assignment. It is a vector containing binary numbers.

The function `runSimulation` is the main function of the Patriot air defense system and calls the other functions that simulates the three elements of the system:
- The behavior of the radar is simulated with the function `extractRadarData`.
- The behavior of the IFF module is simulated with the function `isHostile`. 
- The behavior of the Firing Unit is simulated with the function `checkAndLaunch`.
- Engagement success of the launched missile is simulated with the function `isTargetNeutralized`.

