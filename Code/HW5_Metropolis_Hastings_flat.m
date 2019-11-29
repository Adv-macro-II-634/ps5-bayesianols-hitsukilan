
% Metropolis-Hastings algorithm with flat prior
clear

load(fullfile(tempdir,'OLS_results'));
iter=3000;
r=0.12;

% Metropolis-Hastings algorithm 
theta = [beta_hat_ini',sigma_hat_ini];
Sigma = [var_beta_hat_ini;sigma_var_ini];
Sigma = diag(Sigma);                   
Sigma_adj = Sigma * r;
mu = zeros(1,length(theta));

% Initial Postier
Theta = zeros(iter,length(theta));
Theta(1,:)=theta;
Prop = Theta;
accp=zeros(iter,1);

% w/ Flat prior
for ii=1:(iter-1)
 Prop(ii+1,:)=Theta(ii,:)+mvnrnd(mu,Sigma_adj);
 
 while Prop(ii+1,length(theta))<=0
     Prop(ii+1,:)=Theta(ii,:)+mvnrnd(mu,Sigma_adj);
 end
 
 ratio=exp(logLikelihood(Y,X_wI,Theta(ii,1:6)',Theta(ii,7))...
     -logLikelihood(Y,X_wI,Prop(ii+1,1:6)',Prop(ii+1,7)));
     
 u=rand; % draw random numb to see wether keep the value or not
 
 if u < ratio 
     accp(ii+1)=1;
     Theta(ii+1,:)=Prop(ii+1,:);
 else
     accp(ii+1)=0; 
     Theta(ii+1,:)=Theta(ii,:);
 end
 
end

f_r_accp = sum(accp)/iter; 


% Graphs

figure(1)
subplot(2,4,1)
histfit(Theta(:,1),100,'kernel')
hold on
line([theta(1) theta(1)],ylim,'Color','r','LineWidth',1)
title('\beta_0')
hold off

subplot(2,4,2)
histfit(Theta(:,2),100,'kernel')
hold on
line([theta(2) theta(2)],ylim,'Color','r','LineWidth',1)
title('\beta_{educ}')
hold off

subplot(2,4,3)
histfit(Theta(:,3),100,'kernel')
hold on
line([theta(3) theta(3)],ylim,'Color','r','LineWidth',1)
title('\beta_{exp}')
hold off

subplot(2,4,4)
histfit(Theta(:,4),100,'kernel')
hold on
line([theta(4) theta(4)],ylim,'Color','r','LineWidth',1)
title('\beta_{SMSA}')
hold off

subplot(2,4,5)
histfit(Theta(:,5),100,'kernel')
hold on
line([theta(5) theta(5)],ylim,'Color','r','LineWidth',1)
title('\beta_{black}')
hold off

subplot(2,4,6)
histfit(Theta(:,6),100,'kernel')
hold on
line([theta(6) theta(6)],ylim,'Color','r','LineWidth',1)
title('\beta_{south}')
hold off

subplot(2,4,7)
histfit(Theta(:,7),100,'kernel')
hold on
line([theta(7) theta(7)],ylim,'Color','r','LineWidth',1)
title('\sigma_{\epsilon}^2')
hold off