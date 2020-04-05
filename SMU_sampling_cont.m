function current_measured = SMU_sampling_cont(SMU, channel, trig_volt)

    if( channel == 1 || channel == 2 )
        ch_str   = num2str( channel );
        trig_volt_str = num2str( trig_volt);
        
        fprintf( SMU, [ ':SOUR' ch_str ':FUNC:MODE VOLT' ]);
        fprintf( SMU, [ ':SOUR' ch_str ':VOLT:TRIG ' trig_volt_str ]);
        
        %fprintf( SMU, [ ':SENS' ch_str ':FUNC ""CURR""' ] );
        fprintf( SMU, [ ':SENS' ch_str ':FUNC "CURR:DC"' ] ); % enable current measurement
        fprintf( SMU, [ ':SENS' ch_str ':CURR:NPLC 1' ] ); % Sets the number of power line cycles (NPLC) value instead of setting the integration time for one point measurement.
        fprintf( SMU, [ ':SENS' ch_str ':CURR:PROT 100e-6' ] );
        %fprintf( SMU, [ ':MEAS:CURR:DC? (@' ch_str ')'] ); % Executes a spot (one-shot) measurement and returns the measurement result data.
        
        fprintf( SMU, [ ':TRIG' ch_str ':ACQ:DEL 1.5e-3' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':SOUR TIM' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':TIM 2e-3' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':COUN 20' ] );
        
        fprintf( SMU, ':OUTP ON' );
        
        fprintf( SMU, [ ':INIT (@' ch_str ')']);
        fprintf( SMU, [ 'FETC:ARR:CURR? (@' ch_str ')']);
        
        current_measured_raw = fgetl( SMU );
        current_measured = str2double(strsplit(current_measured_raw, ','));
    else
        disp( 'Error: invalid SMU channel selected, no action taken' )
    end

end
