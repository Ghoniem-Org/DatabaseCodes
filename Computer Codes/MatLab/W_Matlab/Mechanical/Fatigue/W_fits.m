function W_fits()

global sig_u_W sig_u_KWRe eps_u_W eps_u_KWRe eps_t_KWRe eps_t_W p_sig_u_W ...
    p_sig_u_KWRe sig_u_W_chenHR sig_y_W_chenHR RA_W RA_KWRe Skoro_y Streichen ...
    Drury Kravchenko_10mu  Kravchenko_63mu Nogami_u_L Nogami_u_T Nogami_u_S...
    Kavchenko_500 Kavchenko_1000 Kavchenko_1500 F_S F_T

global fsize  msize

%%%%  FUNCTION FITS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ductility=@(T,T1,T2,TW,K_0,K_max,a,b) ...
a*T.*exp(-b*T).*((1+tanh((T-T1)/TW))/2)+((K_max+b*T-K_0)).*((1+tanh((T-T2)/TW))/2);
ultimate_2_yield=@(T,T_0,TW,R_max,a)...
    (0.2+R_max.*exp(-a*T)).*((1+tanh((T-T_0)/TW))/2)+1;
RA=@(T,T_0,TW,RA_0,RA_max,a) (RA_max+a*T-RA_0).*((1+tanh((T-T_0)/TW))/2);
Poisson=@(T) 0.28247+6.1902e-6*(T-298)+3.162e-9.*T.^2;
yield_plansee=@(T) -4.335e-11*T.^4+ 3.126e-7*T.^3-0.0004588*T.^2-0.7589*T+1597 ;
Yield=@(T,a0,a1,a2,T1,T2,TW) a0+a1*exp(-T/T1)+a2*(1-((1+tanh((T-T2)/TW))/2));
Grain=@(x,T,T_0,TW,x_0) 1000*(1-((1+tanh((T-T_0)/TW))/2)).*(1-exp(-((x/x_0).*(773./T))))-30;  
Orientation=@(T,O_max,O_min,a,T_1,T_2,TW) O_min+((O_max+a.*exp(-T/T_1)-O_min)).*((1+tanh((T-T_2)/TW))/2);

%%%%  POLYNOMIAL FITS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sig_u_W_fit,~] = fit([sig_u_W(:,1)],[sig_u_W(:,2)],'poly4');
p_sig_u_W = coeffvalues(sig_u_W_fit);
[sig_u_KWRe_fit,~] = fit([sig_u_KWRe(:,1)],[sig_u_KWRe(:,2)],'poly4');
p_sig_u_KWRe = coeffvalues(sig_u_KWRe_fit);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=300:10:2500;
e_u_W=ductility(T,500,1450,50,4,25,0.06,3.5e-3);
e_u_KWRe=ductility(T,300,1700,200,6,20,0.12,3.5e-3);
e_t_W=ductility(T,500,1450,50,4,60,0.25,3.2e-3);
e_t_KWRe=ductility(T,400,1500,200,4,40,0.25,3e-3);
u_2_y_ratio=ultimate_2_yield(T,650,150,3.5,0.0055);
n=(log(u_2_y_ratio)).^0.754/3.93;
RA_W_f=RA(T,525,85,0.5,86,0.005);
RA_KWRe_f=RA(T,550,200,5,80,0.005);
nu=Poisson(T);
plansee=yield_plansee(T);
plansee_y=Yield(T,35,3200,350,180,1700,200);  % (T,a0,a1,a2,T1,T2,TW) a0+a1*exp(-T/T1)+a2*(1-((1+tanh((T-T2)/TW))/2));
plansee_u=plansee_y.*u_2_y_ratio;
T_factor=Orientation(T,0.9,0.6,1.1,600,600,150);       %%%% =@((T,O_max,O_min,a,T_1,T_2,TW) ((O_max+b.*exp(-T/T_1)-O_min)).*((1+tanh((T-T_2)/TW))/2);
S_factor=Orientation(T,0.8,0.05,1.25,600,500,250);

%%%%%%%%%%%%%%%%%  UNIFORM ELONGATION    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','W & K-doped W Re Uniform Elongation')
plot(T,e_u_W,'g','LineWidth',2);
hold on
plot(T,e_u_KWRe,'r','LineWidth',2);
f_eps_u_W=plot(eps_u_W(:,1),eps_u_W(:,2),'o');
f_eps_u_W.MarkerSize=msize;
f_eps_u_W.MarkerFaceColor='green';
f_eps_u_KWRe=plot(eps_u_KWRe(:,1),eps_u_KWRe(:,2),'^');
f_eps_u_KWRe.MarkerSize=msize;
f_eps_u_KWRe.MarkerFaceColor='r';
legend({'W fit','K-dpoed WRe fit','W Nogami','K-dpoed WRe Nogami',},...
   'Location','northeast','NumColumns',2,'FontSize',msize)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('\epsilon_u [%]','FontSize',fsize,'FontName', 'Times New Roman')
title('Uniform Elongation of W & K-doped WRe')
ax = gca;
ax.FontSize = fsize; 
xlim([300 2500]);
ylim([0 60]) ;
hold off


%%%%%%%%%%%%%%%%%  TOTAL ELONGATION      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','W & K-doped W Re Total Elongation')
plot(T,e_t_W,'r','LineWidth',2);
hold on
plot(T,e_t_KWRe,'b','LineWidth',2);
W_u=plot(eps_t_W(:,1),eps_t_W(:,2),'o');
W_u.MarkerSize=msize;
W_u.MarkerFaceColor=[0.5 0 0];
W_y=plot(eps_t_KWRe(:,1),eps_t_KWRe(:,2),'^');
W_y.MarkerSize=msize;
W_y.MarkerFaceColor='c';
legend({'W fit','K-dpoed WRe fit','W Nogami','K-dpoed WRe Nogami',},...
   'Location','northeast','NumColumns',2,'FontSize',msize)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('\epsilon_t [%]','FontSize',fsize,'FontName', 'Times New Roman')
title('Total Elongation of W & K-doped WRe')
ax = gca;
ax.FontSize = fsize; 
xlim([300 2500]);
ylim([0 100]) ;
hold off


%%%%%%%%%%%%%%%%%  Strain Hardening Exponent    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Name','Strain Hardening Exponent')
plot(T,n,'b','LineWidth',2);
hold on
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('n','FontSize',fsize,'FontName', 'Times New Roman')
title('Strain Hardening Exponent')
ax = gca;
ax.FontSize = fsize; 
xlim([300 2500]);
hold off

%%%%%%%%%%%%%%%%%  REDUCTION IN AREA     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','W & K-doped W Re Reduction in Area')
plot(T,RA_W_f,'r','LineWidth',2);
hold on
plot(T,RA_KWRe_f,'b','LineWidth',2);
W_u=plot(RA_W(:,1),RA_W(:,2),'o');
W_u.MarkerSize=msize;
W_u.MarkerFaceColor=[0.5 0 0];
W_y=plot(RA_KWRe(:,1),RA_KWRe(:,2),'^');
W_y.MarkerSize=msize;
W_y.MarkerFaceColor='c';
legend({'W fit','K-dpoed WRe fit','W Nogami','K-dpoed WRe Nogami',},...
   'Location','southeast','NumColumns',2,'FontSize',msize)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('RA [%]','FontSize',fsize,'FontName', 'Times New Roman')
title('Area Reducion of W & K-doped WRe')
ax = gca;
ax.FontSize = fsize; 
xlim([300 2500]);
ylim([0 100]) ;
hold off



%%%%%%%%%%%%%%%%%  ULTIMATE STRENGTH    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','W & K-doped W Re Strengh')
f_sig_u_W_fit=plot(sig_u_W_fit,'r');
hold on
f_sig_u_W1=plot(sig_u_W(:,1),sig_u_W(:,2),'o');
% f_sig_u_W2=plot(Skoro_y(:,1),Skoro_y(:,2),'square');
f_sig_u_W_fit.LineWidth=2;
f_sig_u_W1.MarkerSize=msize;
f_sig_u_W1.MarkerFaceColor=[0.5 0 0];
% f_sig_u_W2.MarkerSize=msize;
% f_sig_u_W2.MarkerFaceColor=[0.3 0 0];
f_sig_u_KWRe_fit=plot(sig_u_KWRe_fit,'b');
f_sig_u_KWRe=plot(sig_u_KWRe(:,1),sig_u_KWRe(:,2),'^');
f_sig_u_KWRe_fit.LineWidth=2;
f_sig_u_KWRe.MarkerSize=msize;
f_sig_u_KWRe.MarkerFaceColor='c';
legend({'W fit','W Nogami','W Skoro','K-dpoed WRe fit','K-dpoed WRe Nogami',},...
   'Location','northeast','NumColumns',2,'FontSize',msize)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('\sigma_u [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
title('Ultimate Strength of W & K-doped WRe')
ax = gca;
ax.FontSize = fsize; 
xlim([300 1500])
ylim([0 1200]) 
hold off


%%%%%%%%%%%%%%%%%  Ultimate & YIELD      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','Ultimate & Yield Strength')
plot(T,plansee,'r --','LineWidth',2)
hold on
plot(T,plansee_y,'b','LineWidth',2)
plot(T,plansee_u,'r','LineWidth',2)
W_u=plot(273+sig_u_W_chenHR(:,1),sig_u_W_chenHR(:,2),'o');
W_u.MarkerSize=msize;
W_u.MarkerFaceColor='g';
W_y=plot(273+sig_y_W_chenHR(:,1),sig_y_W_chenHR(:,2),'^');
W_y.MarkerSize=msize;
W_y.MarkerFaceColor='c';
Skoro=plot(Skoro_y(:,1),Skoro_y(:,2),'square');
Skoro.MarkerSize=msize;
Skoro.MarkerFaceColor=[0.7 0.1 0];
Drury_y=plot(Drury(:,1),Drury(:,2),'^');
Drury_y.MarkerSize=msize;
Drury_y.MarkerFaceColor=[0.1 0.7 0];
Strei=plot(Streichen(:,1),Streichen(:,2),'o');
Strei.MarkerSize=msize;
Strei.MarkerFaceColor='b';
Krav10=plot(Kravchenko_10mu(:,1), Kravchenko_10mu(:,2),'o');
Krav10.MarkerSize=msize;
Krav10.MarkerFaceColor='y';
Krav63=plot(Kravchenko_63mu(:,1), Kravchenko_63mu(:,2),'square');
Krav63.MarkerSize=msize;
Krav63.MarkerFaceColor='y';
Nogami=plot(Nogami_u_L(:,1), Nogami_u_L(:,2),'>');
Nogami.MarkerSize=msize;
Nogami.MarkerFaceColor=[0.5 0 0.2];
legend({'\sigma_y -Plansee','\sigma_y fit -Shen HR',...
    '\sigma_u fit -Shen HR','\sigma_u -Shen HR','\sigma_y -Shen HR',...
    '\sigma_y Skoro-corrected','\sigma_y Drury','\sigma_y Streichen',...
    '\sigma_y Kravchenko -10\mu m','\sigma_y Kravchenko -63\mu m',...
    'Nogami \sigma_u -LD'},'Location','northeast','NumColumns',3,'FontSize',msize);
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('\sigma [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
title('W Ultimate & Yield Strength ')
ax = gca;
ax.FontSize = fsize; 
xlim([300 2500]);
ylim([0 1200]) ;
hold off


%%%%%%%%%%%%%%%%%  Ultimate/ Yield ratio      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('Name','Ultimate/Yield Strength - Shen -HR')
plot(T,u_2_y_ratio,'b','LineWidth',2);
hold on
W_r=plot(273+sig_y_W_chenHR(:,1),sig_u_W_chenHR(:,2)./sig_y_W_chenHR(:,2),'^');
W_r.MarkerSize=msize;
W_r.MarkerFaceColor='b';
legend({'\sigma_u/\sigma_y fit','\sigma_u/\sigma_y Chen HR'},...
   'Location','northeast','NumColumns',1,'FontSize',msize)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('\sigma_u/\sigma_y','FontSize',fsize,'FontName', 'Times New Roman')
title('Ultimate to Yield Ratio - Shen')
ax = gca;
ax.FontSize = fsize; 
xlim([300 1000]);
ylim([1 1.4]) ;
hold off


%%%%%%%%%%%%%%%%%%%%% Poisson's Ratio %%%%%%%%%%%%%%%%%%%%%

figure('Name','W Poisson Ratio')
hold on
plot(T,nu,'b','LineWidth',2);
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('Poisson Ratio','FontSize',fsize,'FontName', 'Times New Roman')
title('W Poisson Ratio')
ax = gca;
ax.FontSize = fsize; 
xlim([300 2500]);
ylim([0 0.5]) ;
hold off

%%% Grain Size -ASTM relationship  %%%%%%%%%%%%%%%
L=1:1:300;
G= 2.8854.*log(320./L);

figure('Name','ASTM Grain Size')
plot(L,G,'b','LineWidth',2);
hold on
xline(150,'c','LineWidth',3)
xline(50,'r','LineWidth',3)
text(200,10,'Shen 150-320 \mum')
text(60,15,'Nogami d_L=100 \mum') 
text(60,12,'d_T=60 \mum, d_S=22 \mum')
xlabel('Grain Size [\mum]','FontName','Times New Roman','FontSize',fsize)
ylabel('ASTM #','FontSize',fsize,'FontName', 'Times New Roman')
title('ASTM Grain Size')
ax = gca;
ax.FontSize = fsize; 
xlim([1 300]);
ylim([0 20]) ;
hold off


%%%%% Grain Orientation Correction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure('Name','W Grain Orientation Factors')
plot(T,T_factor,'r','LineWidth',2);
hold on
plot(T,S_factor,'b','LineWidth',2);
W_T=plot(F_T(:,1),F_T(:,2),'o');
W_T.MarkerSize=msize;
W_T.MarkerFaceColor=[0.5 0 0];
W_S=plot(F_S(:,1),F_S(:,2),'^');
W_S.MarkerSize=msize;
W_S.MarkerFaceColor='c';
legend({'T-direction fit','S-direction fit','T-direction Nogami','S-direction Nogami',},...
   'Location','southeast','NumColumns',2,'FontSize',msize)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('Grain Orientation Factor','FontSize',fsize,'FontName', 'Times New Roman')
title('Grain Orientation Factor')
ax = gca;
ax.FontSize = fsize; 
xlim([200 2500]);
ylim([0 1.2]) ;
hold off



%%%%%%%%%%%%%%%%%%%%%%  Grain Size Correction %%%%%%%%%%%%%%%%%%%%%%%
T=[773; 1273; 1773]; 
x=1:.1:10;
GS_ratio1=Grain(x,T,773,3500,2);       %%  (x,T,T_0,TW,x_0)       

figure('Name','Grain Size Correction-1')
hold on
plot(x,GS_ratio1,'LineWidth',2);
hold on
Kav_1=plot(Kavchenko_500(:,1),Kavchenko_500(:,2),'^');
Kav_1.MarkerSize=msize;
Kav_1.MarkerFaceColor=[1 0 0];
Kav_2=plot(Kavchenko_1000(:,1),Kavchenko_1000(:,2),'^');
Kav_2.MarkerSize=msize;
Kav_2.MarkerFaceColor=[0 1 0];
Kav_3=plot(Kavchenko_1500(:,1),Kavchenko_1500(:,2),'^');
Kav_3.MarkerSize=msize;
Kav_3.MarkerFaceColor=[0 0 1];
legend({'500 ^\circC','1000 ^\circC','1500 ^\circC'},...
   'Location','northeast','NumColumns',1,'FontSize',msize)
xlabel('d^{-1/2} [mm^{-1/2}]','FontName','Times New Roman','FontSize',fsize)
ylabel('Yield [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
title('Grain Size Correction-1')
ax = gca;
ax.FontSize = fsize; 
xlim([0 10]);
ylim([0 600]) ;
hold off

T=[773; 1273; 1773]; 
x=1:.1:10;
xx=1000./x.^2;
GS_ratio2=Grain(x,T,773,3500,2)./Grain(1/.1^.5,T,773,3500,2);       %%  (x,T,T_0,TW,x_0) (600)*(1/(1+exp(T_T_0)/TW)).*(1-exp(-x/x_0))      

figure('Name','Grain Size Correction-2')
hold on
plot(xx,GS_ratio2,'LineWidth',2);
legend({'500 ^\circC','1000 ^\circC','1500 ^\circC'},...
   'Location','northeast','NumColumns',1,'FontSize',msize)
xlabel('Average Grain Size, d [\mum]','FontName','Times New Roman','FontSize',fsize)
ylabel('Yield GS Factor','FontSize',fsize,'FontName', 'Times New Roman')
title('Grain Size Correction-2')
ax = gca;
ax.FontSize = fsize; 
xlim([1 350]);
ylim([0 2]) ;
hold off


end