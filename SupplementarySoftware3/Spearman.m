function [G] = Spearman(Data, TFs)
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
            Gij = corr(Temp(:,TFs(i,1)), Temp(:,j),'Type','Spearman');
            G(TFs(i,1),j) = Gij;
        end
    end
end

for i = 1:M
    G(i,i) = 1;
end
        



