function plaza = create_plaza(B, L)
global plazalength;
topgap = 1;
bottomgap = 3;
plaza = zeros(plazalength,B+2);
plaza(1:plazalength,[1,2+B]) = -888;
if mod(B-L,2)==0 
    for col = 2:B/2 - L/2 + 1
        for row = 1:(plazalength-1)/2 - topgap * (col-1)
            plaza(row,[col, B+3-col]) = -888;
        end
        for row = (plazalength+3)/2 + bottomgap*(col-1):plazalength
            plaza(row,[col, B+3-col]) = -888;
        end
    end
else
    plaza(1:plazalength, B+3) = -888;
    for col = 2:(B+1)/2 - L/2 + 1
        for row = 1:(plazalength-1)/2 - topgap * (col-1)
            plaza(row, [col, B+4-col]) = -888;
        end
        for row = (plazalength+3)/2 + bottomgap*(col-1):plazalength
            plaza(row, [col, B+4-col]) = -888;
        end
    end
end


%% Alternative method %%
% global plazalength;
% plaza = zeros(plazalength,B+2);
% plaza(1:plazalength,[1,2+B]) = -888;
% 
% %left
% toptheta = 1.36;
% bottomtheta = 1.2;
% for col = 2:ceil(B/2) - L/2 + 1
%     for row = 1:(plazalength-1)/2 - floor(tan(toptheta) * (col-1))
%         plaza(row, col) = -888;
%     end
%     for row = 1:(plazalength-1)/2 - floor(tan(bottomtheta) * (col-1))
%         plaza(plazalength+1-row, col) = -888;
%     end
% end
% 
% %right
% toptheta = atan((ceil(B/2) - L/2)*tan(toptheta)/(floor(B/2)-L/2));
% bottomtheta = atan((ceil(B/2) - L/2)*tan(bottomtheta)/(floor(B/2)-L/2));
% for col = 2:floor(B/2) - L/2 + 1
%     for row = 1:(plazalength-1)/2 - floor(tan(toptheta) * (col-1))
%         plaza(row,B+3-col) = -888;
%     end
%     for row = 1:(plazalength-1)/2 - floor(tan(bottomtheta) * (col-1))
%         plaza(plazalength+1-row,B+3-col) = -888;
%     end
% end
%%