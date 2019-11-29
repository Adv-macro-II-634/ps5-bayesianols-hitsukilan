function f=logLikelihood(Y,X,beta,sd)

% f:log likelihood of normal
% Y: dependent variable from data
% X: independent varable from data
% beta: beta coefficent vector
% sd: estimated sd of residuals

Y_hat=X * beta;
res_l=Y-Y_hat;
sqte=sqrt(sd);
params=[0;sqte];
f=normlike(params,res_l);

end 