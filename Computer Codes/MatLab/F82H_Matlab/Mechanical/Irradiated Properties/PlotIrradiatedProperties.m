function PlotIrradiatedProperties()
global  fsize T dpa eps_u_irr...
    eps_tot_irr sig_y_irr sig_u_irr tangent_irr K_irr


figure('Name','Ultimate elongation')
surf(T,dpa,1e2*eps_u_irr)
ylabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
zlabel('\epsilon_{u} [%]','FontSize',fsize,'FontName', 'Times New Roman')
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylim([1 100]);
figure('Name','Total elongation')
surf(T,dpa,1e2*eps_tot_irr)
ylabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
zlabel('\epsilon_{tot} [%]','FontSize',fsize,'FontName', 'Times New Roman')
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylim([1 100]);
zlim([0 30]);
figure('Name','Irradiated Yield')
surf(T,dpa,sig_y_irr)
ylabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
zlabel('\sigma_{y} [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylim([1 100]);

figure('Name','Irradiated Ultimate')
surf(T,dpa,sig_u_irr)
ylabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
zlabel('\sigma_{u} [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylim([1 100]);

figure('Name','Irradiated Tangent Modulus')
surf(T,dpa,tangent_irr)
ylabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
zlabel('Tangent Modulus [GPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylim([1 100]);

figure('Name','Irradiated Fracture Toughness')
surf(T,dpa,K_irr)
ylabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
zlabel('Fracture Toughness [MPa.\surd{m}]','FontSize',fsize,'FontName', 'Times New Roman')
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylim([1 100]);
xlim([600 900])
zlim([0 300]);
end