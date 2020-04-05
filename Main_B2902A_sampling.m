%% Open instrument communication
%clear all;
%close;
tic;
SMU = SMU_open_gpib( 2 ); % Use default address

%% Sweep parameters and record data
VA_list = 0.2;    % Top-level sweep: sourcemeter bias voltage
cycles = 1;
s = 10; %samples
p = 1e-3; %period
d = 0.1; %delay
channel = 1;
compliance = 100e-6;  % 5mA

data_cells = cell( 1, cycles );

figure;

for i = 1 : cycles
    t_start = toc;
    disp( [ 'Running bias point ' num2str( i ) ' of ' num2str( length( VA_list ) ) '.' ] );
  
    CM = SMU_sampling_highfreq(SMU, channel, VA_list);
    
    fprintf( SMU, [ 'FETC:ARR:TIME? (@1)']);
    Time_raw = fgetl( SMU );
    Time = str2double(strsplit(Time_raw, ','));
        
    data_cells{ i }.VA = VA_list;
    %data_cells{ i }.V_measured = VM;
    data_cells{ i }.C_measured = CM;
    % Save start and stop time of this iteration
    data_cells{ i }.t_start = t_start;
    data_cells{ i }.t_stop = toc;
    
    
    %scatter(([0:s-1]*p)+(i-1)*(d+(s-1)*p), CM, 'linewidth', 2); 
    scatter(Time, CM, 'linewidth', 2); 
    hold on;
    
    pause(d);
    
end
SMU_set_output_off( SMU );


xlabel('Time (sec)');
ylabel('Output current (A)');
set(gca,'fontweight','bold', 'fontsize', 14);
grid on;
%% Close instrument communication
fclose( SMU );
runtime = toc;
disp( [ 'Runtime was ' num2str( runtime ) ' seconds.' ] );

%% Save workspace to mat file
%save( 'test.mat' );

