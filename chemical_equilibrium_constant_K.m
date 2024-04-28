% 
%% 全局停止函数
% 


function[iter,YY_overall_stop,t]=chemical_equilibrium_constant_K(iter,fMin,YY_overall_stop,M,t,overall_stop_num)


if fMin == YY_overall_stop  % YY_overall_stop,上一次的全局最小值
    t=t+1;
    if t==overall_stop_num
        iter=M-5;
    end
else
    YY_overall_stop=fMin;
    t=0;
end



end