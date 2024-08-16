close all; clear all;

msize=10;fsize=14;
%%%%%%%%%%%%   Data Source  %%%%%%%%%%%%%%%%%%%%%%%
%(1) J.F. Stubbins, D.S. Gelles, Journal of Nuclear Materials
% Volumes 233–237, Part 1, 1 October 1996, Pages 331-335
% (2) Evaluation of fatigue properties of reduced activation ferritic/martensitic steel, 
% F82H for development of design criteria, Takanori Hirose a, Taichiro Kato a, 
% Hideo Sakasegawa b, Hiroyasu Tanigawa a, Takashi Nozawa
% Fusion Engineering and Design
% Volume 160, November 2020, 111823
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
E=@(T) 4.0761e11-3.5521e7*T-5.871e3*T.^2;
x=10;

sig_y_un=@(T)(960.9-2.716*T+0.00496*T^2-3.112e-6*T^3);
sig_u_un=@(T)(1065-2.468*T+0.004087*T^2-2.575e-6*T^3);
eps_u_un=@(T)(7.393-0.002602*T-1.649e-5*T^2+1.282e-8*T^3);
del_sig_y=@(T,d)(1-exp(-d/9.992))^0.5*(3700-7.9*T+0.0039*T^2);
del_sig_he=@(T,d)max((-233.5+17.33*x^0.5)*(1-exp(- x/0.02922))^(0.5),0);
C=@(T) 1e-2*eps_u_un(T)./ (1-sig_y_un(T)./sig_u_un(T));
sig_y_irr=@(T,d) sig_y_un(T)+del_sig_y(T,d)+del_sig_he(T,d);
sig_u=@(T,d) sig_y_irr(T,d)./(1-1e-2*eps_u_un(T)./C(T));
e_tot=@(T,d) max( 1e-2*(1.066-0.004282*d-0.0001004*d^2)*(62.09-0.2306*T+0.0003032*T^2-1.082e-7*T^3),0.01);


C=@(T,d) 100*log(1+e_tot(T,d));
B=@(T,d) 2.5*(1+e_tot(T,d))*sig_u(T,d)*1e8/E(T);
b=-0.06;
c=-0.63;
del_eps_e=@(T,d,n) B(T,d).*(n).^b;
del_eps_p=@(T,d,n) C(T,d).*(n).^c;
del_eps_tot=@(T,d,n) del_eps_e(T,d,n)+del_eps_p(T,d,n);


n=0:0.2:8;
N2=2*10.^n-1;
dose=10;
eps300=del_eps_tot(300,dose,N2);
eps500=del_eps_tot(500,dose,N2);
eps700=del_eps_tot(700,dose,N2);
eps900=del_eps_tot(900,dose,N2);



figure('Name', 'Irradiated F82H Fatigue')
p7=loglog (N2,eps300);
p7.LineWidth=2;
p7.Color='k';
hold on
p8=loglog (N2,eps500);
p8.LineWidth=2;
p8.Color='b';
hold on
p9=loglog (N2,eps700);
p9.LineWidth=2;
p9.Color='r';
hold on
p10=loglog (N2,eps900);
p10.LineWidth=2;
p10.Color='g';
hold on
legend({'300K','500K','700K','900K','plastic','total fit-673K','elastic','plastic','total'},...
    'Location','southwest','NumColumns',3,'FontSize',msize)
xlabel('Cycles [2N]','FontName','Times New Roman','FontSize',fsize)
ylabel('Strain Amplitude [\Delta \epsilon/2], %','FontSize',fsize,'FontName', 'Times New Roman')
xlim([1 1e7])
ylim([1e-3 1e2])
title('Fatigue of F82H at 10 dpa')
ax = gca;
ax.FontSize = fsize; 
hold on

