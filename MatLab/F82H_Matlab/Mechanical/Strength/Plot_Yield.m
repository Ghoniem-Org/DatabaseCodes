clear all
fsize=14;msize=10;
T=300:10:1000;
n=size(T,2);

[T1,CEA_u,T2,ECN_u,T3,CIEMAT_u,T4,FZK_JAERI_u,T5,CEA_y,...
T6,CIEMAT_y,T7,ECN_y,T8,FZK_y,T9,JAERI_y] = readvars('F82HStrengthData.xlsx');

sig_y=zeros(n,1);
sig_u=zeros(n,1);

theta=[20 100 200 250 300 350 400 450 500 550 600 650 700]';
s_y_tafa=[491 452 432 427 423 417 408 392 367 332 282 217 134]';
s_u_tafa=[610 563 526 512 499 484 467 444 415 377 329 269 194]';

T_u=[T1(1:8);T2(1:8);T3(1:5);T4(1:8);theta];
T_y=[T5(1:8);T6(1:5);T7(1:8);T8(1:6);T9(1:3);theta];
s_u=[CEA_u(1:8);ECN_u(1:8);CIEMAT_u(1:5);FZK_JAERI_u(1:8);s_u_tafa];
s_y=[CEA_y(1:8);CIEMAT_y(1:5);ECN_y(1:8);FZK_y(1:6);JAERI_y(1:3);s_y_tafa];

T_Ky=T_y+273;
T_Ku=T_u+273;
[s_fit_y,gof_y]=fit(T_Ky,s_y,'poly3')
[s_fit_u,gof_u]=fit(T_Ku,s_u,'poly3')


figure( 'Name', 'Yield Strength of F82H' );
plot(s_fit_y,'k')
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('\sigma_y [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([290 1000])
 ylim([0 700])
title('Yield Strength of F82H')
ax = gca;
ax.FontSize = fsize; 
hold on
p=plot(T5+273,CEA_y,'square');
p.MarkerSize=msize;
p.MarkerFaceColor='green';
hold on
p=plot(T6+273,ECN_y,'o');
p.MarkerSize=msize;
p.MarkerFaceColor='r';
hold on
p=plot(T7+273,CIEMAT_y,'diamond');
p.MarkerSize=msize;
p.MarkerFaceColor='magenta';
hold on
p=plot(T8+273,FZK_y,'>');
p.MarkerSize=msize;
p.MarkerFaceColor='blue';
hold on
p=plot(T9+273,JAERI_y,'<');
p.MarkerSize=msize;
p.MarkerFaceColor='green';
hold on
p=plot(theta+273,s_y_tafa,'k o');
p.MarkerSize=msize;
p.MarkerFaceColor='k';
hold on
CIF = predint(s_fit_y,T,0.95,'Functional');
CIO = predint(s_fit_y,T,0.95,'obs');
plot(T,CIF,':b','LineWidth',2)
plot(T,CIO,':g','LineWidth',2)
legend({'Data Fit','CEA','ECN','CIEMAT','FZK','JAERI','Tavasolli','95% Prediction',},...
    'Location','southwest','NumColumns',2,FontSize=10)
hold off


figure( 'Name', 'Ultimate Strength of F82H' );
plot(s_fit_u,'k')
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('\sigma_u [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([290 1000])
 ylim([0 700])
title('Ultimate Strength of F82H')
ax = gca;
ax.FontSize = fsize; 
hold on
p=plot(T1+273,CEA_u,'square');
p.MarkerSize=msize;
p.MarkerFaceColor='green';
hold on
p=plot(T3+273,CIEMAT_u,'o');
p.MarkerSize=msize;
p.MarkerFaceColor='r';
hold on
p=plot(T2+273,ECN_u,'diamond');
p.MarkerSize=msize;
p.MarkerFaceColor='magenta';
hold on
p=plot(T4+273,FZK_JAERI_u,'>');
p.MarkerSize=msize;
p.MarkerFaceColor='blue';
p=plot(theta+273,s_u_tafa,'k o');
p.MarkerSize=msize;
p.MarkerFaceColor='k';
hold on
CIF = predint(s_fit_u,T,0.95,'Functional');
CIO = predint(s_fit_u,T,0.95,'obs');
plot(T,CIF,':b','LineWidth',2)
plot(T,CIO,':g','LineWidth',2)
legend({'Data Fit','CEA','CIEMAT','ECN','FZK & JAERI','Tavasolli','95% Prediction',},...
    'Location','southwest','NumColumns',2,FontSize=10)
hold off
