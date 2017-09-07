clear all;
C = 0;
for times = 1:20 % 模拟次数 - 自定义
    for j = 0:10
        L = 10;  % 车道数 - 自定义
        B = L+j; % 收费窗口数 - 自定义
        T = 1;   % 模拟步长（hours） - 自定义

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
            plaza = move_forward(plaza);                       % 车辆前进
            plaza = new_cars(plaza, entry_vector(i));          % 生成新车辆
            plaza = switch_lanes(plaza);                       % 车辆变道
            waiting_time = waiting_time + compute_wait(plaza); % 计算平均延误时间
            output = output + compute_output(plaza);           % 计算出口车流量
            %===============================================
            h = show_plaza(plaza,B,h);                     
            drawnow 
            pause(0.01)
            %===============================================
            plaza = clear_boundary(plaza);
        end
        
        C(j+1) = 2.68*(waiting_time/output) + 12.5*B;          % 计算总成本
        % xlabel({strcat('B = ',num2str(B)), ...
        % strcat('mean cost time = ', num2str(W(j+1)))})
        
        close(figure(1));
    end
    % 将模拟结果保存
    % 注意：区分模拟不同收费广场形状结果数据的文件名，如下：
    % 收费窗口在中间时，模拟结果文件名为 L_10_train_10，表示车道数为10，,收费窗口位于中间，第10次模拟结果
    % 收费窗口靠近入口时，模拟结果文件名为 L_10_an_train_10，表示车道数为10，,收费窗口靠近入口，第10次模拟结果
    % 收费窗口靠近出口时，模拟结果文件名为 L_10_ae_train_10，表示车道数为10，,收费窗口靠近出口，第10次模拟结果 
    csvwrite(strcat('L_', num2str(L), '_train_', num2str(times), '.csv'), C);
end

