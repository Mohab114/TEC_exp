function SMU = SMU_open_gpib( sourcemeter_addr )

    if( isempty( sourcemeter_addr ) )  % Use default address
        sourcemeter_addr = 23;
    end
    
    SMU = visa( 'ni', [ 'GPIB0::' num2str( sourcemeter_addr ) '::INSTR' ] );
    fopen( SMU );
    
    fprintf( SMU, '*RST' );                     % Reset to default settings
    fprintf( SMU, ':DISP:ENAB ON' );
    
end