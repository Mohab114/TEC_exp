
%in mm
sizeofstep = 0.005; %5 um    
Totaldistance = 0.5; %total distance of 500 um
numofsteps = Totaldistance/sizeofstep; 

%jog parameters
h.SetJogStepSize(0,sizeofstep);
h.SetJogVelParams(0,0,0.3,0.3);



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

