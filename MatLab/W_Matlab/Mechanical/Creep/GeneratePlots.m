function GeneratePlots(Temp,sig)

global tr_Conway tr_Harris tr_Green tr_Klopp ...
    epsdot_Flagella epsdot_Klopp epsdot_Green2 epsdot_King2 epsdot_Gilbert

global fsize msize taulog y1 y2 y3 y4 LM1 LM2 sig_over_E sig_LM ...
    eps1 eps2 eps3 tau_p e_ss tau_r tau_t  eps_tot eps_0 e_r tau_0

%%%%%%%%%%%%%%%%%%%%% Generate Steady-State Creep Figure  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure( 'Name', 'W Steady-State Creep' );
p=loglog(10.^epsdot_Flagella(:,1),10.^(epsdot_Flagella(:,2)+4),'>');
p.MarkerSize=msize;
p.MarkerFaceColor='c';
hold on
p=loglog(10.^epsdot_Klopp(:,1),10.^(epsdot_Klopp(:,2)+4),'square');
p.MarkerSize=msize;
p.MarkerFaceColor='blue';
p=loglog(10.^epsdot_Green2(:,1),10.^(epsdot_Green2(:,2)+4),'o');
p.MarkerSize=msize;
p.MarkerFaceColor='m';
p=loglog(10.^epsdot_King2(:,1),10.^(epsdot_King2(:,2)+4),'^');
p.MarkerSize=msize;
p.MarkerFaceColor='y';
p=loglog(10.^epsdot_Gilbert(:,1),10.^(epsdot_Gilbert(:,2)+4),'<');
p.MarkerSize=msize;
p.MarkerFaceColor='k';
loglog(sig_over_E,y1,'k:',LineWidth=1)
loglog(sig_over_E,y2,'b:',LineWidth=1)
loglog(sig_over_E,y1+y2,'r',LineWidth=2)
loglog(sig_over_E,y3,'c-.',LineWidth=1)
loglog(sig_over_E,y4,'k-.',LineWidth=1)
loglog(sig_over_E,y3+y4,'m',LineWidth=2)

xlabel('\sigma/E','FontName','Times New Roman','FontSize',fsize)
ylabel( '$\dot{\epsilon}/D ~[m^{-2}]$','FontSize',fsize,'FontName', 'Times New Roman','Interpreter','latex')
title('Steady-State Creep of pure W')
ax = gca;
ax.FontSize = fsize; 
xlim([10^(-6) 1e-2])
ylim([10^(6) 10^17])
legend({'Flagella (AM)', 'Klopp (AM)','Green (AM)', 'King (PM)',...
    'Gilbert (PM)','','','HR Fit','','','AM Fit'},...
    'Location','northwest','NumColumns',1,'FontSize',1.4*msize)
text(1e-5,1e9,'Coarse-grain (Arc Melting)',Rotation=65)
text(1e-4,2e9,'Fine-grain (HR)',Rotation=65)
grid on
hold off

%%%%%%%%%%%%%%%%%%%%% Generate Creep Rupture Figure  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure( 'Name', 'W Creep Rupture' );
p=loglog(10.^tr_Conway(:,1),tr_Conway(:,2),'>');
p.MarkerSize=msize;
p.MarkerFaceColor='c';
hold on
p=loglog(10.^tr_Klopp(:,1),tr_Klopp(:,2),'square');
p.MarkerSize=msize;
p.MarkerFaceColor='blue';
p=loglog(10.^tr_Green(:,1),tr_Green(:,2),'^');
p.MarkerSize=msize;
p.MarkerFaceColor='y';
p=loglog(10.^tr_Harris(:,1),tr_Harris(:,2),'<');
p.MarkerSize=msize;
p.MarkerFaceColor='k';

loglog(sig_LM,LM1,'k:',LineWidth=1)
loglog(sig_LM,LM2,'b-.',LineWidth=1)
loglog(sig_LM,(LM1+LM2)/2,'r',LineWidth=2)

xlabel('\sigma [MPa]','FontName','Times New Roman','FontSize',fsize)
ylabel( 'LM Parameter ($P_{LM}$)','FontSize',fsize,'FontName', 'Times New Roman','Interpreter','latex')
title('Creep Rupture of pure W')
ax = gca;
ax.FontSize = fsize; 
xlim([1 10^3]);
ylim([15 70]);
legend({'Conway', 'Klopp', 'Green','Harris','Min','Max','Average'},...
    'Location','northeast','NumColumns',2,'FontSize',1.4*msize)
grid on
hold off

%%%%%%%%%%%%%%%%%%%%% Generate Creep Rate Figure  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'W Creep Rate');
loglog (10.^taulog,10.^eps1,'k:',10.^taulog,10.^eps2,'b:',10.^taulog,10.^eps3,'g:',LineWidth=1)
hold on
loglog (10.^taulog,10.^eps_tot,LineWidth=2)
loglog(10.^tau_0, 10.^eps_0, 'ro', 'MarkerSize', 3,'MarkerFaceColor','r');
loglog(10.^tau_p, 10.^e_ss, 'ro', 'MarkerSize', 3,'MarkerFaceColor','r');
loglog(10.^tau_t, 10.^e_ss, 'ro', 'MarkerSize', 3,'MarkerFaceColor','r');
loglog(10.^tau_r, 10.^e_r, 'ro', 'MarkerSize', 3,'MarkerFaceColor','r');
xlim([10.^(-2) 10.^max(tau_r)+1])
ylim([10.^(min(e_ss)-1) 10.^(max(e_ss)+2)])
ylabel('$\dot\epsilon [s^{-1}]$','FontName','Times New Roman','FontSize',fsize,'Interpreter','latex')
xlabel('Time [hour]','FontName','Times New Roman','FontSize',fsize)
title('Creep Strain Rate of PM W at $\sigma=$ [MPa]',num2str(sig*1e-6)...
,'FontSize',fsize,'Interpreter','latex');
ax = gca;
ax.FontSize = fsize; 
legend(cellstr(num2str(Temp','T = %d K')),'location','southwest','NumColumns',2,'FontSize',1.4*msize);
grid on
hold off