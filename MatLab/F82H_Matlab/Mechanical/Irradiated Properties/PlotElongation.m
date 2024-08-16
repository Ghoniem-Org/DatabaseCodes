function PlotElongation (T,dpa)
global fsize  msize  

Del_sig=F82H_Hardening(T,dpa);
% figure('Name', 'F82H Hardening')
% plot (dpa,Del_sig,LineWidth=2)
% legend({'200 ^\circ C','300 ^\circ C','400 ^\circ C','500 ^\circ C','600 ^\circ C','600 ^\circ C'},...
%     'Location','northwest','NumColumns',2,'FontSize',msize)
% xlabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
% ylabel('\Delta \sigma_y [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
% xlim([0 200])
% ylim([-250 1000])
% title('Radiation hardening of F82H - 5 appm He/dpa')
% ax = gca;
% ax.FontSize = fsize; 
% hold on


figure('Name', 'F82H Hardening')
plot (dpa,Del_sig,LineWidth=2)
legend({'200 ^\circ C','300 ^\circ C','400 ^\circ C','500 ^\circ C','600 ^\circ C'},...
    'Location','northwest','NumColumns',2,'FontSize',msize)
xlabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
ylabel('\Delta \sigma_y [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([0 100])
% ylim([-250 1400])
title('Radiation hardening of F82H - 10 appm helium')
ax = gca;
ax.FontSize = fsize; 
hold on


end
