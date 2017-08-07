clear all;
C = 0;
for times = 6:10
    for j = 6:10
        L = 10; %number lanes in highway before and after plaza
        B = L+j; %number booths
        T = 1; % # hrs to simulate

        global plazalength;
        plazalength = 101;
        plaza = create_plaza(B,L);

        %====================================================
        h = show_plaza(plaza,B,NaN);                        %    
        %====================================================

        entry_vector = create_entry(T,L);
        waiting_time = 0;
        output = 0;

        for i = 1:T*1800
            plaza = move_forward(plaza); %move cars forward
            plaza = new_cars(plaza, entry_vector(i)); %allow new cars to enter
            plaza = switch_lanes(plaza); %allow lane changes
            waiting_time = waiting_time + compute_wait(plaza); %compute waiting time during timestep i
            output = output + compute_output(plaza);
            %===============================================
            h = show_plaza(plaza,B,h);                     %
            drawnow 
            pause(0.01)
            %===============================================
            plaza = clear_boundary(plaza);
        end

        %show_plaza(plaza,B,h); 
        C(j+1) = 2.68*(waiting_time/output) + 12.5*B;
        % xlabel({strcat('B = ',num2str(B)), ...
        % strcat('mean cost time = ', num2str(W(j+1)))})
        
        close(figure(1));
    end
    csvwrite(strcat('L_10_ae_train_', num2str(times), '.csv'), C);
end

