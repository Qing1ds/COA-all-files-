%
%% 矩阵整合函数
% 功能：
% 1.可以将化合反应，分解反应，单取代反应，双取代反应处理之后得到的矩阵整合，形成一个新矩阵
% 2.将整合后的矩阵代入目标函数中去，求出新的函数值YY
% 3.裁剪YY矩阵，使得长度符合pop种群数目
% 4.同时找到对应YY的数值XX_nw,这个已经是按照对应YY排列好的

% 输入：
% 1.化合反应输出的矩阵x1
% 2.分解反应输出的矩阵x2
% 3.种群的数目pop
% 4.目标测试函数f1

% 输出：
% 1.与YY矩阵相对应的矩阵XX_new
% 2.代入测试函数之后，并且经过了排序，得到的结果YY
% 3.本次循环的个体最佳函数值YY_best
% 4.本次循环的个体最佳函数值对应的种群XX_best


function[XX_new,YY,YY_best,XX_best,fMin]=integrated(x1,x2,x3,x4,pop,f1,fMin)

XX=[x1;x2;x3;x4];

[aa,bb]=size(XX);% 求取XX矩阵的尺寸

for i=1:aa
    YY(i)=f1(XX(i,:));
end

[YY_new,YY_index]=sort(YY);

YY=YY_new(1:pop); % 裁剪输出
YY_best=YY(1);

if YY_best<fMin
    fMin=YY_best;%fMin 是全局最小
end

for j=1:pop
    XX_new(j,:)=XX(YY_index(j),:);
end

XX_best=XX_new(1,:);

end

