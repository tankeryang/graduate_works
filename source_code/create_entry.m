function entry = create_entry(T,L)
% k = linspace(0,T,T.*60.*60);
% a0 = 41.68;
% entry = a0.*ones(size(k));
% a = [-16.38, -18.59, 3.572, 7.876, -.5048, -2.97, 0.2518, 0.5785];
% b = [12.53, 0.6307, -13.67, 0.4378, 6.93, 0.4869, -1.554, -0.5871];
% omega = 0.2513;
% for n = 1:8
%     entry = entry + a(n).*cos(n.*k.*omega) + b(n).*sin(n.*k.*omega);
% end
% % k = k.*3600;
% entry = entry./24.*3;
% entry = round(entry);
%% FOR RUSH HOUR SIMULATION %%%
%k = linspace(0,T,T.*60.*24);
%entry = zeros(size(k));
%entry(1:2:length(k)) = L;
%% 
entry = ones(1,3600);
prob = 0.8;
for i = 1:3600
    if prob >= rand
        entry(i) = round(3 + (L-7) * rand);
        % entry(i) = 1;
    else
        if rand > 0.5
            if rand > 0.6
                entry(i) = 0;
            elseif rand < 0.3
                entry(i) = 1;
            else
                entry(i) = 2;
            end
        else
            if rand > 0.6
                entry(i) = 7;
            elseif rand < 0.3
                entry(i) = 8;
            else
                entry(i) = 9;
            end
        end
    end
end
%%
% entry = ones(1,3600);
% for i = 1:3600
%     prob = rand;
%     for j = 0:6
%         if prob >= 3^3/(factorial(3) * 2.7^3)
%             entry(i) = 3;
%             break;
%         end
%         if prob <= 3^j/(factorial(j) * 2.7^j)
%             entry(i) = j;
%             break;
%         end
%     end
% end 
            
