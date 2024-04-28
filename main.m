clear
clc
close all% 清屏

M=1000;% 迭代次数
pop=30;% 种群数目
Function_name='F11';% 目标函数
[lb,ub,dim,f1] = Functions_details(Function_name);%测试函数信息


% 输入：1.迭代次数M
%       2.种群数目pop
%       3.区域上界lb
%       4.区域下界ub
%       5.函数维度信息dim
%       6.目标测试函数f1

% 输出：1.全局最佳fMin（只有一个数字）
%       2.最佳个体，最佳个体组合bestX（可能是一个数字，也可能是一组数字，取决于维度）
%       3.全局最佳信息矩阵（是一整个数组）

[curve_fMin,fMin,Best_pos,Best_score,YY_plot,XX_plot,curve,curve_XX_one,curve_XX_group]=COA(M,pop,lb,ub,dim,f1);% 代入COA开始优化

display(['最佳的个体种群是：',num2str(Best_pos)]);
display(['全局最佳的结果是：',num2str(Best_score)]);

variableName = 'curve_fMin';
% matrix = rand(1,1000);
% data = matrix(curve_fMin);
filename = 'output.XLSX';
% sheet = 'Sheet1';
% writematrix(curve_fMin,filename,'Sheet',sheet);
writematrix(variableName,filename);

figure('Position',[500 100 1000 500])
%Draw search space
subplot(1,2,1);
func_plot(Function_name);
title('目标测试函数')
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])

subplot(1,2,2);
plot(curve,'Color','r','linewidth',1.7)
title('每一次循环的全局最佳值')
xlabel('迭代次数');
ylabel('每一次循环的全局最佳');
axis tight
grid on
box on
legend('单次循环的全局最佳')

figure('Position',[500 100 1000 500])
%Draw objective space
subplot(1,2,1);
plot(curve_fMin,'Color','r','linewidth',1.7)
title('全局最佳')
xlabel('迭代次数');
ylabel('全局最佳');
axis tight
grid on
box on
legend('所有循环的全局最佳')

subplot(1,2,2);
plot(curve_XX_one,'Color','r','linewidth',1.7)
title('每一次的最佳种群')
xlabel('迭代次数');
ylabel('每一次的全局最佳对应的X');
legend('单次循环的最佳值对应的种群个体或组合')

axis tight
grid on
box on


% figure('Position',[500 100 1000 500])
% % surfc(XX_plot,YY_plot,'LineStyle','none');
% ff=1:M;
% plot3(ff,XX_plot,YY_plot)
% axis tight
% grid on
% box on









