clear; close all; clc;
tic;
global h; % make h a global variable so it can be used outside the main
          % function. Useful when you do event handling and sequential move
SN = 83841563; % put in the serial number of the hardware

h = ACT_initialize(SN);

%in mm
sizeofstep = 0.01; %10 um    
Totaldistance = 0.1; %total distance of 0.1 mm
numofsteps = Totaldistance/sizeofstep; 

%jog parameters
h.SetJogStepSize(0,sizeofstep);
h.SetJogVelParams(0,0,0.3,0.3);
h.SetRelMoveDist(0,2);

ACT_home(h);

h.MoveRelative(0,1);

time_pos = zeros(numofsteps+1,2);
time_pos(1,1) = toc;
data_pos = zeros(numofsteps+1,2); %track the position of each step
data_pos(1,1) = h.GetPosition_Position(0); %record the starting position (should be home)
%loop to move (jog) the actuator forward with stepsize
for i = 1:numofsteps
    pause(0.5);
    h.MoveJog(0,1);
    activecheck = ACT_activecheck(h);
    time_pos(i+1,1) = toc;
    data_pos(i+1,1) = h.GetPosition_Position(0);
end

time_pos(i+1,2) = toc;
data_pos(i+1,2) = h.GetPosition_Position(0);
%loop to move (jog) the actuator backward with stepsize
for i = 1:numofsteps
    pause(0.5);
    h.MoveJog(0,2);
    activecheck = ACT_activecheck(h);
    time_pos(numofsteps-i+1,2) = toc;
    data_pos(numofsteps-i+1,2) = h.GetPosition_Position(0);
end

ACT_home(h);

h.StopCtrl;

close Figure 1;

