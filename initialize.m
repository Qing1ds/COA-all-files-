%
%%



function[x_worest,x_best,lb,ub]=initialize(lb,ub,dim,pop)

 lb=lb.*ones(1,dim);
 ub=ub.*ones(1,dim);% 生成上下界的对应矩阵，防止出界


 for i=1:pop
    x(i,:) = lb + (ub - lb) .* rand( 1, dim );% 随机再界限内取值
    fit(i) = f1( x( i, : ) ) ;% 挨个带入目标测试函数中
 end

 p_y=fit;
 p_x=x;% 分别将函数值和自变量给到存储,一会儿再进行操作，就是针对p_x和p_y

 [fMin,Y_min_index] = min( fit ); % 找到全局最佳以及对应的序号
 x_best = x(Y_min_index,:);% 通过序号找到对应的自变量，也就是对应的个体
 [fMax,Y_max_index] = max( fit);
 x_worest = x(Y_max_index,:);% 分别找到全局最佳，和全局最差
% 第一次代入后，全局最佳是fMin,全局最差是fMax

end

