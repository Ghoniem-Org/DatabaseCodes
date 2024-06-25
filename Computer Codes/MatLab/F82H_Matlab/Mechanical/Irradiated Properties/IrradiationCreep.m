close all; clear all;

msize=10;fsize=14;
%%%%%%%%%%%%   Data Source  %%%%%%%%%%%%%%%%%%%%%%%
%  Effect of Helium on Irradiation Creep Behavior of B-Doped F82H Irradiated in HFIR
%  M. Ando,T. Nozawa,T. Hirose,H. Tanigawa,E. Wakai,R. E. Stoller & show all
%  Fusion Science and Technology 
%  Volume 68, 2015 - Issue 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=@(T) 1+0.0025*(T-500);
K=@(T) 4e-7;
epsT573=[0 0;
    136.255519585351	0.0248201903587631;
213.480000270769	0.0311437190245142;
282.785647899129	0.0363611257481057;
343.169177262122	0.0441124749034546;
85.2698050111477	0.00516261171247147;
128.136088623429	0.00953676128399919;
214.118716448846	0.0262723263386289;
258.073691847387	0.0377136225475102;
291.961817118009	0.0611179025288498];

epsT673=[0 0;
    84.4804907328371	0.0213919404499501;
126.931783984097	0.0155853931396112;
146.330717161516	0.0364226370790993;
170.096078260028	0.0398553612203517;
216.065754245203	0.0822205437221556;
212.866493728644	0.0596020532120862;
102.574924069624	0.0200790102826195;
207.091714135858	0.0181995047753801;
208.735957454594	0.0806533061732309];


epsT773=[0 0;
    49.7249429759829	0.0124393166876058;
77.6722003342157	0.0255264810997401;
135.579327421539	0.185527792347194;
170.045009331203	0.289900650134784];
sig=0:10:400;
eps573=K(573).*sig.^m(573);
eps673=K(673).*sig.^m(673);
eps773=K(773).*sig.^m(773);

figure('Name', 'F82H Irradiation Creep')
p1=plot (epsT573(:,1),epsT573(:,2),'o');
p1.MarkerSize=msize;
p1.MarkerFaceColor='r';
hold on
p2=plot (epsT673(:,1),epsT673(:,2),'square');
p2.MarkerSize=msize;
p2.MarkerFaceColor='g';
hold on
p3=plot (epsT773(:,1),epsT773(:,2),'^');
p3.MarkerSize=msize;
p3.MarkerFaceColor='b';
hold on
p4=plot (sig,100*eps573);
p4.LineWidth=2;
p4.Color='r';
hold on
p5=plot (sig,100*eps673);
p5.LineWidth=2;
p5.Color='g';
hold on
p6=plot (sig,100*eps773);
p6.LineWidth=2;
p6.Color='b';
hold on
legend({'573 [K]','673 [K]','773 [K]','573-fit','673-fit','773-fit'},...
    'Location','northeast','NumColumns',2,'FontSize',msize)
xlabel('Stress [MPa]','FontName','Times New Roman','FontSize',fsize)
ylabel('Strain/dose [%/dpa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([0 400])
ylim([0 0.3])
title('Radiation Creep of F82H - Ando et al.')
ax = gca;
ax.FontSize = fsize; 
hold on

m(673)
m(773)
K(673)
K(773)