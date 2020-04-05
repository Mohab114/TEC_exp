function current_measured = SMU_sampling_highfreq(SMU, channel, trig_volt)

    if( channel == 1 || channel == 2 )
        ch_str   = num2str( channel );
        trig_volt_str = num2str( trig_volt);
        
        fprintf( SMU, [ ':SOUR' ch_str ':FUNC:MODE VOLT' ]);
        fprintf( SMU, [ ':SOUR' ch_str ':FUNC:SHAP PULS' ]);
        fprintf( SMU, [ ':SOUR' ch_str ':VOLT:MODE LIST' ]);
        fprintf( SMU, [ ':SOUR' ch_str ':LIST:VOLT 10, 20, 10, 20, 10, 20' ]);
        
        %fprintf( SMU, [ ':SOUR' ch_str ':VOLT 0' ]);
        %fprintf( SMU, [ ':SOUR' ch_str ':VOLT:TRIG ' trig_volt_str ]);
        
        %fprintf( SMU, [ ':SOUR' ch_str ':PULS:DEL 0.5e-3' ]);
        fprintf( SMU, [ ':SOUR' ch_str ':PULS:WIDT 3e-4' ]);
        
        %fprintf( SMU, [ ':SENS' ch_str ':FUNC ""CURR""' ] );
        fprintf( SMU, [ ':SENS' ch_str ':FUNC "CURR:DC"' ] ); % enable current measurement
        fprintf( SMU, [ ':SENS' ch_str ':CURR:APER 1e-4' ] ); % Sets the number of power line cycles (NPLC) value instead of setting the integration time for one point measurement.
        fprintf( SMU, [ ':SENS' ch_str ':CURR:PROT 100e-6' ] );
        %fprintf( SMU, [ ':SENS' ch_str ':CURR:RANG:AUTO OFF' ] );
        %fprintf( SMU, [ ':SENS' ch_str ':CURR:RANG 100e-3' ] );
        %fprintf( SMU, [ ':MEAS:CURR:DC? (@' ch_str ')'] ); % Executes a spot (one-shot) measurement and returns the measurement result data.
        
        %fprintf( SMU, [ ':TRIG' ch_str ':TRAN:DEL 0.1e-3' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':ACQ:DEL 2e-4' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':SOUR TIM' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':TIM 5e-4' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':COUN 6' ] );
        
        fprintf( SMU, ':OUTP ON' );
        
        fprintf( SMU, [ ':INIT (@' ch_str ')']);
        fprintf( SMU, [ 'FETC:ARR:CURR? (@' ch_str ')']);
        
        current_measured_raw = fgetl( SMU );
        current_measured = str2double(strsplit(current_measured_raw, ','));
    else
        disp( 'Error: invalid SMU channel selected, no action taken' )
    end

end
