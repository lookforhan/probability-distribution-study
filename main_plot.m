% test the probability distributions by the sample data
clear;close all;clc;tic
% import data
% data = [];Exnet
intensity = 9;
netName = 'GWSL';%Exnet,C-Town,modena,GWSL
filePath = ['C:\Users\dell\Desktop\管网计算数据\',netName,'\'];
dataName = [num2str(intensity),'_calculate_result.mat'];
data = load([filePath,dataName]);
Q = data.damage_demand;
% Q = data.add_damage_demand;
Q0 = data.node_demand;
n = find(Q0>0);
for i = n'
    % 
    statistical_magnitude = 1-Q(:,i)/Q0(i);
    %
    f1 = figure; % frequency and theoretical exponential distribution plot 
    f1.Visible = 0;
    f1_sub_1 = subplot(2,2,1);
    h = histogram(statistical_magnitude);% frequency plot
    try
    pd = fitdist(statistical_magnitude, 'Exponential');
    catch
        keyboard
        continue
    end
    x_value = 0:0.001:1;
    y_value = pdf(pd,x_value);
    y_plot = y_value/max(y_value)*max(h.Values);
    hold on 
    h2 = plot(x_value,y_plot);
    l = legend('frequency','theoretical exponential distribution');
    
    hold off
    % empirical cdf
    f1_sub_2 = subplot(2,2,2);
    [sub2,stats] = cdfplot(statistical_magnitude);
    hold on
    y_cdf = expcdf(x_value,pd.mu);
    plot(x_value,y_cdf);
    hold off
    % probability plot 
    f1_sub_3 = subplot(2,2,3);
%     f2 = figure;
    sub3 = probplot('exponential',statistical_magnitude);
    f1_sub_4 = subplot(2,2,4);
    sub4 = qqplot(statistical_magnitude,pd);
    saveas(f1,[filePath,[num2str(intensity),'_',netName,'_Q-Q0_node',num2str(i)],'.jpg']);
    f1.delete
    % lillietest
%     [h_test(i,1),p_test(i,1)] = lillietest(statistical_magnitude,'Distribution','exponential');
end

% plot the data
% [h,stats] = cdfplot(data);
% y = normcdf(x,stats.iean,stats.std);
% h2 = plot (x,y);

% normplot(data); 正态概率图

% probplot('lognormal',data); 绘制对数正态概率图（p-p图）
% qqplot(data,pd); pd 缺省时为标准正态分布。

