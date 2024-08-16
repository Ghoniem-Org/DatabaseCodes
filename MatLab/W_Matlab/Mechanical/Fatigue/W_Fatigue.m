close all; clear all;

msize=12;fsize=16;
%%%%%%%%%%%%   Data Source  %%%%%%%%%%%%%%%%%%%%%%%
%(1) L. R. Foster, B. A. Stein, Tensile properties and sheet-bending fatigue properties of 
% some refractory metals at room temperature, National Aeronautics and Space Administration, 1963.
% URL https://apps.dtic.mil/sti/tr/pdf/ADA397115.pdf
% (2) R. Schmunk, G. Korth, Tensile and low-cycle fatigue measurements on cross-rolled tungsten, Journal
% of Nuclear Materials 104 (1981) 943–947. 
% (3) J. Habainy, S. Iyengar, Y. Lee, Y. Dai, Fatigue behavior of rolled and forged tungsten at 25, 280 and
% 480 c, Journal of Nuclear Materials 465 (2015) 438–447. 
% (4) J. Habainy, A. Lovberg, S. Iyengar, Y. Lee, Y. Dai, Fatigue properties of tungsten from two different
% processing routes, Journal of Nuclear Materials 506 (2018) 83–91.

%%%%%%%%%%%%%%%%%  DATA  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta=1088;      % Temperature
d=0.05;  % grain size mm
xx=1/d^.5;
N=10.^(0:0.2:8);%  number of cycles array

variance_SN=0.25;   % Variance in yield strength
variance_eps=0.5;   % Variance in ductility
n_1=1e2;       %  High-Low cycle fatigue boundary cycle
n_2=1e7;       %  Endurance limit cycles
k_R=0.35;       % Recrysalization factor
k_B=0.8;         %  Bending factor
k_RL=0.3;       % Rolling factor
k_F=0.25;        % Forging factor
%%%%%%%%%%%%%%%%%%  Experimental Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eps1088_AR=10.^[
2.05671323206460	0.931926242483792
2.66298857885468	0.508994318326083
2.76809625827586	0.496637930792773
4.01978620129471	-0.302885901300550
4.65273484859553	-0.196125002786104
4.69845668914374	-0.153023728279055]/2;

eps1088_R=10.^[1.41214511447982	0.718190020460524
2.20472891305119	0.291967250946070
2.70209056439794	0.0291279069880299
3.00535452680686	-0.130154739886653
4.03034131358163	-0.287993142401709
4.53607301746713	-0.607324323311483
4.75320202744296	-0.496603298904762]/2;

eps300_AR=10.^[
0.994463469462365	-0.204626253278609
3.49357727379796	-0.264607995933764
3.68687849150752	-0.318866957238791
3.99118685350499	-0.352201885396044
5.15709781226674	-0.412424050437648]/2;

eps300_R=10.^[3.32534176573428	-0.940061712361047
4.13580793252857	-0.686432329431801
4.30776676696248	-0.776707418222680
5.65142702753060	-0.978425820703286
5.95460950052075	-0.901829575495734]/2;

eps300_RLU=[1.00193189891934	319.850097020389
0.991750269479594	161.180666777798
2.39498959404596	349.815802430364
2.54644737518947	335.711296561375
2.56611832194370	324.265037193405
3.06248871125131	311.215340399043
4.90111694312095	297.108127164201
4.97166316191711	325.267826167000
5.38673135466145	310.028160472536
5.51206692298975	323.215836233760
5.52768649012836	350.722576607818
5.23614186442363	172.944171408747
5.70415646408737	183.005613142946
5.70648479872089	197.970094436789
6.24844142749346	122.634448755173
6.24206751474257	147.283177704920
6.25546704188179	172.149366147639
6.24988986822477	287.467003978668
6.25876035905860	296.928860868082
6.23713043972649	335.444040875036];

eps300_RLU(:,1)=10.^eps300_RLU(:,1);
eps300_RLU(:,2)=100*eps300_RLU(:,2)/(410e3);

eps300_FU=[1.00099012236907	212.675925600039
3.99978457103142	225.484183375304
4.82567812746201	212.170905176832
5.13752799706367	200.686065845458
5.72188390892576	200.388835751462
5.87115452522666	187.384970793324
6.24694464094334	202.300139351988
6.25340170850256	187.114427591307
6.24890748118671	175.671359047379];
eps300_FU(:,1)=10.^eps300_FU(:,1);
eps300_FU(:,2)=100*eps300_FU(:,2)/(410e3);

eps300_RLP=[2.76571500178493	288.367203124764
3.08404127727333	263.897353704585
3.33897071365004	274.867213374078
3.98737516626127	313.293920532624
5.01713917291520	250.437877750055
5.24373795947383	287.379788121548
5.48781085878032	312.875729199985
5.79712160597848	262.438760351323
5.83260356931379	300.286187908982
6.24999042752788	298.910652672422
6.25428353623751	287.466423828842
6.25417910926890	275.582634800713
6.26284848149651	262.157194302619
6.25614775101052	249.614064997666
6.24286425383643	237.952086586201];
eps300_RLP(:,1)=10.^eps300_RLP(:,1);
eps300_RLP(:,2)=100*eps300_RLP(:,2)/(410e3);

eps300_FP=[5.02754706078694	184.855517553593
5.17020977057395	169.871891315505
5.40940167601417	139.910730412498
5.55014022221285	155.957287822771
5.64007504818144	140.540483048216
5.50207287532696	185.893212208364
6.24665263219777	169.069544106664
6.25532007059263	155.424033441383
6.25079296811999	140.239772055266
6.24845883198822	124.615080259861];
eps300_FP(:,1)=10.^eps300_FP(:,1);
eps300_FP(:,2)=100*eps300_FP(:,2)/(410e3);

Schmunk1505=10.^[2.34066351363076	0.609236486403435
3.11072536418387	0.210768810206468
3.73725076034127	-0.146388233808825
4.67095021436384	-0.527957414472243];

% Foster & Stein data
sig_foster=k_B*[1103 1103 1034 1034 896 896 827 827 792 792 689];
N_foster=[2.4e4 2.6e4 1.73e5 1.03e5 3.647e5 1.459e6 6.658e6 4.564e6 8.025e6 1.0627e7 4e7];


%%%%%%%%%%%%%%  FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ductility=@(T,T1,T2,TW,K_0,K_max,a,b) ...
a*T.*exp(-b*T).*((1+tanh((T-T1)/TW))/2)+((K_max+b*T-K_0)).*((1+tanh((T-T2)/TW))/2);
ultimate_2_yield=@(T,T_0,TW,R_max,a)...
    (0.2+R_max.*exp(-a*T)).*((1+tanh((T-T_0)/TW))/2)+1;
Yield=@(T,a0,a1,a2,T1,T2,TW) a0+a1*exp(-T/T1)+a2*(1-((1+tanh((T-T2)/TW))/2));
Orientation=@(T,O_max,O_min,a,T_1,T_2,TW) O_min+((O_max+a.*exp(-T/T_1)-O_min)).*((1+tanh((T-T_2)/TW))/2);
E=@(T) 4.0761e11-3.5521e7*T-5.871e3*T.^2;
e_t_W=@(T) ductility(T,500,1450,50,4,60,0.25,3.2e-3)/100;
u_2_y_ratio=@(T) ultimate_2_yield(T,650,150,3.5,0.0055);
% sig_y=@(T) 1e6*Yield(T,35,3200,350,180,1700,200); 
sig_y=@(T) (-4.335e-11*T.^4 + 3.126e-7*T.^3-.0004588*T.^2-0.7589*T + 1597);
sig_u=@(T) sig_y(T).*u_2_y_ratio(T);
sig_u_up=@(T) (1+variance_SN)*sig_u(T);
sig_u_dn=@(T) (1-variance_SN)*sig_u(T);
trans=@(n,n_0) (0.5-0.5*tanh((n - n_0 )/n_0));

%%%%%%%%%%%%%%  Stress-Life S-N Curve Functions  %%%%%%%%%%%%%%%%%%%%%%
S_e=@(T) min(600,0.5*sig_u(T)); %[MPa]
f_e=@(T) 0.9;          % ratio of failure strength at n_1 cycles to 1 cycle
b_SN=@(T) log10(f_e(T)*sig_u(T)/S_e(T))/log10(n_1/n_2);
a_SN=@(T) (f_e(T)*sig_u(T))/n_1^b_SN(T);
c_SN=@(T) log10(f_e(T))/log10(n_1);
S=@(n,T) sig_u(T).*n.^c_SN(T).*trans(n,n_1)+...
    (trans(n,n_2)-trans(n,n_1)).*a_SN(T).*n.^b_SN(T)+(1-trans(n,n_2)).*S_e(T);
S_u=@(n,T) (1+variance_SN)*S(n,T);
S_l=@(n,T) (1-variance_SN)*S(n,T);

%%%%%%%%%%%%%%  Strain-Life eps-N Curve Functions  %%%%%%%%%%%%%%%
f_p=@(T) 0.4;          % ratio of failure strain at n_1 cycles to 1 cycle
e_sat_p=@(T) 1e-4; %absolute
e_sat_e=@(T) 1e-6;  
b_eps=@(T) log10(f_p(T)*e_t_W(T)/e_sat_p(T))/log10(n_1/n_2);
c_eps=@(T) log10(f_p(T))/log10(n_1);
a_eps=@(T) f_p(T)*e_t_W(T)/n_1.^b_eps(T);
C=@(T) log(1+e_t_W(T));  
B=@(T) (1+e_t_W(T))*(1e6*sig_u(T)/E(T)); 
del_eps_e=@(T,n) 1e2*(B(T).*n.^b_SN(T)+(1-trans(n,n_2))*e_sat_e(T)); %conversion from absolute to %
del_eps_p=@(T,n) 1e2*(C(T).*n.^c_eps(T).*trans(n,n_1)+...
    (trans(n,n_2)-trans(n,n_1))*a_eps(T).*n.^b_eps(T)+(1-trans(n,n_2))*e_sat_p(T));
del_eps_tot=@(T,n) (del_eps_e(T,n)+del_eps_p(T,n));
del_eps_tot_up=@(T,n) (1+variance_eps)*del_eps_tot(T,n);
del_eps_tot_dn=@(T,n) (1-variance_eps)*del_eps_tot(T,n);

%%%%%%%%%%%%%%  Stress-Life Figures at 300K %%%%%%%%%%%%%%%%%
figure('Name', 'W Fatigue-300K_AR Fine Grain')

p4=loglog (N,S_u(N,300),'--');
p4.LineWidth=2;
p4.Color='b';
hold on
p5=loglog (N,S_l(N,300),'--');
p5.LineWidth=2;
p5.Color='b';
inBetween = [S_u(N,300), fliplr(S_l(N,300))];
x2 = [N, fliplr(N)];
fill(x2, inBetween, [1 1 1]*.8);
hold on
p3=loglog (N,S(N,300),'-');
p3.LineWidth=2;
p3.Color='r';
hold on
%%%%%%%%%%  Exprimental Data %%%%%%%%%%%%%%%%%%%
young=E(theta)*1e-6;
p1=loglog(eps300_AR(:,1),1e-2*young*eps300_AR(:,2),'square');
p1.MarkerSize=msize;
p1.MarkerFaceColor='r';
hold on
p2=loglog(N_foster,sig_foster,'o');
p2.MarkerSize=msize;
p2.MarkerFaceColor='c';
legend({'Upper','Lower','Range','Average','300AR-Schmunk','Foster (bending)'},...
    'Location','southwest','NumColumns',2,'FontSize',msize)
xlabel('Cycles [N]','FontName','Times New Roman','FontSize',fsize)
ylabel('Stress Amplitude, \Delta\sigma/2, [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([1 1e8])
ylim([2e2 2e3])
title('S-N Relationship of As-Recieved W at Room Temperature','FontSize',0.5*fsize)
ax = gca;
ax.FontSize = fsize; 
yticks([100 200 500 1000 2000]);
grid on
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'W Fatigue-300K_Recrytalized Fine Grain')
p6=loglog (N,k_R*S_u(N,300),'-.');
p6.LineWidth=2;
p6.Color='k';
hold on
p7=loglog (N,k_R*S_l(N,300),'--');
p7.LineWidth=2;
p7.Color='k';
inBetween = [k_R*S_u(N,300), k_R*fliplr(S_l(N,300))];
x2 = [N, fliplr(N)];
fill(x2, inBetween, [1 0.7 0.9]);
hold on
p8=loglog (N,k_R*S(N,300),'-');
p8.LineWidth=2;
p8.Color='r';
hold on
%%%%%%%%%%  Exprimental Data %%%%%%%%%%%%%%%%%%%
young=E(theta)*1e-6;
p9=loglog(eps300_R(:,1),1e-2*young*eps300_R(:,2),'o');
p9.MarkerSize=msize;
p9.MarkerFaceColor='r';
legend({'Upper','Lower','Range','Average','300R-Schmunk'},...
    'Location','southwest','NumColumns',2,'FontSize',msize)
xlabel('Cycles [N]','FontName','Times New Roman','FontSize',fsize)
ylabel('Stress Amplitude, \Delta\sigma/2, [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([1 1e8])
ylim([5e1 1e3])
title('S-N Relationship of Recrystalized W at Room Temperature','FontSize',0.5*fsize)
ax = gca;
ax.FontSize = fsize; 
yticks([10 50 100 200 500 1000]);
grid on
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'W Fatigue-300K Rolled')
p10=loglog (N,k_RL*S_u(N,300),'-.');
p10.LineWidth=2;
p10.Color='k';
hold on
p11=loglog (N,k_RL*S_l(N,300),'--');
p11.LineWidth=2;
p11.Color='k';
inBetween = [k_RL*S_u(N,300), k_RL*fliplr(S_l(N,300))];
x2 = [N, fliplr(N)];
fill(x2, inBetween, [1 0.9 0.8]);
hold on
p12=loglog (N,k_RL*S(N,300),'-');
p12.LineWidth=2;
p12.Color='r';
hold on
%%%%%%%%%%  Exprimental Data Rolled W %%%%%%%%%%%%%%%%%%%
p13=loglog(eps300_RLU(:,1),1e-2*young*eps300_RLU(:,2),'o');
p13.MarkerSize=msize;
p13.MarkerFaceColor='g';
hold on
p14=loglog(eps300_RLP(:,1),1e-2*young*eps300_RLP(:,2),'^');
p14.MarkerSize=msize;
p14.MarkerFaceColor='r';
legend({'Upper','Lower','Range','Average','Habainy RLU','Habainy RLP'},...
    'Location','southwest','NumColumns',2,'FontSize',msize)
xlabel('Cycles [N]','FontName','Times New Roman','FontSize',fsize)
ylabel('Stress Amplitude, \Delta\sigma/2, [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([1 1e8])
ylim([5e1 1e3])
title('S-N Relationship of Rolled W at Room Temperature','FontSize',0.5*fsize)
ax = gca;
ax.FontSize = fsize; 
yticks([10 50 100 200 500 1000]);
grid on
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'W Fatigue-300K Forged')
p15=loglog (N,k_F*S_u(N,300),'-.');
p15.LineWidth=2;
p15.Color='k';
hold on
p16=loglog (N,k_F*S_l(N,300),'--');
p16.LineWidth=2;
p16.Color='k';
inBetween = [k_F*S_u(N,300), k_F*fliplr(S_l(N,300))];
x2 = [N, fliplr(N)];
fill(x2, inBetween, [0.7 0.9 0.9]);
hold on
p17=loglog (N,k_F*S(N,300),'-');
p17.LineWidth=2;
p17.Color='r';
hold on
%%%%%%%%%%  Exprimental Data Forged W %%%%%%%%%%%%%%%%%%%

p18=loglog(eps300_FU(:,1),1e-2*young*eps300_FU(:,2),'square');
p18.MarkerSize=msize;
p18.MarkerFaceColor='r';
hold on
p19=loglog(eps300_FP(:,1),1e-2*young*eps300_FP(:,2),'^');
p19.MarkerSize=msize;
p19.MarkerFaceColor='b';
legend({'Upper','Lower','Range','Average','Habainy FU', 'Habainy FP'},...
    'Location','southwest','NumColumns',2,'FontSize',msize)
xlabel('Cycles [N]','FontName','Times 3ew Roman','FontSize',fsize)
ylabel('Stress Amplitude, \Delta\sigma/2, [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([1 1e8])
ylim([5e1 1e3])
title('S-N Relationship of Forged W at Room Temperature','FontSize',0.5*fsize)
ax = gca;
ax.FontSize = fsize; 
yticks([10 50 100 200 500 1000]);
grid on
hold off
%%%%%%%%%%%%%%  Stress-Life Figures at T<1000 K %%%%%%%%%%%%%%%%%
figure('Name', 'W Fatigue-300-1000 K AR')
p20=loglog (N,S(N,300));
p20.LineWidth=2;
p20.Color='r';
hold on
p21=loglog (N,S(N,700));
p21.LineWidth=2;
p21.Color='b';
hold on
p22=loglog (N,S(N,1000));
p22.LineWidth=2;
p22.Color='k';
legend({'300K','700K','1000K'},...
    'Location','southwest','NumColumns',1,'FontSize',msize)
xlabel('Cycles [N]','FontName','Times 3ew Roman','FontSize',fsize)
ylabel('Stress Amplitude, \Delta\sigma/2, [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([1 1e8])
ylim([2e2 2e3])
title('S-N Relationship of As-Recieved W at Low Temperature','FontSize',0.5*fsize)
ax = gca;
ax.FontSize = fsize; 
yticks([100 200 500 1000 2000]);
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rolled
figure('Name', 'W Fatigue-300-1000 K Rolled')
LineWidth=2;
p20=loglog (N,k_RL*S(N,300));
p20.LineWidth=2;
p20.Color='r';
hold on
p21=loglog (N,k_RL*S(N,700));
p21.LineWidth=2;
p21.Color='b';
hold on
p22=loglog (N,k_RL*S(N,1000));
p22.LineWidth=2;
p22.Color='k';
legend({'300K','700K','1000K'},...
    'Location','southwest','NumColumns',1,'FontSize',msize)
xlabel('Cycles [N]','FontName','Times 3ew Roman','FontSize',fsize)
ylabel('Stress Amplitude, \Delta\sigma/2, [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([1 1e8])
ylim([5e1 5e2])
title('S-N Relationship of Rolled W at Low Temperature','FontSize',0.5*fsize)
ax = gca;
ax.FontSize = fsize; 
yticks([10 50 100 200 500]);
grid on
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'W Strain-Life at 1088K -Recrystalized')
p24=loglog (N,k_R*del_eps_tot_up(1088,N),'-.');
p24.LineWidth=2;
p24.Color='k';
hold on
p25=loglog (N,k_R*del_eps_tot_dn(1088,N),'--');
p25.LineWidth=2;
p25.Color='k';
inBetween = [k_R*del_eps_tot_up(1088,N), fliplr(k_R*del_eps_tot_dn(1088,N))];
x2 = [N, fliplr(N)];
fill(x2, inBetween, [1 0.9 0.8]);
hold on
loglog (N,k_R*del_eps_e(1088,N),'--',N,k_R*del_eps_p(1088,N),'-.',...
    N,k_R*del_eps_tot(1088,N),'-',LineWidth=2);
% p23.LineWidth=2;
% p23.Color='r';
hold on
%%%%%%%%%%  Exprimental Data Recrystalized W %%%%%%%%%%%%%%%%%%%
p26=loglog(eps1088_R(:,1),eps1088_R(:,2),'square');
p26.MarkerSize=msize;
p26.MarkerFaceColor='r';
legend({'upper','lower','range','elastic','plastic','total','Schmunk'},...
    'Location','southwest','NumColumns',3,'FontSize',msize)
xlabel('Cycles [N]','FontName','Times New Roman','FontSize',fsize)
ylabel('Strain Amplitude, \Delta\epsilon/2, [%]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([1 1e8])
ylim([1e-3 1e2])
title('Strain-life relationship of recrystalized W at 1088K','FontSize',0.5*fsize)
ax = gca;
ax.FontSize = fsize; 
grid on
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name', 'W Strain-Life at 1088K -Rolled')
p27=loglog (N,del_eps_tot_up(1088,N),'-.');
p27.LineWidth=2;
p27.Color='k';
hold on
p28=loglog (N,del_eps_tot_dn(1088,N),'--');
p28.LineWidth=2;
p28.Color='k';
inBetween = [del_eps_tot_up(1088,N), fliplr(del_eps_tot_dn(1088,N))];
x2 = [N, fliplr(N)];
fill(x2, inBetween, [1 0.8 0.9]);
hold on
p=loglog (N,del_eps_e(1088,N),'--',N,del_eps_p(1088,N),'-.',...
    N,del_eps_tot(1088,N),'-',LineWidth=2);
hold on
%%%%%%%%%%  Exprimental Data Rolled W %%%%%%%%%%%%%%%%%%%
p26=loglog(eps1088_AR(:,1),eps1088_AR(:,2),'o');
p26.MarkerSize=msize;
p26.MarkerFaceColor='g';
hold on
legend({'upper','lower','range','elastic','plastic','total','Schmunk'},...
    'Location','southwest','NumColumns',3,'FontSize',msize)
xlabel('Cycles [N]','FontName','Times New Roman','FontSize',fsize)
ylabel('Strain Amplitude, \Delta\epsilon/2, [%]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([1 1e8])
ylim([1e-3 1e2])
title('Strain-life relationship of rolled W at 1088K','FontSize',0.5*fsize)
ax = gca;
ax.FontSize = fsize; 
grid on
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
figure('Name', 'W Strain-Life at 1501 K -Rolled')
p27=loglog (N,del_eps_tot_up(1405,N),'-.');
p27.LineWidth=2;
p27.Color='k';
hold on
p28=loglog (N,del_eps_tot_dn(1405,N),'--');
p28.LineWidth=2;
p28.Color='k';
inBetween = [del_eps_tot_up(1405,N), fliplr(del_eps_tot_dn(1405,N))];
x2 = [N, fliplr(N)];
fill(x2, inBetween, [1 0.9 0.95]);
hold on
p=loglog (N,del_eps_e(1405,N),'--',N,del_eps_p(1405,N),'-.',...
    N,del_eps_tot(1405,N),'-',LineWidth=2);
hold on
%%%%%%%%%%  Exprimental Data Rolled W %%%%%%%%%%%%%%%%%%%
p=loglog(Schmunk1505(:,1),Schmunk1505(:,2)/2,'square');
p.MarkerSize=msize;
p.MarkerFaceColor='y';
hold on
legend({'upper','lower','range','elastic','plastic','total','Schmunk'},...
    'Location','southwest','NumColumns',3,'FontSize',msize)
xlabel('Cycles [N]','FontName','Times New Roman','FontSize',fsize)
ylabel('Strain Amplitude, \Delta\epsilon/2, [%]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([1 1e8])
ylim([1e-3 1e2])
title('Strain-life relationship of rolled W at 1505 K','FontSize',0.5*fsize)
ax = gca;
ax.FontSize = fsize; 
grid on
hold off


%%%%%%%%%%%%%%  Strain-Life Figures at T>1000 K %%%%%%%%%%%%%%%%%
figure('Name', 'W Fatigue-1000-2500 K AR')
p=loglog (N,del_eps_tot(1000,N));
p.LineWidth=2;
p.Color='r';
hold on
p=loglog (N,del_eps_tot(1200,N));
p.LineWidth=2;
p.Color='b';
hold on
p=loglog (N,del_eps_tot(1450,N));
p.LineWidth=2;
p.Color='k';
p=loglog (N,del_eps_tot(2500,N));
p.LineWidth=2;
p.Color='c';
legend({'1000 K','1200 K','1450 K','2500 K'},...
    'Location','southwest','NumColumns',2,'FontSize',msize)
xlabel('Cycles [N]','FontName','Times 3ew Roman','FontSize',fsize)
ylabel('Strain Amplitude, \Delta\epsilon/2, [%]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([1 1e8])
title('Strain-life relationship of rolled W at high-temperature','FontSize',0.5*fsize)
ax = gca;
ax.FontSize = fsize; 
grid on
hold off
