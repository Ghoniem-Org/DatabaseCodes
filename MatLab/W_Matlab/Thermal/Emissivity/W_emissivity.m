close all; clc; clear all;
global eps_short_Minissale eps_inter_Minisscale eps_long_Minisscale ...
    eps_inter_Brodu eps_Matsumoto eps_Rudkin eps_Worthing

fsize=14;msize=8;

W_emmisivity_data ()

t=[eps_short_Minissale(:,1); eps_inter_Minisscale(:,1); eps_long_Minisscale(:,1); ...
    eps_inter_Brodu(:,1); eps_Matsumoto(:,1); eps_Rudkin(:,1); eps_Worthing(:,1)];
emmisivity=[eps_short_Minissale(:,2); eps_inter_Minisscale(:,2);...
    eps_long_Minisscale(:,2); eps_inter_Brodu(:,2); eps_Matsumoto(:,2); ...
    eps_Rudkin(:,2); eps_Worthing(:,2)];

T=linspace(0,3500,100);
eqn = @(T,T_0,TW,eps_0,eps_max,a) (eps_max+a*T-eps_0).*((1+tanh((T-T_0)/TW))/2); % equation to fit  
eps_u=eqn(T,700,650,0.25,0.55,2e-5);
eps_l=eqn(T,1100,700,0.25,0.45,4e-5);
eps_av=(eps_u+eps_l)/2;

%%%%%%%%%%%%%%%%%%%%% Generate Figure  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure( 'Name', 'W Emmisivity' );
p=plot(eps_short_Minissale(:,1),eps_short_Minissale(:,2),'o');
p.MarkerSize=msize;
p.MarkerFaceColor='red';
hold on
p=plot(eps_inter_Minisscale(:,1),eps_inter_Minisscale(:,2),'square');
p.MarkerSize=1.5*msize;
p.MarkerFaceColor='blue';
p=plot(eps_long_Minisscale(:,1),eps_long_Minisscale(:,2),'o');
p.MarkerSize=0.75*msize;
p.MarkerFaceColor='w';
p=plot(eps_inter_Brodu(:,1),eps_inter_Brodu(:,2),'square');
p.MarkerSize=msize;
p.MarkerFaceColor='green';
p=plot(eps_Matsumoto(:,1),eps_Matsumoto(:,2),'>');
p.MarkerSize=msize;
p.MarkerFaceColor='c';
p=plot(eps_Rudkin(:,1),eps_Rudkin(:,2),'<');
p.MarkerSize=msize;
p.MarkerFaceColor=[0.9 0.5 0.2];
p=plot(eps_Worthing(:,1),eps_Worthing(:,2),'o');
p.MarkerSize=msize;
p.MarkerFaceColor=[0.5 0.3 0];

plot(T,eps_u,'-.','Color','b','LineWidth',1)
plot(T,eps_l,'-.','Color','c','LineWidth',1)
plot(T,eps_av,'-','Color','k','LineWidth',2)

xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('Thermal Emissivity','FontSize',fsize,'FontName', 'Times New Roman')
title('Thermal emissivity of pure W')
ax = gca;
ax.FontSize = fsize; 
xlim([0 3500])
ylim([0 0.5])
legend({'Minissale - short', 'Minissale - intermediate','Minissale - long', ...
    'Brodu', 'Matsumoto', 'Rudkin', 'Worthing','Max Fit','Min Fit', 'Average Fit'},'Location','northeast','NumColumns',3,'FontSize',msize)
hold off