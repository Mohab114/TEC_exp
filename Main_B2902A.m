%% Open instrument communication
%clear all;
%close;
tic;
SMU = SMU_open_gpib( 23 ); % Use default address

%% Sweep parameters and record data
VA_list = -0.1 : 0.01 : 0.8;    % Top-level sweep: sourcemeter bias voltage
%VA_list = ones(1,30)*5;
channel = 1;
compliance = 0.7;  % 5mA

data_cells = cell( 1, length( VA_list ) );

figure;

for i = 1 : length( VA_list )
    t_start = toc;
    disp( [ 'Running bias point ' num2str( i ) ' of ' num2str( length( VA_list ) ) '.' ] );
    VM = SMU_set_voltage( SMU, channel, VA_list( i ), compliance );
    pause(0.1);
    CM = SMU_measure_current( SMU, channel);
    
    data_cells{ i }.VA = VA_list( i );
    data_cells{ i }.V_measured = VM;
    data_cells{ i }.C_measured = CM;
    % Save start and stop time of this iteration
    data_cells{ i }.t_start = t_start;
    data_cells{ i }.t_stop = toc;
    
    pause(0.1);
    
    
    scatter(VM, CM, 'linewidth', 2);
    %scatter(i, CM, 'linewidth', 2);
    xlabel('Bias voltage (V)');
    ylabel('Output current (A)');
    set(gca,'fontweight','bold', 'fontsize', 14);
    grid on;
    hold on;
    
end 
SMU_set_output_off( SMU );

%% Close instrument communication
fclose( SMU );
runtime = toc;
disp( [ 'Runtime was ' num2str( runtime ) ' seconds.' ] );

%% Save workspace to mat file
%save( 'test.mat' );

