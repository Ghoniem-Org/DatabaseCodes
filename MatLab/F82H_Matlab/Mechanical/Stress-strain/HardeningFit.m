function HardenigFit()
global fsize msize

[x,y,z] = readvars('HardeningData2.xlsx');
myfittype = fittype('(a+b*x+d*x^2)*(1-exp(- y/(c)))^(0.5)',...
    'dependent',{'z'},'independent',{'x','y'},...
    'coefficients',{'a','b','c','d'});
surffit = fit([x,y],z,myfittype);
figure(1)
plot(surffit,[x,y],z)
% legend({'100 ^\circ C','200 ^\circ C','300 ^\circ C','400 ^\circ C','500 ^\circ C','600 ^\circ C'},...
%     'Location','northeast','NumColumns',2,'FontSize',msize)
ylabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
zlabel('\Delta \sigma_y [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)

hold off
end