clear; close all; clc;

global h; % make h a global variable so it can be used outside the main
          % function. Useful when you do event handling and sequential move
SN = 83841563; % put in the serial number of the hardware

h = ACT_initialize(SN);

%in mm
sizeofstep = 0.5; %10 um    
 
%jog parameters
h.SetJogStepSize(0,sizeofstep);
h.SetJogVelParams(0,0,0.3,0.3);

ACT_home(h);

%Jog forward
h.MoveJog(0,1);
activecheck = ACT_activecheck(h);

%Jog backward
h.MoveJog(0,2);
activecheck = ACT_activecheck(h);

%Get position at initial gap (10um)
data_pos = h.GetPosition_Position(0);



