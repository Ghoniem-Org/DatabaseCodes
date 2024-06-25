close all; clear all;

msize=10;fsize=14;
%%%%%%%%%%%%   Data Source  %%%%%%%%%%%%%%%%%%%%%%%
%Journal of Nuclear Materials 155-157 (1988) 715-721
% COMPATIBILITY OF FERRITIC STEELS IN FORCED CIRCULATION LITHIUM
% AND Pb-17Li SYSTEMS
% O.K. CHOPRA 1 and D.L. SMITH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a_1=7.3;
b_1=-5.8;
a_2=7.85;
b_2=-5.;
del=0.4;
k=8.617333e-5;
A_1=10^(a_1+del)
A_2=10^(a_2+del/2)
Q_1=-1000*k*b_1/0.434
Q_2=-1000*k*b_2/0.434

d_1=@(T) A_1*exp(-Q_1/(k*T))
d_2=@(T) A_2*exp(-Q_2/(k*T))

t=0:0.5:3;

figure('Name','Dissolution distace for Li')
plot(t,d_1(673)*t,'r',LineWidth=2)
hold on
plot(t,d_1(773)*t,'b',LineWidth=2)
hold on
plot(t,d_1(873)*t,'k',LineWidth=2)
hold on
legend({'400 ^\circ C','500 ^\circ C','600 ^\circ C'},...
    'Location','northeast','NumColumns',1,'FontSize',msize)
xlabel('Time [years]','FontName','Times New Roman','FontSize',fsize)
ylabel('Dissolution Distance [\mum]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([0 3])
ylim([0 50])
title('Dissolution of F/M steels in Li')
ax = gca;
ax.FontSize = fsize; 
hold on
figure('Name','Dissolution distace for LiPb')
plot(t,d_2(673)*t,'r',LineWidth=2)
hold on
plot(t,d_2(773)*t,'b',LineWidth=2)
hold on
plot(t,d_2(873)*t,'k',LineWidth=2)
hold on
legend({'400 ^\circ C','500 ^\circ C','600 ^\circ C'},...
    'Location','northwest','NumColumns',1,'FontSize',msize)
xlabel('Time [years]','FontName','Times New Roman','FontSize',fsize)
ylabel('Dissolution Distance [\mum]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([0 3])
ylim([0 500])
title('Dissolution of F/M steels in LiPb')
ax = gca;
ax.FontSize = fsize; 
hold on

x1=1:0.1:1.7;
y_1=a_1+b_1.*x1;
y_2=a_2+b_2.*x1;
y_1_p=y_1+del;
y_1_m=y_1-1.5*del;
y_2_p=y_2+del/2;
y_2_m=y_2-del/2;

LiPb=[
1.24614423355027	1.54050606418169;
1.30347993900426	1.28288417001498;
1.34989701085955	1.05077686615696;
1.37616411298375	0.926209787052576;
1.45803241548361	0.535436735758166;
1.54648055990713	0.100256415138551;
1.61958529376359	-0.241006448768912;
];

Li=[1.14884529209627	0.473114251898460;
1.23559106381897	0.451572435374154;
1.23394109951456	-0.400959327018995;
1.23355023868734	-0.425415588623890;
1.29495231607870	-0.414730309388239;
1.32555862766381	-0.313217098470036;
1.32487074115091	-0.0361215687093424;
1.32444866140778	-0.450156260923952;
1.32545676480104	-0.631075103025233;
1.32299760619618	-0.662081985157536;
1.32593753610609	-0.697899383671544;
1.32517829207110	-0.769632042444134;
1.32229616175408	-0.792494992520186;
1.32401373731067	-0.851150875674103;
1.43656502998884	-1.11367782024101;
1.42824854938328	-1.13016697473539;
1.42828795549427	-1.17017355979665;
1.42787518643270	-1.22109785526181;
1.43896024486638	-1.19547535365767;
1.44214517412980	-1.13905467336106;
1.55085588722740	-1.53024988427051;
1.54994258094797	-1.54299289938255;
    ];

figure('Name', 'F/M steel corrosion rates')
p1=semilogy (LiPb(:,1),10.^LiPb(:,2),'o');
p1.MarkerSize=msize;
p1.MarkerFaceColor=[1 .5 .3];
hold on
p2=semilogy(Li(:,1),10.^Li(:,2),'square');
p2.MarkerSize=msize;
p2.MarkerFaceColor='b';
hold on
p3=semilogy(x1,10.^y_1,'k');
p3.LineWidth=2;
hold on
p3p=semilogy(x1,10.^y_1_p,'b--');
p3p.LineWidth=1;
hold on
p3m=semilogy(x1,10.^y_1_m,'b--');
p3m.LineWidth=1;
hold on
x2 = [x1, fliplr(x1)];
inBetween = [10.^y_1_m, fliplr(10.^y_1_p)];
fill(x2, inBetween, 'cyan','FaceAlpha',0.1);
p4=semilogy (x1,10.^y_2,'b');
p4.LineWidth=2;
p4p=semilogy(x1,10.^y_2_p,'b--');
p4p.LineWidth=1;
hold on
p4m=semilogy(x1,10.^y_2_m,'b--');
p4m.LineWidth=1;
hold on
x2 = [x1, fliplr(x1)];
inBetween = [10.^y_2_m, fliplr(10.^y_2_p)];
fill(x2, inBetween, 'yellow','FaceAlpha',0.1);
hold on
text(1.2,1,'Lithium','FontSize',msize)
text(1.4,10,'LiPb','FontSize',msize)
legend({'LiPb - Chopra','Li WARD/ORNL/ANL','LiPb fit','Li fit'},...
    'Location','northeast','NumColumns',2,'FontSize',msize)
xlabel('1000/T [K^{-1}]','FontName','Times New Roman','FontSize',fsize)
ylabel('Dissolution rate [\mum/year]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([1 1.7])
ylim([1e-2 1e3])
title('Dissolution of F/M steels in Li and LiPb')
ax = gca;
ax.FontSize = fsize; 
hold on

