% 
%% 化学反应算法函数
% 功能：
% 1.经过各种的操作，化合操作，分解操作，单取代操作，双取代操作，对种群进行处理
% 2.其中含有局部搜索和全局搜索



function [curve_fMin,fMin,Best_pos,Best_score,YY_plot,XX_plot,curve,curve_XX_one,curve_XX_group]=COA(M,pop,lb,ub,dim,f1)

 c_percent=0.5;% 化合操作所占比例
 t=0;% 全局停止函数的计数器
 overall_stop_num=5;% 全局停止函数次数上限

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

YY_overall_stop=0;

[Y,X]=preprocess(p_y,p_x,pop);

YY_plot=Y;
XX_plot=X;
curve_XX_group=X;

iter=0;
while(iter<M)
    
    [X_new_com]=absorbtion(lb,ub,X,M,dim,c_percent,pop);
    [X_new_dec]=release(lb,ub,X,dim,pop,x_worest,x_best,c_percent);
    [X_new_rep]=gain_and_lose_electrons(lb,ub,X,dim,pop,x_worest,x_best,c_percent,Y);
    [X_new_rep_double]=interionic_binding(lb,ub,X,dim,pop,x_worest,x_best,c_percent,Y);
    
    [XX_new,YY,YY_best,XX_best,fMin]=integrated(X_new_com,X_new_dec,X_new_rep,X_new_rep_double,pop,f1,fMin);
    % XX_new是更新之后的种群，而且也排序好了
    % YY是更新之后的适应度函数值，也是排序好的
    % YY_best是本次最佳，一会儿会存储在curve中
    % XX_best是本次最佳对应的个体位置信息，一会儿存储在curve_XX_one中
    % fMin是全局最佳，这里面只有一个数字
    
    X=XX_new;
    Y=YY;
    x_worest=XX_new(end,:);
    x_best=XX_new(1,:);



    YY_plot=[YY_plot;YY];% 用于绘制图1，三维图像，作为Z轴，是y的数值，可能是30个数值
    XX_plot=[XX_plot;XX_new];% 用于绘制图1，三维图像，作为Y轴，是x的数值，可能是30个组合

%% 第一个尝试 全局停止函数
     [iter,YY_overall_stop,t]=chemical_equilibrium_constant_K(iter,fMin,YY_overall_stop,M,t,overall_stop_num); % 全局停止函数
%%
    iter=iter+1;

    curve_fMin(iter)=fMin;

    curve(iter)=YY_best;% 用于绘制图2，二维图像，作为Y轴，是全局最佳的数值，每次是一个数值。横轴是迭代次数

    curve_XX_one(iter,:) = XX_best;% 用于绘制图3，二维图像，作为Y轴，是全局最佳对应的X的最佳点或是组合。横轴是迭代次数

    curve_XX_group = [curve_XX_group;XX_best];% 用于绘制图4，二维图像，作为Y轴，是每一次迭代的所有的种群X个体或是组合。横轴是迭代次数

end

Best_pos = XX_best;% 用于显示最佳的个体组合
Best_score = curve(end);% 用于显示全局最佳点


 end


