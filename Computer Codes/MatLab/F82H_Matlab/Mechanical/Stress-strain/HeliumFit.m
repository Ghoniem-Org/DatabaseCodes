function HeliumFit()
global fsize msize
Data=[
535.9012675,	40.62810261;
559.8232805,	149.8468557;
568.7157208,	318.5232895;
929.695322,	    337.8366292;
1042.977859,	339.7289247;
1411.800619,	243.5661108;
1181.441831,	351.1355742;
1282.559947,	362.6232256;
1436.915034,	395.2478857;
1675.566821,	401.2285296;
1258.689189,	408.2891995;
1335.246135,	478.1803812;
1342.697345,	472.8623783;
1794.483757,	596.2722228];

appm=Data(:,1);
del_sig_he=Data(:,2);
% myfit = fit(appm,del_sig_he,'poly2');
myfit = fittype('(a+b*x.^(0.5)).*(1-exp(- x/(c))).^(0.5)','independent','x')
fit(appm,del_sig_he,myfit)

figure( 'Name', 'Helium Hardening of F82H' );
a =-233.5;b=17.33;c=0.02922;
       
       x=0:100:2500;
y=(a+b*x.^0.5).*(1-exp(- x/(c))).^(0.5);
plot(x,y,'LineWidth',2)
hold on
p=plot(appm,del_sig_he,'o');
p.MarkerSize=msize;
p.MarkerFaceColor='r';

xlabel(['Helium Conc.' ...
    ', appm'],'FontName','Times New Roman','FontSize',fsize)
ylabel('\Delta \sigma_{He} [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
legend('Data Fit ','Experiment','Location','southeast','NumColumns',1,'FontSize',msize)
title('Helium Hardening of F82H')
ax = gca;
ax.FontSize = fsize;
xlim([0 2500])
 ylim([0 1000])

end
