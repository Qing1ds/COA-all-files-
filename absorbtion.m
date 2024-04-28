%
%% 化合反应函数
% 功能：
% 1.可以扩充种群，按照设置的种群数量乘以化合程度来计算，最后的种群数目是pop*com_percent*2
% 2.两种程度的操作,一种是小步骤操作，一种是大一点的移动操作
%   x( sortIndex( i ), : ) = pX( sortIndex( i ), : )*exp(-(i)/(r1*M));    小
%   x( sortIndex( i ), : ) = pX( sortIndex( i ), : )+randn(1)*ones(1,dim);  大
%   操作结束之后，结合成一个矩阵

% 输入：
% 1.上界ub
% 2.下界lb
% 3.经过排序之后的种群X
% 4.迭代次数M
% 5.现在正在进行的迭代次数iter
% 6.维度信息dim
% 7.化合程度c_percent
% 8.种群数目pop

% 输出：
% 1.经过了位移变换和扩充的矩阵X_new_com
% 


function [X_new_com]=absorbtion(lb,ub,X,M,dim,c_percent,pop)

a=pop*c_percent;

for i=1:a
    r1=rand(1);
    X_new1(i,:) = X(i,:)*exp(-(i)/(r1*M));
    X_new2(i,:) = X(i,:)+randn(1)*ones(1,dim);
    for k=1:dim
        if X_new1(i,k)>ub(k)
            X_new1(i,k)=ub(k);
        end
        if X_new1(i,k)<lb(k)
            X_new1(i,k)=lb(k);
        end
        if X_new2(i,k)>ub(k)
            X_new2(i,k)=ub(k);
        end
        if X_new2(i,k)<lb(k)
            X_new2(i,k)=lb(k);
        end
    end
end
X_new_com=[X_new1;X_new2];
end

