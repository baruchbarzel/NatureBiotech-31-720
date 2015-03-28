function [G] = MutualInformation(Data, TFs)
clear G;

[N M] = size(Data);
[S cols] = size(TFs)
Temp = Data;
G(M,M) = 0;

% In the paper we de-log the data by exponentiating it. 
% By skiping the next 6 lines you can use the data as is (results are not
% harmed by this)
%Av = mean(Data);
%for i = 1:N
%    for j = 1:M
%        Temp(i,j) = exp(Data(i,j) - Av(j));
%    end
%end

for i = 1:S
    if ~mod(i,10)
        i
    end
    for j = 1:M
        if TFs(i,1) ~= j
            G(TFs(i,1),j) = kernelmi(transpose(Temp(:,TFs(i,1))), transpose(Temp(:,j)));
        end
    end
end

for i = 1:M
    G(i,i) = 1;
end


