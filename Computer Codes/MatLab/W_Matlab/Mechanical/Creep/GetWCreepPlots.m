function GetWCreepPlots(Temp,sig,LinearTime,q)
global msize fsize t_r
plot(LinearTime/3600,q,LineWidth=2)
title(strcat('Creep Strain of PM W at $\sigma=$',num2str(sig*1e-6), '[MPa]')...
,'FontSize',fsize,'Interpreter','latex');
% xlim([0 min(t_r)]);
xlim([0 100]);
% ylim([0 80]);
ylabel('Creep Strain (\epsilon) [%]','FontName','Times New Roman','FontSize',fsize)
xlabel('Time [hr]','FontName','Times New Roman','FontSize',fsize)
legend({strcat('T=',num2str(Temp(1,1)),'[K]'),strcat('T=',num2str(Temp(1,2)),'[K]')...
    ,strcat('T=',num2str(Temp(1,3)),'[K]') },...
    'Location','northwest','NumColumns',1,'FontSize',0.7*fsize)
hold on

end

