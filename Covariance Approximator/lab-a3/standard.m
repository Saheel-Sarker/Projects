function [DataStd] = standard(Data)
    mean_x = mean(Data(:,1));
    mean_y = mean(Data(:,2));
    DataStd = [Data(:,1) - mean_x, Data(:,2) - mean_y];
end