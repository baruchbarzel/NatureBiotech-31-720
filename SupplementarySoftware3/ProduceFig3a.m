function [Gpearson Spearson ROCpearson] = ProduceFig3a()
clear Gpearson Spearson ROCpearson;

Experiments = load('Data/InputData/net3_expression_data.tsv');
GoldStandard = load('Data/GoldStandard/DREAM5_NetworkInference_GoldStandard_Network3.tsv');
[L cols] = size(GoldStandard);
[rows N] = size(Experiments);
GoldStandard = sortrows(GoldStandard, -3);
Network(N,N) = 0;
i = 1;
while GoldStandard(i,3)
    Network(GoldStandard(i,1), GoldStandard(i,2)) = GoldStandard(i,3);
    i = i + 1;
end

% In the paper we obtain the TFs from the network (141 TFs)
c = 1;
for i = 1:N
    if sum(Network(i,:))
        TranscriptionFactors(c,1) = i;
        c = c + 1;
    end
end

% Alternatively: you could downdload all 334 TFs from the Input Data (only
% 141 of which actually appear in Network. Just delete the following '%'
%TranscriptionFactors = load('Data/InputData/net3_transcription_factors.tsv');

display('-->'); display('--> Obtained Data: Expression matrix; List of Transcription Factors; Gold Stadard'); display('-->'); 

[Gpearson] = Pearson(Experiments, TranscriptionFactors);

display('-->'); display('--> Constructed Gpearson'); display('-->'); 

[Spearson] = SMatrix(Gpearson);

display('-->'); display('--> Constructed Spearson'); display('-->'); 
display('-->'); display('--> Producing ROC curves...'); display('-->'); 

% ROC curve columns are: [FPR from G; TPR from G; FPR from S; TPR from S]
[ROCpearson] = ROC(abs(Gpearson), Spearson, Network, TranscriptionFactors, 25);

subplot(1,3,1)
plot(ROCpearson(:,1),ROCpearson(:,2), 'LineWidth', 3, 'color', [1 0 0]);
hold on;
plot(ROCpearson(:,3),ROCpearson(:,4), 'LineWidth', 3, 'color', [0 0 1]);
drawnow; 

