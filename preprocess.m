%
%% 预处理函数
% 功能：
% 1.可以对数据进行剪裁，每次只要符合种群数目的种群，保证种群个数对齐
% 2.可以对输入的矩阵按照从小到大的顺序进行排序，依次再输出Y矩阵和X矩阵

% 输入：
% 1.结果矩阵y,经过了从小到大的排序，并且经过了裁剪处理
% 2.对应结果矩阵的个体矩阵x

% 输出：
% 1.排序后的Y值矩阵
% 2.排序后并且和Y对应的X矩阵


function[Y,X]=preprocess(y,x,pop)

[Y_new,indices]=sort(y);

Y=Y_new;
Y=Y(1:pop);


for i=1:pop
    X_new(i,:)=x(indices(i),:);
end

X=X_new;
end

