function [ROCcurve] = ROC(G, S, Network, TranscriptionFactors, res)
clear ROCcurve;

[N cols] = size(Network);
[T cols] = size(TranscriptionFactors);
GLinks(N*T - T,4) = 0;
SLinks(N*T - T,4) = 0;
c = 1;
for i = 1:T
    for j = 1:N
        TF = TranscriptionFactors(i,1);
        if j ~= TF
            GLinks(c,:) = [TF, j, G(TF,j), Network(TF,j)];
            SLinks(c,:) = [TF, j, S(TF,j), Network(TF,j)];
            c = c + 1;
        end
    end
end
GLinks = sortrows(GLinks,-3);
SLinks = sortrows(SLinks,-3);

[K cols] = size(GLinks);
S = round(K/res) + 1;
GTPR(S,1) = 0;
GFPR(S,1) = 0;
STPR(S,1) = 0;
SFPR(S,1) = 0;
P = sum(GLinks(:,4));

for s = 1:S
    k = s*res;
    if k <= K
        GTPR(s,1) = sum(GLinks(1:k,4)) / P;
        GFPR(s,1) = (k - sum(GLinks(1:k,4))) / (K - P);
        STPR(s,1) = sum(SLinks(1:k,4)) / P;
        SFPR(s,1) = (k - sum(SLinks(1:k,4))) / (K - P);
    end
end

ROCcurve = [GFPR GTPR SFPR STPR];
