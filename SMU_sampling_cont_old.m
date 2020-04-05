function current_measured = SMU_sampling_cont(SMU, channel, volt)

    if( channel == 1 || channel == 2 )
        ch_str   = num2str( channel );
        volt_str = num2str( volt );
        
        fprintf( SMU, [ ':SOUR' ch_str ':FUNC:MODE VOLT' ]);
        fprintf( SMU, [ ':SOUR' ch_str ':VOLT: 0.01' ]);
        
        fprintf( SMU, [ ':SOUR' ch_str ':VOLT:MODE SWE' ]);
        fprintf( SMU, [ ':SOUR' ch_str ':SWE:SPAC LIN' ]);
        fprintf( SMU, [ ':SOUR' ch_str ':VOLT:STAR ' volt_str ]);
        fprintf( SMU, [ ':SOUR' ch_str ':VOLT:STOP ' volt_str ]);
        fprintf( SMU, [ ':SOUR' ch_str ':VOLT:POIN 1' ]);
        
        fprintf( SMU, [ ':SENS' ch_str ':FUNC "CURR:DC"' ] ); % enable current measurement
        %fprintf( SMU, [ ':SENS' ch_str ':CURR:NPLC 1' ] ); % Sets the number of power line cycles (NPLC) value instead of setting the integration time for one point measurement.
        fprintf( SMU, [ ':SENS' ch_str ':CURR:PROT 100e-6' ] );
        
        fprintf( SMU, [ ':TRIG' ch_str ':SOUR TIM' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':TRAN:COUN 1' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':TRAN:DEL 1e-2' ] );
        
        fprintf( SMU, [ ':TRIG' ch_str ':ACQ:COUN 10' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':ACQ:DEL 1e-3' ] );
        fprintf( SMU, [ ':TRIG' ch_str ':ACQ:TIM 2e-3' ] );
        
        
        fprintf( SMU, ':OUTP ON' );
        
        fprintf( SMU, [ ':INIT (@' ch_str ')']);
        fprintf( SMU, [ 'FETC:ARR:CURR? (@' ch_str ')']);
        
        current_measured_raw = fgetl( SMU );
        current_measured = str2double(strsplit(current_measured_raw, ','));
    else
        disp( 'Error: invalid SMU channel selected, no action taken' )
    end

end
