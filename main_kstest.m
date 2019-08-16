% test the probability distributions by the sample data
clear;close all;clc;tic
% import data
% data = [];Exnet
intensity = 8;
netName = 'Exnet';%Exnet,C-Town,modena,GWSL
filePath = ['C:\Users\dell\Desktop\管网计算数据\',netName,'\'];
dataName = [num2str(intensity),'_calculate_result.mat'];
data = load([filePath,dataName]);
Q = data.damage_pressure;
% Q = data.add_damage_demand;
Q0 = data.node_pressure;
n = find(Q0>0);
node_num = numel(Q0);
h = ones(node_num,5);% 1 exponential; 2 normal; 3 lognormal; 4 extrem value;5 weibull
p = zeros(node_num,5);
for i = n'
    %
%     statistical{i} =  sum(Q,2);
statistical{i} = Q(:,i);
%     statistical_magnitude = statistical{i};
statistical_magnitude = mean(data.add_damage_pressure,2);
% statistical_magnitude = data.add_SSI;
%     statistical_magnitude = Q(:,i);
    norm_cdf = fitdist(statistical_magnitude,'Normal');
    
    lgnorm_cdf = fitdist(statistical_magnitude,'Lognormal');
     
    exp_cdf = fitdist(statistical_magnitude,'Exponential');
    ev_cdf = fitdist(statistical_magnitude,'ExtremeValue');
    weibull_cdf = fitdist(statistical_magnitude,'Weibull');
    [h(i,1),p(i,1)] = kstest(statistical_magnitude,'CDF',exp_cdf);
    [h(i,2),p(i,2)] = kstest(statistical_magnitude,'CDF',norm_cdf);
    [h(i,3),p(i,3)] = kstest(statistical_magnitude,'CDF',lgnorm_cdf);
    [h(i,4),p(i,4)] = kstest(statistical_magnitude,'CDF',ev_cdf);
    [h(i,5),p(i,5)] = kstest(statistical_magnitude,'CDF',weibull_cdf);
    
end
% find(h==0)
numel(find(h==0))
% save([filePath,[num2str(intensity),'kstest_',netName,'_Q0-Q_node',]],'h','p')
% plot the data
% [h,stats] = cdfplot(data);
% y = normcdf(x,stats.iean,stats.std);
% h2 = plot (x,y);

% normplot(data); 正态概率图

% probplot('lognormal',data); 绘制对数正态概率图（p-p图）
% qqplot(data,pd); pd 缺省时为标准正态分布。

