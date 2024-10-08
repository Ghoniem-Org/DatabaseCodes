%%%%%%%%%%%%%%%  FRACTURE TOUGHNESS  %%%%%%%%%%%%%%%%%%%
close all; clear all;
fsize=14;msize=10;
K_0=30;
K_max=220;
T_0=-50+273;
T_width=50;
A=0.25;
B=0.4;
dpa_max=100;
del_dpa=1;
T_max=900;
T_min=0;
del_T=5;
he_dpa_ratio=10;
t_count=(T_max-T_min)/del_T;
sig_y_irr=zeros(dpa_max+1,t_count+1);
sig_u_irr=zeros(dpa_max+1,t_count+1);
sig_y_un=zeros(dpa_max+1,t_count+1);
sig_u_un=zeros(dpa_max+1,t_count+1);
eps_u_un=zeros(dpa_max+1,t_count+1);
eps_u_irr=zeros(dpa_max+1,t_count+1);
eps_tot_un=zeros(dpa_max+1,t_count+1);
eps_tot_irr=zeros(dpa_max+1,t_count+1);
del_sig_he=zeros(dpa_max+1,t_count+1);
K_irr=zeros(dpa_max+1,t_count+1);
dpa=zeros(dpa_max+1,1);
T=zeros(t_count+1,1);

for i=1:dpa_max+1
    dpa(i)=(i-1)*del_dpa;
  for j=1:t_count+1
      T(j)=T_min+(j-1)*del_T;
[eps_u, eps_tot, sig_y, sig_u,tangent,~]=IrradiatedProperties (T(j),dpa(i));
% eps_u_irr(i,j)=eps_u;
% eps_tot_irr(i,j)=eps_tot;
% sig_y_irr(i,j)=sig_y;
% sig_u_irr(i,j)=sig_u;
x=he_dpa_ratio*dpa(i);
del_sig_y=(1-exp(-dpa(i)/9.992))^0.5*(3700-7.9*T(j)+0.0039*T(j)^2);
del_sig_he=(-233.5+17.33*x^0.5)*(1-exp(- x/0.02922))^(0.5);
    if del_sig_he<0
        del_sig_he=0;
    end
del_sig=del_sig_y+del_sig_he;
del_T_0=A*del_sig;
if del_T_0<0
    del_T_0=0;
end

T_shift=T_0+del_T_0;
AA=((1-B)*exp(-dpa(i)/25)+B);
K_amp=0.5*((K_max-K_0)*AA);
K_irr(i,j)=K_0*AA+K_amp*(1+tanh((T(j)-(T_0+del_T_0))/T_width));

  end
end

figure('Name','Irradiated Fracture Toughness-1')
surf(T,dpa,K_irr)
ylabel('Dose, dpa','FontName','Times New Roman','FontSize',fsize)
zlabel('Fracture Toughness [MPa.\surd{m}]','FontSize',fsize,'FontName', 'Times New Roman')
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylim([1 100]);
xlim([0 900])
zlim([0 300]);
T_c=T-273;
figure ('Name','Irradiated Fracture Toughness-2')
plot(T_c,K_irr(1,:),'r',T_c,K_irr(5,:),'k',T_c,K_irr(20,:),'b',...
    T_c,K_irr(100,:),'g',LineWidth=2)
ylim([0 300]);
xlim([-200 500])
xlabel('Temperature, K','FontName','Times New Roman','FontSize',fsize)
ylabel('K_{IC} [MPa.\surd{m}]','FontSize',fsize,'FontName', 'Times New Roman')
legend({'unirradiated','5 dpa','20 dpa', '100 dpa'},...
  'Location','northeast','NumColumns',2,'FontSize',msize)

K_un=[-80.3920041986031	38.0175441631918;
-82.0028144482701	61.1000570963890;
-50.1206810042043	66.4550063152066;
-41.6326395256962	63.9964011972940;
-41.7053076572601	78.5715521566864;
-50.2690451061473	96.2126061906327;
-60.7726179559493	102.929217779470;
-40.8898097363762	115.005969167950;
-30.9817118535564	127.724622385245;
-62.0180689885865	152.731110611277;
-50.1004954121033	162.406353270931;
-32.2877196624969	189.672474349880];

K_4dpa=[-10.0583363611721	31.0933093413153;
-10.1461436868119	48.7049500839144;
23.8332727765571	33.4048480024915;
70.6093453524117	51.4611485025174;
120.802838670981	84.0804886066751;
119.261668714062	93.1951485371213];

figure ('Name','Irradiated Fracture Toughness-3')
plot(T_c,K_irr(1,:),'r',T_c,K_irr(4,:),'k',LineWidth=2)
hold on
p1=plot(K_un(:,1),K_un(:,2),'r o');
p1.MarkerFaceColor='r';
p1.MarkerSize=msize;
hold on
p2=plot(K_4dpa(:,1),K_4dpa(:,2),'square');
p2.MarkerFaceColor='g';
p2.MarkerSize=msize;
ylim([0 300]);
xlim([-200 500])
xlabel('Temperature, K','FontName','Times New Roman','FontSize',fsize)
ylabel('K_{IC} [MPa.\surd{m}]','FontSize',fsize,'FontName', 'Times New Roman')
legend({'unirrad fit','3.8 dpa fit','Unirrad Expt', '3.8 dpa Expt'},...
  'Location','northeast','NumColumns',2,'FontSize',msize)