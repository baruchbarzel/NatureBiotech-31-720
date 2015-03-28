function SilenceAll()

Networks = [1,3,4];
Organisms{1} = 'In Silico';
Organisms{2} = 'S. cerevisiae';
Organisms{3} = 'E. coli';

Methods = directory_list('INPUT/Predictions');
N = size(Methods,2);
n = 100000;

disp('Methods for Silencing:')
disp(Methods)
disp(char(10))

for i = 1:N
    mkdir(['PREDICTIONS/' Methods{i} '_G']);
    mkdir(['PREDICTIONS/' Methods{i} '_S']);
    for j = 1:3
        disp([char(10) 'Silencing G from Method ' num2str(i) ' (out of ' num2str(N) '): ' Methods{i} '; Organism: ' Organisms{j} char(10)])
   
        Input = ['INPUT/Predictions/' Methods{i} '/G' num2str(Networks(j)) '.txt'];
        [G] = ReadG(Input, Networks(j));
        disp(['Read G from file' char(10)])
        
        [S] = SILENCING(G);
        disp(['Silenced G.' char(10) 'Writing G and S to file...'])
        
        Output = ['PREDICTIONS/' Methods{i} '_S/Prediction' num2str(Networks(j)) '.txt'];
        WriteG(Output, S, n);
        Output = ['PREDICTIONS/' Methods{i} '_G/Prediction' num2str(Networks(j)) '.txt'];
        WriteG(Output, G, n);
        disp('Done');
    end
end