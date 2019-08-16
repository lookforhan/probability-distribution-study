% ks test by han zhao
% 按照ks检验原理编写程序，可以检验任意函数。
% x = data.add_SSI;
% pd = fitgmdist(x,2);

function output = kstest_for_all_distribution(x,pd)
% end
% x = data.add_SSI;
x1 = sort(x);
x2 = unique(x);
num1 = numel(x1);
num2 = numel(x2);
Sn = zeros(num2,1);
% x_min = x1(1);
% x_max = x1(end);
for i = 2:num2-1
    k = find(x2(i)<x1,1);
    Sn(i) = (k-1)/num1;
end
Sn(end)=1;
% figure
% f = stairs(x2,Sn);
% hold on
% 理论值
% pd = fitgmdist(x,2);
Fn = pd.cdf(x2);
D =max(abs(Fn-Sn));
output = D;
% f2 = stairs(x2,Fn);
end