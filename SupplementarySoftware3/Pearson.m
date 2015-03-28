function [G] = Pearson(Data, TFs)
clear G;

[N M] = size(Data);
[S cols] = size(TFs);
Temp = Data;
G(M,M) = 0;

% In the paper we de-log the data by exponentiating it. 
% By skiping the next 6 lines you can use the data as is (results are not
% harmed by this)
Av = mean(Data);
for i = 1:N
    for j = 1:M
        Temp(i,j) = exp(Data(i,j) - Av(j));
    end
end

for i = 1:S
    for j = 1:M
        if TFs(i,1) ~= j
            C = corrcoef(Temp(:,TFs(i,1)), Temp(:,j));
            G(TFs(i,1),j) = C(1,2);
        end
    end
end

for i = 1:M
    G(i,i) = 1;
end


