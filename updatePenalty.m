function [alpha,gamma,belta]=updatePenalty(flagTw,flagDu,flagCa,alpha,gamma,belta,delta1,delta2)
% alpha=penalty(1);
% gamma=penalty(2);
% belta=penalty(3);
if flagTw
    alpha=alpha*(1+delta1);
    alpha=min(1000,alpha);
else
    alpha=alpha/(1+delta2);
    alpha=max(0.01,alpha);
end

if flagDu
    gamma=gamma*(1+delta1);
    gamma=min(1000,gamma);
else
    gamma=gamma/(1+delta2);
    gamma=max(0.01,gamma);
end

if flagCa
    belta=belta*(1+delta1);
    belta=min(1000,belta);
else
    belta=belta/(1+delta2);
    belta=max(0.01,belta);
end
% penalty=[alpha,gamma,belta];
end