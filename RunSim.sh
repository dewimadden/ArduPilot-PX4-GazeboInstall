#!/bin/bash

## Author: Dewi Madden
## Simulator Run Script for ArduPilot and Pixhawk Simulators with Gazebo Support. 
## Compatibility: Linux Only
## Format: Shell Script

## =========================

## Step 1 - Pre-requisites in Development folder.
### User must be in their working directory with all relevant shell scripts within it. In the installation script this was Test_Development. 

cd ~ # Navigate to main directory. 
cd Test_Development # Navigates to working directory that was created with InstallSim.sh

## Step 2 - Open the necessary Simulator Elements
gnome-terminal --title=QGroundControl \\
               -- bash -c "cd Test_Development && chmod +x ./QGroundControl.AppImage && ./QGroundControl.AppImage ; bash"

