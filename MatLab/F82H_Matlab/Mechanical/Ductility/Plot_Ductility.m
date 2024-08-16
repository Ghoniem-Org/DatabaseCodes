clear all
fsize=14;msize=10;
T=300:10:1000;
n=size(T,2);

[T1,CEA_u,T2,ECN_u,T3,CIEMAT_u,T4,FZK_u,T5,CEA_tot,...
T6,CIEMAT_tot,T7,ECN_tot,T8,FZK_tot,T9,JAERI_tot] = readvars('F82HDuctilityData.xlsx');

T_u=[T1(1:11);T2(1:8);T3(1:7);T4(1:8)];
T_tot=[T5(1:13);T6(1:8);T7(1:8);T8(1:4);T9(1:4)];
e_u=[CEA_u(1:11);ECN_u(1:8);CIEMAT_u(1:7);FZK_u(1:8)];
e_tot=[CEA_tot(1:13);CIEMAT_tot(1:8);ECN_tot(1:8);FZK_tot(1:4);JAERI_tot(1:4)];

T_Ktot=T_tot+273;
T_Ku=T_u+273;
[e_fit_tot,gof_tot]=fit(T_Ktot,e_tot,'poly3')
[e_fit_u,gof_u]=fit(T_Ku,e_u,'poly3')


figure(1);
plot(e_fit_tot,'k')
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('\epsilon_{tot} [%]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([290 1000])
 ylim([0 50])
title('Total Elongation of F82H')
ax = gca;
ax.FontSize = fsize; 
hold on
p=plot(T5+273,CEA_tot,'square');
p.MarkerSize=msize;
p.MarkerFaceColor='green';
hold on
p=plot(T6+273,ECN_tot,'o');
p.MarkerSize=msize;
p.MarkerFaceColor='r';
hold on
p=plot(T7+273,CIEMAT_tot,'diamond');
p.MarkerSize=msize;
p.MarkerFaceColor='magenta';
hold on
p=plot(T8+273,FZK_tot,'>');
p.MarkerSize=msize;
p.MarkerFaceColor='blue';
hold on
p=plot(T9+273,JAERI_tot,'<');
p.MarkerSize=msize;
p.MarkerFaceColor='green';
hold on
CIF = predint(e_fit_tot,T,0.95,'Functional');
CIO = predint(e_fit_tot,T,0.95,'obs');
plot(T,CIF,':b','LineWidth',2)
plot(T,CIO,':g','LineWidth',2)
legend({'Data Fit','CEA','ECN','CIEMAT','FZK','JAERI','95% Prediction',},...
    'Location','northwest','NumColumns',2,FontSize=10)
hold off


figure(2);
plot(e_fit_u,'k')
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('\epsilon_u [%]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([290 1000])
 ylim([0 10])
title('Uniform Elongation of F82H')
ax = gca;
ax.FontSize = fsize; 
hold on
p=plot(T1+273,CEA_u,'square');
p.MarkerSize=msize;
p.MarkerFaceColor='green';
hold on
p=plot(T2+273,ECN_u,'diamond');
p.MarkerSize=msize;
p.MarkerFaceColor='magenta';
hold on
p=plot(T3+273,CIEMAT_u,'o');
p.MarkerSize=msize;
p.MarkerFaceColor='r';
hold on
p=plot(T4+273,FZK_u,'>');
p.MarkerSize=msize;
p.MarkerFaceColor='blue';
hold on
CIF = predint(e_fit_u,T,0.95,'Functional');
CIO = predint(e_fit_u,T,0.95,'obs');
plot(T,CIF,':b','LineWidth',2)
plot(T,CIO,':g','LineWidth',2)
legend({'Data Fit','CEA','ECN','CIEMAT','FZK','95% Prediction',},...
    'Location','northwest','NumColumns',2,FontSize=10)
hold off
