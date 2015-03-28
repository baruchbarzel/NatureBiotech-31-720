function [Gspearman Sspearman ROCspearman] = ProduceFig3b()
clear Gspearman Sspearman ROCspearman;

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
%c = 1;
% for i = 1:N
%     if sum(Network(i,:))
%         TranscriptionFactors(c,1) = i;
%         c = c + 1;
%     end
% end

% Alternatively: you could downdload all 334 TFs from the Input Data (only
% 141 of which actually appear in Network. Just delete the following '%'
TranscriptionFactors = load('Data/InputData/net3_transcription_factors.tsv');

display('-->'); display('--> Obtained Data: Expression matrix; List of Transcription Factors; Gold Stadard'); display('-->'); 

[Gspearman] = Spearman(Experiments, TranscriptionFactors);

display('-->'); display('--> Constructed Gspearman'); display('-->'); 

[Sspearman] = SMatrix(Gspearman);

display('-->'); display('--> Constructed Sspearman'); display('-->'); 
display('-->'); display('--> Producing ROC curves...'); display('-->'); 

% ROC curve columns are [FPR from G; TPR from G; FPR from S; TPR from S]
[ROCspearman] = ROC(abs(Gspearman), Sspearman, Network, TranscriptionFactors, 25);

subplot(1,3,2)
plot(ROCspearman(:,1),ROCspearman(:,2), 'LineWidth', 3, 'color', [1 0 0]);
hold on;
plot(ROCspearman(:,3),ROCspearman(:,4), 'LineWidth', 3, 'color', [0 0 1]);
drawnow; 

