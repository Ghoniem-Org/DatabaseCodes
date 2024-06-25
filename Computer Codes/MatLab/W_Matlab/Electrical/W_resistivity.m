close all; clc; clear all;
global rho_Rudkin rho_Forsythe rho_Desai

fsize=14;msize=10;

W_resistivity_data ()

t=[rho_Rudkin(:,1); rho_Rudkin(:,1); rho_Forsythe(:,1); ...
    rho_Forsythe(:,1); rho_Desai(:,1); rho_Desai(:,1)];
resistivity=[rho_Rudkin(:,2); rho_Rudkin(:,2); rho_Forsythe(:,2); ...
    rho_Forsythe(:,2); rho_Desai(:,2); rho_Desai(:,2)];

T=linspace(0,3500,10);
% eqn = @(T,a_0,a_1,a_2) (a_0+a_1*T+a_2.*T.^2); % equation to fit  
% rho_u=eqn(T,0,0.019,7e-6);
% rho_l=eqn(T,0,0.015,6e-6);
% rho_av=(rho_u+rho_l)/2;

[fitted_curve,gof] = fit(t,resistivity,'poly4')

rho=-1.005e-12*T.^4+5.943e-09*T.^3-6.539e-06*T.^2+0.03118*T-1.784 ;
rho_u=-1.005e-12*T.^4+6.e-09*T.^3-6.539e-06*T.^2+0.035*T-1.784 ;
rho_l=-1.005e-12*T.^4+5.5e-09*T.^3-6.539e-06*T.^2+0.028*T-1.784 ;

%%%%%%%%%%%%%%%%%%%%% Generate Figure  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure( 'Name', 'W Emmisivity' );
p=plot(rho_Rudkin(:,1),rho_Rudkin(:,2),'>');
p.MarkerSize=msize;
p.MarkerFaceColor='c';
hold on
p=plot(rho_Forsythe(:,1),rho_Forsythe(:,2),'square');
p.MarkerSize=msize;
p.MarkerFaceColor='blue';
p=plot(rho_Desai(:,1),rho_Desai(:,2),'o');
p.MarkerSize=msize;
p.MarkerFaceColor='m';

plot(T,rho,'-','Color','k','LineWidth',2)
plot(T,rho_u,'-','Color','r','LineWidth',2)
plot(T,rho_l,'-','Color','b','LineWidth',2)

xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel( 'Resistivity, [10^{-8} \Omega m]','FontSize',fsize,'FontName', 'Times New Roman')
title('Electrical Resistivity of pure W')
ax = gca;
ax.FontSize = fsize; 
xlim([0 3500])
ylim([0 150])
legend({'Rudkin', 'Forsythe','Desia', 'Average Fit','Max Fit','Min Fit'},...
    'Location','northwest','NumColumns',3,'FontSize',msize)
hold off