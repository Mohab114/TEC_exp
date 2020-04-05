function current_measured = SMU_sample_current(SMU, channel)

    if( channel == 1 || channel == 2 )
        ch_str   = num2str( channel );
        fprintf( SMU, [ ':SENS' ch_str ':FUNC "CURR:DC"' ] ); % enable current measurement
        fprintf( SMU, [ ':SENS' ch_str ':CURR:NPLC 1' ] ); % Sets the number of power line cycles (NPLC) value instead of setting the integration time for one point measurement.
        %fprintf( SMU, [ ':MEAS:CURR:DC? (@' ch_str ')'] ); % Executes a spot (one-shot) measurement and returns the measurement result data.
        
        fprintf( SMU, [ ':TRIG' ch_str ':ACQ:DEL 2.0e-3' ] );
        %fprintf( SMU, [ ':TRIG' ch_str ':SOUR TIM' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':TIM 4e-3' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':COUN 6' ] );
        
        fprintf( SMU, [ ':INIT (@' ch_str ')']);
        fprintf( SMU, [ 'FETC:ARR:CURR? (@' ch_str ')']);
        
        current_measured = str2double( fgetl( SMU ) );
    else
        disp( 'Error: invalid SMU channel selected, no action taken' )
    end

end
