function new = move_forward(old)
new = old; %create new plaza looking same as old
[L, W] = size(new); %get its dimensions
prob = .7;
delay = 5;
%% DOWNSTREAM OF TOLL BOOTHS %%
for i = (L-1):-1:((L - 1)/2 + 1)
    for j = 1:W
        if new(i,j) == 1
            if new(i+1, j) ~= 0
                new(i,j) = -2;
            elseif prob >= rand
                new(i,j) = 0;
                new(i+1, j) = 1;
            end
        end
    end
end
%% AT TOLL BOOTHS %%
for i = (L-1)/2
    for j = 1:W
        if new(i,j) > 0
            if new(i,j) == delay
                new(i,j) = 0;
                new(i+1,j) = 1;
            else
                new(i,j) = new(i,j) + 1;
            end
        end
    end
end
%% UPSTREAM OF TOLL BOOTHS %%
for i = (L-1)/2:-1:1
    for j = 1:W
        if new(i,j) == 1
            if new(i+1, j) ~= 0
                new(i,j) = -2;
            elseif prob >= rand
                new(i,j) = 0;
                new(i+1, j) = 1;
            end
        end
    end
end