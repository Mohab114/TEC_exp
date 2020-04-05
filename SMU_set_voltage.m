function voltage_measured = SMU_set_voltage( SMU, channel, voltage, compliance )
    
    if( channel == 1 || channel == 2 )
        ch_str   = num2str( channel );
        volt_str = num2str( voltage );
        cmp_str  = num2str( compliance );
        
        fprintf( SMU, [ ':SOUR' ch_str ':FUNC:MODE VOLT' ] );    % Configure voltage output
        fprintf( SMU, [ ':SOUR' ch_str ':VOLT ' volt_str ] );   % set the output level immediately
        fprintf( SMU, [ ':SENS' ch_str ':CURR:PROT ' cmp_str ] );   % set current complicance
        fprintf( SMU, ':OUTP ON' );
        
        fprintf( SMU, [ ':SENS' ch_str ':FUNC:OFF:ALL' ] ); % disables all measurement functions
        fprintf( SMU, [ ':SENS' ch_str ':FUNC "VOLT:DC"' ] ); % enable voltage measurement
        fprintf( SMU, [ ':SENS' ch_str ':VOLT:NPLC 1' ] ); % Sets the number of power line cycles (NPLC) value instead of setting the integration time for one point measurement.
        fprintf( SMU, [ ':MEAS:VOLT:DC? (@' ch_str ')'] ); % Executes a spot (one-shot) measurement and returns the measurement result data.
        voltage_measured = str2double( fgetl( SMU ) );
    else
        disp( 'Error: invalid SMU channel selected, no action taken' )
    end
    
end