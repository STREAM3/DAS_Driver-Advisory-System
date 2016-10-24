# Driver-Advisory-System-MATLAB-

This repository contains MATLAB executable file and script files that are used to generate the binary files. The binary files are used later on as the input for the android application. 
## MATLAB Executable Files:
To run the executable version, simply run the installer file “StreamDAS_pkg.exe”. There’s no need to have MATLAB installed on your computer to run the executable files. You will only need to install the MATLAB Compiler Runtime (MCR) to be able to run the files. The MCR installer can be found for free on MathWorks website. After the installation run the “StreamDAS.exe” to start the program. Executing “StreamDAS.exe” opens the first GUI: 
 ![11](https://cloud.githubusercontent.com/assets/22883668/19650772/c1f76c0c-9a0a-11e6-9c28-de615f109a1b.png)

This window redirects you to two sub GUIs: Main GUI and Online GUI
 
### Main GUI
 ![22](https://cloud.githubusercontent.com/assets/22883668/19650805/db1de4c2-9a0a-11e6-942b-7da294bedd88.png)
 
Main GUI is used to generate the binary file which is used as an input for the android application. For each combination of train and track data a new file is generated. Initial data are to be added before running the optimization. After filling in the initial data (1), push the “input” button (2) to add the data. The next step is to select the discretization steps. In order to solve the optimization problem, three variables of Trip Time, Trip Distance and Velocity are to be discretized and here’s where the discretization intervals are selected. You can either select the length of each step (“select the length of each step”) or select the number of steps for each variable (“select the number of steps”). After selecting the discretization intervals, push “Initial Calculation” (3) to start the optimization. A box will appear after starting the optimization which shows the progress of the process. The optimization process can take a long time depending on the number discretization steps. After finishing the optimization, the results can be saved in a binary file by pushing “Export Results to a Binary File” (4). 
To check the results you need to first select a certain point. A point in this context has three values of time passed, distance traveled and the current velocity. For instance if you need to see the optimum speed profile for the whole trip the desired point is (0, 0, 0). To check the speed profile put in the desired point coordination in the “Online Inputs” box (5) and push the “Find” button. After pushing the “Find” button, the results can be found in “Results” box (6). The results include the optimum suggested tractive effort, total energy needed for driving the train and total energy regenerated using regenerative brakes (both excluding auxiliary energy consumption). Moreover different plots can be accessed under this box. A more detailed list of results can be generated in an excel file by pushing “Save Excel” button. 
 
### Online GUI
The Online GUI is to test the already generated binary file. It basically performs a simplified process which is to be done on the android application. 
 ![33](https://cloud.githubusercontent.com/assets/22883668/19650829/ed0d86ba-9a0a-11e6-84e9-b8a39cc6168b.png)
 To use the currently available binary file it should be first selected by pushing the “select file” button (1). To read the file push “Import Binary File” button (2). The boxes “Online Input” and “Results” are the same as the ones in the Main GUI. 

## MATLAB Script Files 
The script files are also included in this repository. To run the scripts, MATLAB needs to be installed on your machine. A short description of the each file is commented at the beginning of the files. 




Contact info: 
Nima Ghaviha
nima.ghaviha@mdh.se 


