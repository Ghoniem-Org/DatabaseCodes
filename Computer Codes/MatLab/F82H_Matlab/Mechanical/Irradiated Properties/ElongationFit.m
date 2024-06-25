function ElongationFit()
global fsize msize

[x,y,z] = readvars('ElongationData.xlsx');
TotalElongation = fittype('(62.09-0.2306*y+ 0.0003032*y^2-1.082e-7*y^3)*(a+b*x+c*x^2)',...
    'dependent',{'z'},'independent',{'x','y'},...
    'coefficients',{'a','b','c'})
surffit = fit([x,y],z,TotalElongation)
figure(1)
plot(surffit,[x,y],z)
xlabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
zlabel('\epsilon_{tot} [%]','FontSize',fsize,'FontName', 'Times New Roman')
ylabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
hold off
[x]=[
0	3.53772793116525;
0.71092142319817	3.02330757418448;
2 2;
16.16616205260835	0.454637579344599;
9.8605462265852	1.16432181735665;
14.7967845619183	0.553363713793680;
30.5121946670480	0.559680196954906;
42.3914603137104	0.532300480574946;
69.1812072191932	0.317987677884228;
78.2149718058552	0.482390316383687]

UniformElongation = fittype('a_u+b_u*exp(- x/c_u)',...
    'dependent',{'y'},'independent',{'x'},...
    'coefficients',{'a_u','b_u','c_u'})
% [p,gof] = fit(x(:,1),x(:,2),'poly2');
p = fit(x(:,1),x(:,2),UniformElongation)
figure(2)
dpa=0:1:100;
epsilon=p(dpa);
plot(dpa,epsilon,'k',LineWidth=2)
hold on
plot(x(:,1),x(:,2),'o','MarkerFaceColor','r',MarkerSize=msize)
legend({'Data Fit','Experiment'},...
    'Location','northeast','NumColumns',1,'FontSize',msize)
xlabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
ylabel('\epsilon_u [%]','FontName','Times New Roman','FontSize',fsize)
hold off


end