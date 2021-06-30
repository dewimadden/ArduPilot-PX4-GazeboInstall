#!/bin/bash
cd ~
mkdir Test_Development
cd Test_Development
echo "This will take about 5-10 minutes"
echo "STARTING"
echo "STEP 1/10 Installing Git Gui" 
echo "===================="
sudo apt-get update
sudo apt-get install
sudo apt-get install gitk git-gui
echo "Git GUI Successfully Installed"

echo "STEP 2/10 Now installing Ardupilot"
echo "===================="
git clone https://github.com/ArduPilot/ardupilot.git
echo "navigating to ardupilot directory"
cd ardupilot
git submodule update --init --recursive

echo "STEP 3/10 Fixing pre-requisites"
echo "===================="
cd Tools/environment_install/
install-prereqs-ubuntu.sh -y

echo "STEP 4/10 resetting directory and user profile"
echo "===================="
. ~/.profile

echo "STEP 5/10 Performing clean build"
echo "===================="
cd ~
cd ardupilot
./waf clean

echo "STEP 6/10 Let's go back to the Test Development Directory"
echo "===================="
cd ~
cd Test_Development

echo "STEP 7/10 Now let's install Gazebo"
echo "===================="
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt update

sudo apt install gazebo9 libgazebo9-dev

echo "STEP 8/10 Time to install your plugins for ArduPilot"
echo "===================="
git clone https://github.com/khancyr/ardupilot_gazebo
cd ardupilot_gazebo
mkdir build
cd build
cmake ..
make -j4
sudo make install

echo "STEP 9/10 Resetting directory and user profile"
echo "===================="
. ~/.profile
cd ~

echo "STEP 10/10 I will now install PixHawk 4"
echo "===================="
cd Test_Development
git clone https://github.com/PX4/PX4-Autopilot.git --recursive
bash ./PX4-Autopilot/Tools/setup/ubuntu.sh

## Final Step  - QGroundControl
echo "Setting QGroundControl Permissions, after this is complete, please log out and log back in again"
sudo apt-get install gnome-terminal ## Install gnome-terminal to run multiple shell windows at once. 
sudo usermod -a -G dialout $USER
sudo apt-get remove modemmanager -y
sudo apt install gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-gl -y

echo "Now making RunSim script"
chmod +x ./RunSim.sh
. ~/.profile
echo "INSTALLATION SUCCESSFUL, ensure QGroundControl App Image is in working directory Test_Development"

exec bash


