function Plot_Main(data_cells_forward, data_cells_backward, VA_list, numofsteps)
    EDM_gap = 10e-3; %in mm

    for list = 0:1      
        if list == 1
            data_cells = data_cells_backward;
        else
            data_cells = data_cells_forward;
        end

        
        
        figure;

        for i = 1:numofsteps+1
            for j = 1:length(VA_list)
                if list == 1
                    Title = 'Backward';
                    initial_gap = data_cells{numofsteps+1-1+1,1}.pos - EDM_gap; %in mm
                    data_V_measured(i,j) = data_cells{numofsteps+1-i+1,j}.V_measured;
                    data_C_measured(i,j) = data_cells{numofsteps+1-i+1,j}.C_measured;
                    data_pos(i,j) = data_cells{numofsteps+1-i+1,j}.pos - initial_gap;
                    data_pos_backward(i,j) = data_cells{numofsteps+1-i+1,j}.pos - initial_gap;
                    data_C_measured_backward(i,j) = data_cells{numofsteps+1-i+1,j}.C_measured;
                else
                    Title = 'Forward';
                    initial_gap = data_cells{1,1}.pos - EDM_gap; %in mm
                    data_V_measured(i,j) = data_cells{i,j}.V_measured;
                    data_C_measured(i,j) = data_cells{i,j}.C_measured;
                    data_pos(i,j) = data_cells{i,j}.pos - initial_gap;
                    data_pos_forward(i,j) = data_cells{i,j}.pos - initial_gap;
                    data_C_measured_forward(i,j) = data_cells{i,j}.C_measured;
                end
            end
            pos{i} = [num2str(round(data_pos(i,j)*1000)) ' um'];
            semilogy(data_V_measured(i,:), data_C_measured(i,:), 'linewidth', 2);
            hold on;

        end

        xlabel('Bias voltage (V)');
        ylabel('Output current (A)');
        title(Title);
        set(gca,'fontweight','bold', 'fontsize', 14);
        legend(pos);
        grid on;
        hold off;



        figure;

        start_index = 1;
        end_index = 10;
        for i = start_index:end_index
            pos_index{i-start_index+1} = [num2str(round(data_pos(i,j)*1000)) ' um'];
            semilogy(data_V_measured(i,:), data_C_measured(i,:), 'linewidth', 2);
            hold on;
        end

        xlabel('Bias voltage (V)');
        ylabel('Output current (A)');
        title(Title);
        set(gca,'fontweight','bold', 'fontsize', 14);
        legend(pos_index);
        grid on;
        hold off;



        figure; 

        start_index = 26;
        end_index = 31;
        %for i = 1:length(VA_list)
        for i = start_index:end_index
            VA{i-start_index+1} = [num2str(VA_list(i)) ' V'];
            plot(data_pos(:,i)*1000, data_C_measured(:,i), '-o', 'linewidth', 2);
            hold on;
        end

        xlabel('Gap (um)');
        ylabel('Output current (A)');
        title(Title);
        set(gca,'fontweight','bold', 'fontsize', 14);
        legend(VA);
        grid on;
        hold off;


        figure;

        start_index = 26;
        end_index = 31;
        %for i = 1:length(VA_list)
        for i = start_index:end_index
            VA{i-start_index+1} = [num2str(VA_list(i)) ' V'];
            plot(VA_list(i)./(data_pos(:,i)*1e-3), data_C_measured(:,i), '-o', 'linewidth', 2);
            hold on;
        end

        xlabel('Electric field (V/m)');
        ylabel('Output current (A)');
        title(Title);
        set(gca,'fontweight','bold', 'fontsize', 14);
        legend(VA);
        grid on;
        hold off;
        
    end
   
    
    
    figure; 

    start_index = 26;
    end_index = 31;
    %for i = 1:length(VA_list)
    for i = start_index:end_index
        VA{i-start_index+1} = [num2str(VA_list(i)) ' V'];
        plot(data_pos(:,i)*1000, data_C_measured_forward(:,i) - data_C_measured_backward(:,i), '-o', 'linewidth', 2);
        hold on;
    end

    xlabel('Gap (um)');
    ylabel('Output current (A)');
    title('Current error difference');
    set(gca,'fontweight','bold', 'fontsize', 14);
    legend(VA);
    grid on;
    hold off;
    
end















