intensity = 9;
netName = 'GWSL';%Exnet,C-Town,modena,GWSL
filePath = ['C:\Users\dell\Desktop\������������\',netName,'\'];
dataName = [num2str(intensity),'_calculate_result.mat'];
data = load([filePath,dataName]);
x = data.SSI;
pd = fitgmdist(x,2);
p = histogram(x);
output = kstest_for_all_distribution(x,pd);