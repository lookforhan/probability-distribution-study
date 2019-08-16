% test the probability distributions by the sample data
clear;close all;clc;tic
% import data
% data = [];Exnet
intensity = 7;
netName = 'Exnet';%Exnet,C-Town,modena,GWSL
filePath = ['C:\Users\dell\Desktop\管网计算数据\',netName,'\'];
dataName = [num2str(intensity),'_calculate_result.mat'];
data = load([filePath,dataName]);
% Q = data.damage_demand;
Q = data.add_damage_demand;
Q0 = data.node_demand;
n = find(Q0>0);
node_num = numel(Q0);
h = ones(node_num,5);% 1 exponential; 2 normal; 3 lognormal; 4 extrem value;5 weibull
p = zeros(node_num,5);
for i = n'
    % 
%     statistical_magnitude = Q0(i)-Q(:,i);
   statistical_magnitude = 1-data.add_SSI;
    [h(i,1),p(i,1)] = adtest(statistical_magnitude,'Distribution','exp');
    [h(i,2),p(i,2)] = adtest(statistical_magnitude,'Distribution','norm');
    [h(i,3),p(i,3)] = adtest(statistical_magnitude,'Distribution','logn');
    [h(i,4),p(i,4)] = adtest(statistical_magnitude,'Distribution','ev');
    [h(i,5),p(i,5)] = adtest(statistical_magnitude,'Distribution','weibull');
    % lillietest ----exponential
%     [h_test(i,1),p_test(i,1)] = lillietest(statistical_magnitude,'Distribution','exponential');

end
% save([filePath,[num2str(intensity),'_',netName,'_Q0-Q_node',]],'h','p')
% plot the data
% [h,stats] = cdfplot(data);
% y = normcdf(x,stats.iean,stats.std);
% h2 = plot (x,y);

% normplot(data); 正态概率图

% probplot('lognormal',data); 绘制对数正态概率图（p-p图）
% qqplot(data,pd); pd 缺省时为标准正态分布。

