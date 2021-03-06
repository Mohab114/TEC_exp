clear; close all; clc;
tic;

%initilaize
addr = 2;
SMU = SMU_open_gpib( addr ); %for B2902A
global h;
SN = 83841563;
h = ACT_initialize(SN); %for Z812V

%parameters for Z812V
sizeofstep = 0.01; %10 um 
totaldist = 0.1; %total distance of 0.1 mm
numofsteps = totaldist/sizeofstep; %total distance of 0.1 mm
h.SetJogStepSize(0,sizeofstep);
h.SetJogVelParams(0,0,0.3,0.3); %channel, min vel, acc, max vel
%h.SetRelMoveDist(0,-totaldist); %-ve to move backward
time_pos = zeros(numofsteps+1,2); %track the time of each step
data_pos = zeros(numofsteps+1,2); %track the position of each step


%parameters for B2902A
VA_list = 0.0 : 1 : 5.0;    % Top-level sweep: sourcemeter bias voltage
channel = 1;
compliance = 5e-3;  % 5mA
data_cells_forward = cell( numofsteps+1, length( VA_list ) );
data_cells_backward = cell( numofsteps+1, length( VA_list ) );

%homing the actuator
ACT_home(h);

%time_pos(1,1) = toc;
%data_pos(1,1) = h.GetPosition_Position(0); %record the starting position (should be home)
%loop to move (jog) the actuator forward with stepsize
for j = 1 : length( VA_list ) 
    for i = 1:numofsteps+1
        time_pos(i,1) = toc;
        t_start = toc;
        data_pos(i,1) = h.GetPosition_Position(0);
        
        disp( [ 'Forward: Running bias point ' num2str(VA_list(j)) 'V at position ' num2str(data_pos(i,1)) 'mm'] );
        VM = SMU_set_voltage( SMU, channel, VA_list( j ), compliance );
        pause(0.5);
        CM = SMU_measure_current( SMU, channel);

        data_cells_forward{i, j }.VA = VA_list( j );
        data_cells_forward{i, j }.V_measured = VM;
        data_cells_forward{i, j }.C_measured = CM;
        % Save start and stop time of this iteration
        data_cells_forward{i, j }.t_start = t_start;
        data_cells_forward{i, j }.t_stop = toc; 
        data_cells_forward{i, j }.pos = data_pos(i,1);
        
        pause(0.5);
        if (i ~= numofsteps+1) h.MoveJog(0,1); end  %so that the actuator doesnt make an extra step at the end
        activecheck = ACT_activecheck(h);
    end
    
    %SMU_set_voltage( SMU, channel, VA_list( 1 ), compliance ); %if u only switch OFF the ouput, then next time u switch it back on, it will remember the last value, so u want to reset that to zero (or first value in ur bias sweep)
    SMU_set_output_off( SMU ); %to make sure to turn off the last applied voltage before stepping the actuator
    %ACT_home(h);
    %h.MoveRelative(0,1); %get it back to the home position
    pause(0.5);
    
    for i = 1:numofsteps+1
        time_pos(numofsteps+1-i+1,2) = toc;
        t_start = toc;
        data_pos(numofsteps+1-i+1,2) = h.GetPosition_Position(0);
        
        disp( [ 'Backward: Running bias point ' num2str(VA_list(j)) 'V at position ' num2str(data_pos(numofsteps+1-i+1,2)) 'mm'] );
        VM = SMU_set_voltage( SMU, channel, VA_list( j ), compliance );
        pause(0.5);
        CM = SMU_measure_current( SMU, channel);

        data_cells_backward{i, j }.VA = VA_list( j );
        data_cells_backward{i, j }.V_measured = VM;
        data_cells_backward{i, j }.C_measured = CM;
        % Save start and stop time of this iteration
        data_cells_backward{i, j }.t_start = t_start;
        data_cells_backward{i, j }.t_stop = toc; 
        data_cells_backward{i, j }.pos = data_pos(numofsteps+1-i+1,2);
        
        pause(0.5);
        if (i ~= numofsteps+1) h.MoveJog(0,2); end  %so that the actuator doesnt make an extra step at the end
        activecheck = ACT_activecheck(h);
    end
    
    SMU_set_output_off( SMU );
    pause(0.5);
    
end


ACT_home(h);
%h.StopCtrl;
%close Figure 1;

SMU_set_output_off( SMU );
fclose( SMU );
runtime = toc;
disp( [ 'Runtime was ' num2str( runtime ) ' seconds.' ] );

save( 'test.mat' );

