%
%% 单取代函数
% 功能：
% 1.可以进行种群扩充，扩大到二倍
% 2.也可以进行种群的位移更新
% X_new_rep1(j,:) = x_best + (  randn(1,dim)  ).*(  abs ( X(b(j),:)-x_best )  ) ;
% X_new_rep2(j,:) = X(b(j),:)+(2*rand(1)-1)*(abs(X(b(j),:)- x_worsest ) )/ (Y(b(j)) - Y(end)+1e-50 );
% 操作结束之后，将输出一个矩阵

% 输入：
% 1.上界ub
% 2.下界lb
% 3.经过排序之后的种群X
% 4.维度信息dim
% 5.种群的个数pop
% 6.每一次的个体最差（依据函数值来判断）x_worsest
% 7.每一次的个体最差（依据函数值来判断）x_best
% 8.化合程度c_percent
% 9.经过排序之后的函数值Y

% 输出：
% 1.经过处理之后，位移变换和排序之后的种群X_new_rep



function [X_new_rep]=gain_and_lose_electrons(lb,ub,X,dim,pop,x_worsest,x_best,c_percent,Y)

c=randperm(pop);

b=c(  1:round(pop*c_percent)  );

for j = 1 : (length(b))
    X_new_rep1(j,:) = x_best + (  randn(1,dim)  ).*(  abs ( X(b(j),:)-x_best )  ) ;

    X_new_rep2(j,:) = X(b(j),:)+(2*rand(1)-1)*(abs(X(b(j),:)- x_worsest ) )/ (Y(b(j)) - Y(end)+1e-50 );

     for k=1:dim
        if X_new_rep1(j,k)>ub(k)
            X_new_rep1(j,k)=ub(k);
        end
        if X_new_rep1(j,k)<lb(k)
            X_new_rep1(j,k)=lb(k);
        end
        if X_new_rep2(j,k)>ub(k)
            X_new_rep2(j,k)=ub(k);
        end
        if X_new_rep2(j,k)<lb(k)
            X_new_rep2(j,k)=lb(k);
        end
    end

end
X_new_rep=[X_new_rep1;X_new_rep2];

end


