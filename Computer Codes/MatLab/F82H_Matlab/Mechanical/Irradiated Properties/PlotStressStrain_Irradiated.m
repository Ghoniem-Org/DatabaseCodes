function PlotStressStrain_Irradiated(T,d)
global  fsize msize
   

[eps_u_irr, eps_tot_irr, sig_y_irr, sig_u_irr,~]=IrradiatedProperties (T,d);
 a1=0.7; a2=0.1;
    E=1e3*(218.76 -0.077834*(T-273) + 1.4735e-4*(T-273)^2-2.1998e-7*(T-273)^3);
sig_f=(a1*sig_y_irr+a2*sig_u_irr);
    eps_y_irr=min(0.002,sig_y_irr/E);
        eps=[0,eps_y_irr,eps_u_irr,eps_tot_irr];
        sig=[0,sig_y_irr,sig_u_irr,sig_f];

    plot(1e2*eps,sig,LineWidth=2)
xlabel('strain [%]','FontName','Times New Roman','FontSize',fsize)
ylabel('Stress [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
 legend({'20 dpa','40 dpa','60 dpa', '80 dpa', '100 dpa'},...
  'Location','northeast','NumColumns',2,'FontSize',msize)
 title('Stress-strain diagrams of F82H at 600^\circ C')
ax = gca;
ax.FontSize = fsize; 
hold on
end