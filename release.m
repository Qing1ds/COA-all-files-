%
%% 分解反应函数
% 功能：
% 1.具备扩充种群的能力，扩充后的种群数目是：pop*（1-com_percent）*2
% 2.可以分成去往两个方向的种群，一个是靠近Xbest，一个是靠近Xworse身体，
%   这样一个可以局部寻优，一个可以全局探索
%   靠近Xbest：X_new4(i,:) = x_best+(abs(X(i,:)-x_best))*(A'*(A*A')^(-1))*ones(1,dim);
%   靠近Xworsest：X_new3(i,:) = rand(1)*exp((x_worsest-X(i,:))/(i)^2);

% 输入：
% 1.上界ub
% 2.下界lb
% 3.经过排序之后的种群X
% 4.测试函数维度信息dim
% 5.种群的数目pop
% 6.最差个体x_worsest
% 7.最佳个体x_best
% 8.化合比例c_percent

% 输出：经过了位移和扩充变换的种群X_new_dec


function [X_new_dec]=release(lb,ub,X,dim,pop,x_worsest,x_best,c_percent)

a=pop*c_percent;

for i= (a+1):pop
    A=floor(rand(1,dim)*2)*2-1;
    X_new3((i-a),:) = randn(1)*exp( ( x_worsest -X(i,:) ) / (i)^2 );
    X_new4((i-a),:) = x_best+( abs (   X(i,:) - x_best  )  ) * (A'*(A*A')^(-1))*ones(1,dim);
    for k=1:dim
        if X_new3((i-a),k)>ub(k)
            X_new3((i-a),k)=ub(k);
        end
        if X_new3((i-a),k)<lb(k)
            X_new3((i-a),k)=lb(k);
        end
        if X_new4((i-a),k)>ub(k)
            X_new4((i-a),k)=ub(k);
        end
        if X_new4((i-a),k)<lb(k)
            X_new4((i-a),k)=lb(k);
        end
    end
end
X_new_dec=[X_new3;X_new4];
end

