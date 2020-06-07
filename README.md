# Disease/Epidemic Simulator
A simple SIR/SIS individual-based model (IBM) for the spread of disease based on various factors, built in the Godot Game Engine with GDScript.

## Installation & System Requirements

##### Option 1: Download and Run .EXE
Only Supported on Windows 10.
1. Download the [simulation exe](https://raw.githubusercontent.com/dkantereivin/disease-simulator-godot/master/Builds/Kanter_Eivin_Disease_Sim.exe) and [resource pack](https://github.com/dkantereivin/disease-simulator-godot/raw/master/Builds/Kanter_Eivin_Disease_Sim.pck).
2. Place both files into the same folder and then execute the exe file.
##### Option 2: Build from Source Code
On Any Godot Compatible Operating System.
1. [Download the Godot Engine](https://godotengine.org/download) for your Operating System.
2. Clone this repository to your computer (using Git, or download and unzip).
3. Open your Godot installation, and import project.godot from this folder.
4. Press the play button in the top right to build and execute the game.
### Usage
The engine offers a simple interface with several parameter inputs to modify the simulation. To run the simulation, simply fill up all boxes and press the Play button.
Once you start the game, you can no longer modify it's parameters. To freeze the simulation, toggle the pause button (previously play).
To reset the simulation on screen, press the stop square -- all simulated individuals will be removed.

The simulated individuals are each represented as coloured dots on the screen. Green dots represent susceptible individuals who are disease (-), red are active and infective (+) cases, purple are individuals who are immune and not infective, and black represents deceased individuals.

To export data from any simulation, pause it, and then press "Export Data". The output files are in `.csv` format (for maximum compatibility) and are located at: `%APPDATA%\Godot\app_userdata\Disease Simulator`.
### Parameters
All percent values should be represented as their whole numbers, and not represented as decimals (i.e. 95.5% chance should be 95.5, not 0.955). Do not include any units (i.e. %, s)
* `int` population. Control the number of simulated individuals, which also controls density (individuals per screenArea). For performance reasons, this is suggested to be between 3 - 300 (depending on your hardware).
* `float` infection chance (%). The likelihood that an infection will be transmitted from a single interaction between two individuals (a collision).
* `float` social distancing (%). The percent of the population which is following social distancing (see below).
* `float` infection duration (s). The amount of time, in seconds, which an infection lasts. After individuals have been infected for this period of time, they either are cured and switch to the immunity phase, or they become deceased.
* `float` immunity duration (s). The number of seconds which a recovered individual's immunity lasts. During this period of time, they cannot transmit disease nor become re-infected.
* `float` mortality rate (%). The chance that an infected individual will die after their 14 day infective period.
## Simulation Methods
This simulation is *not* intended as a scientifically sound, lab-ready simulation. It serves three main purposes:
1. An effective introduction to biological modelling and statistics.
2. A simple visualization tool for visually demonstrating the effects of various parameters, as well as visualizing the spread of disease. It is especially effective to demonstrate the effectiveness of social distancing (in conjunction with exported graphs), and for teaching Grade 9 level Ontario science students about epidemiology, social distancing, and biostatistics.
3. An effective tool for quickly analyzing and testing hypothesis, due to it's easy visualizing, data-export capability, and low computational requirements.

The simulation is modelled off the SIS/SIR method for modelling the spread of disease by modelling the interactions between individuals (individual-based models, IBM).
`population` Individuals in an enclosed space constantly move, in a random fashion, and each time they collide their direction is altered (using the physics engine) and this is considered "an interaction." 
If one of the colliding individuals is infective, the other individual has a `infection_chance` likelihood of contracting the pathogen. 
If they are infected, they immediately become infective for `infection_duration` seconds (simulated time), where they can infect others. After this time, the simulation randomly determines whether or not they will die, based on `mortality_rate`.
If they develop immunity, it lasts `immunity_duration` seconds, after which they become susceptible once again. Deceased individuals stop moving and can no longer contract nor spread the pathogen.

The simulation contains "transporters" who move around randomly, and "passives" who follow social-distancing guidelines and avoid travel/unnecessary contact with others.
Individuals who are social distancing do not move, however they can contract and spread the disease. 
This is to simulate contact with friends, neighbors, or individuals at work -- they only visit the same areas, but once "transporters" visit the disease can spread to other areas.

#### Limitations
While this simulation offers some realistic visualizations, there are several major limitations to its accuracy and effectiveness.
* performance (limited by number of individuals)
* no behavioral modelling. Movements are random whereas in real life, individuals typically follow movement patterns.
* social distancing model is simplistic, yet ultimately effective. Could be better simulated with a non-binary social distancing system (i.e. reduced movement)
* individual uniformity. Individuals are all affected by the same factors - age, immune strength, etc is not factored into the simulation, which does not maximize the potential of IBM.


## License
This project is licensed under a modified version MIT license. It may not be used, modified, or distributed commercially without permission. Educational institutions may use this software for teaching and research purposes, as well as any other use covered in the MIT license.
## Author & Support
Built by David Kanter Eivin for the final summative of SBI4UE (Grade 12 Biology) at the University of Toronto Schools. For support, please contact [David.KanterEivin@gmail.com](mailto:david.kantereivin@gmail.com).

Pull requests are welcome! Please keep PRs atomic, and avoid the use of C# for consistency: GDScript and GDNative (C++) only!

## Sources Consulted
Chowell, G., Sattenspiel, L., Bansal, S., & Viboud, C. (2016). Mathematical models to characterize early epidemic growth: A Review. Physics of Life Reviews, 18, 66–97. https://doi.org/10.1016/j.plrev.2016.07.005

Downey, A. B. (2014). Think Stats: Exploratory Data Analysis in Python (1st ed., Vol. 2). Green Tea Press. https://greenteapress.com/wp/think-stats-2e/

Kitware Inc. (2020). System Methodology. Pulse Physiology Engine. https://pulse.kitware.com/_system_methodology.html

Kumaar, A. (2020, May 16). DIY Data analysis of COVID-19. Medium. https://medium.com/analytics-vidhya/diy-data-analysis-of-covid-19-da6cd0c99cd8

Maghsoudi, S. (2020, March 21). Building your own Covid-19 Epidemic Simple Model Using Python. Towards Data Science. https://towardsdatascience.com/building-your-own-covid-19-epidemic-simple-model-using-python-e39788fbda55

Stevens, H. (2020, March 14). Why outbreaks like coronavirus spread exponentially, and how to “flatten the curve.” Washington Post. https://www.washingtonpost.com/graphics/2020/world/corona-simulator/

Willem, L., Verelst, F., Bilcke, J., Hens, N., & Beutels, P. (2017). Lessons from a decade of individual-based models for infectious disease transmission: A systematic review (2006-2015). BMC Infectious Diseases, 17. https://doi.org/10.1186/s12879-017-2699-8

Yates, C. (2020, March 25). How to model a pandemic. The Conversation. http://theconversation.com/how-to-model-a-pandemic-134187
