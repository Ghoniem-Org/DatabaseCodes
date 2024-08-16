function PlotHardening (T,Phi)
global fsize  msize x y 

Del_sig=F82H_Hardening(T,Phi);
% figure(2)
% plot (Phi,Del_sig,LineWidth=2)
% legend({'200 ^\circ C','300 ^\circ C','400 ^\circ C','500 ^\circ C','600 ^\circ C','600 ^\circ C'},...
%     'Location','northwest','NumColumns',2,'FontSize',msize)
% xlabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
% ylabel('\Delta \sigma_y [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
% xlim([0 200])
% ylim([-250 1000])
% title('Radiation hardening of F82H - 5 appm He/dpa')
% ax = gca;
% ax.FontSize = fsize; 
% hold on

x=[0.079055448	47.41935427;
0.04285295	100.6928192;
0.869426323	113.8077875;
0.987158205	164.0857547;
1.888902411	218.7140857;
1.821084987	261.6192958;
2.205857452	195.0156978;
3.039461703	200.8621294;
2.871155009	168.331898;
2.789009259	143.1912334;
2.318203065	129.9182535;
3.255508142	283.6837758;
3.618547223	344.3064642;
4.406715671	313.188252;
4.828585075	339.788003;
5.557382583	319.0346836;
7.500804754	298.2208491;
7.102836624	279.0106649;
6.397539175	351.5312955;
7.77153926	326.3133061;
8.981721187	304.0672807;
8.832234937	367.6821049;
8.903099833	423.8905525;
14.31368881	389.6490884;
14.68636659	425.1378361;
15.6482166	349.6620511;
24.88606696	367.130745;
26.88539675	399.6206331;
27.0112174	424.7646596;
30.0297901	440.9591743;
68.82118294	450.5440947;
86.10519073	494.6528831;
87.26060494	414.7561335;
]
figure(2)
plot (Phi,Del_sig,LineWidth=2)
legend({'200 ^\circ C','300 ^\circ C','400 ^\circ C','500 ^\circ C','600 ^\circ C'},...
    'Location','northwest','NumColumns',2,'FontSize',msize)
xlabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
ylabel('\Delta \sigma_y [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([0 100])
% ylim([-250 1400])
title('Radiation hardening of F82H - 10 appm helium')
ax = gca;
ax.FontSize = fsize; 
hold on


end
