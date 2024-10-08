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
e_tot=@(T) 1e-2*(62.09-0.2306*T+0.0003032*T.^2-1.082e-7*T.^3);
sig_u=@(T) 1065-2.468*T+0.004087*T.^2-2.575e-6*T.^3;
C=@(T) 100*log(1+e_tot(T))
B=@(T) 2.5*(1+e_tot(T))*sig_u(T)*1e8/E(T)
b=-0.06;
c=-0.63;
del_eps_e=@(T,n) B(T).*(n).^b;
del_eps_p=@(T,n) C(T).*(n).^c;
del_eps_tot=@(T,n) del_eps_e(T,n)+del_eps_p(T,n);

epseT300=10.^[3.28713290805089	-0.604795020361770;
3.60130611256646	-0.663020267611838;
3.89665434759946	-0.673058233654257;
4.20106197309085	-0.661269928809467;
4.50597401898638	-0.715081497523296;
4.81051615658554	-0.720786492294138;
5.41070918146020	-0.775889377242569;
5.71114197416695	-0.847174068755864];

epspT300=10.^[3.28891519347885	-0.836581240268890;
3.60439989104519	-1.06536615877137;
3.90860574837493	-1.02733790450313;
3.90978272931792	-1.18040427613991;
4.20192957618598	-1.37410171133029;
4.51323767280602	-1.65971967676740;
4.81801520659378	-1.69603794586560;
5.42405950815648	-2.51209936409401;
5.71149170564716	-2.69265664775651];


epstT300=10.^[3.29946094272811	-0.408055930134411;
3.58632146376076	-0.514266690430473;
3.91362977560018	-0.480712645146971;
3.90965494281554	-0.563785641505056;
4.20978508327981	-0.595710408883180;
4.51004973585185	-0.645128475876934;
4.81034801645083	-0.698919867774598;
5.41986945599941	-0.767183081067084;
5.72481512992188	-0.825367974684821];


eps_H_T300=10.^[3.02874588718245	-1.99019112353408;
3.07488164368302	-1.81951873588233;
2.99084092292142	-1.81679989273153;
3.53212381256898	-2.08482666859200;
3.71657401008736	-2.21052881292998;
3.86847235258321	-2.07891865130527;
3.98710715501325	-2.15433251162935;
4.00421853887966	-2.20746341010593;
4.63613297164606	-2.28239868802409;
4.48002640454653	-2.39443235382092;
4.64368302167030	-2.39987416583293];


eps_H_T573=10.^[4.04247188103859	-2.20750291697480;
4.12194452390381	-2.21301532735083];




eps_H_T673=10.^[3.42704196878900	-1.98422534630182;
3.48462657163780	-1.97857724877002;
3.67777170381525	-2.11825729992883;
3.76636102028818	-2.10978309077594;
4.32184666797314	-2.29388054005549;
4.38385609522140	-2.28822831681330;
4.64820067455365	-2.39147834517756;
4.74124575825400	-2.38020277866595;
4.85567233608037	-2.43604014316215;
5.09021897207926	-2.43302424886285;
5.16958732581767	-2.45812507091065;
5.61213165141873	-2.45211803657442;
5.91308159623736	-2.44624302497086;
6.03703856507793	-2.44053304178313;
6.09892422101431	-2.44606974513424];



n=0:0.2:8;
N2=2*10.^n-1;
eps300=del_eps_tot(300,N2);
eps500=del_eps_tot(500,N2);
eps700=del_eps_tot(700,N2);
eps900=del_eps_tot(900,N2);



figure('Name', 'F82H Fatigue')
% p0=loglog (1,B(673)/2.5,'>');
% p0.MarkerSize=msize;
% p0.MarkerFaceColor=[0 0.5 0.5];
% hold on
% p00=loglog (1,C(673),'<');
% p00.MarkerSize=msize;
% p00.MarkerFaceColor=[0 0.5 0.5];
% p1=loglog (epseT300(:,1),epseT300(:,2),'o');
% p1.MarkerSize=msize;
% p1.MarkerFaceColor=[1 .5 .3];
% hold on
% p2=loglog(epspT300(:,1),epspT300(:,2),'square');
% p2.MarkerSize=msize;
% p2.MarkerFaceColor='r';
% hold on
% p3=loglog(epstT300(:,1),epstT300(:,2),'^');
% p3.MarkerSize=msize;
% p3.MarkerFaceColor='b';
% hold on
% p4=plot (eps_H_T673(:,1),0.5e2*eps_H_T673(:,2),'square');
% p4.LineWidth=2;
% p4.MarkerSize=msize;
% p4.MarkerFaceColor=[0 1 1];
% hold on
% p5=loglog (N2,del_eps_e,'--');
% p5.LineWidth=2;
% p5.Color=[1 .5 .3];
% hold on
% p6=loglog (N2,del_eps_p,'-..');
% p6.LineWidth=2;
% p6.Color='r';
% hold on
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
ylim([5e-2 5e1])
title('Fatigue of F82H for 300<T<900 K')
ax = gca;
ax.FontSize = fsize; 
hold on

