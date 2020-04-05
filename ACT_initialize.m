function h = ACT_initialize(SN)
    % Create Matlab Figure Container
    fpos    = get(0,'DefaultFigurePosition'); % figure default position
    fpos(3) = 650; % figure window size;Width
    fpos(4) = 450; % Height


    f = figure('Position', fpos,...
               'Menu','None',...
               'Name','APT GUI');
           
    % Create ActiveX Controller
    h = actxcontrol('MGMOTOR.MGMotorCtrl.1',[20 20 600 400 ], f);

    % Initialize
    set(h,'HWSerialNum', SN);

    h.StartCtrl;

    % Indentify the device
    h.Identify;

    pause(5); % waiting for the GUI to load up;


end
