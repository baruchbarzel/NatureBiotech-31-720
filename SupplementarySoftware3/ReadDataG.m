function [G] = ReadDataG(FileName)
clear G;

File = fopen(FileName);

i = 1;
List(334 * 4511, 3) = 0;
while ~eof(File)
    Line = fgetl(File);
    L = size(Line,1);
    for c = L:-1:1
        if strcmp(Line(c), 'G')
            Line(c) = [];
        end
    end
    List(i,:) = str2num(Line);
    i = i + 1;
end
L = size(List,1);

G(4511,4511) = 0;
for i = 1:L
    G(List(i,1), List(i,2)) = List(i,3);
end

