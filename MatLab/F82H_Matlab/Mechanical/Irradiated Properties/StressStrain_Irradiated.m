close all; clc; clear all
global  fsize  msize Phi_max he_dpa_ratio T dpa eps_u_irr...
    eps_tot_irr sig_y_irr sig_u_irr tangent_irr K_irr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fsize=14; msize=10;
dpa_max=100;
del_dpa=1;
T_max=900;
T_min=600;
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
dpa=zeros(dpa_max+1,1);
T=zeros(t_count+1,1);


% ElongationFit()
% HeliumFit()
%     PlotElongation(T,dpa)

for i=1:dpa_max+1
    dpa(i)=(i-1)*del_dpa;
  for j=1:t_count+1
      T(j)=T_min+(j-1)*del_T;
[eps_u, eps_tot, sig_y, sig_u,tangent,K_C]=IrradiatedProperties (T(j),dpa(i));
eps_u_irr(i,j)=eps_u;
eps_tot_irr(i,j)=eps_tot;
sig_y_irr(i,j)=sig_y;
sig_u_irr(i,j)=sig_u;
tangent_irr(i,j)=tangent;
K_irr(i,j)=K_C;
  end
end

PlotIrradiatedProperties()
theta=600;
temp=theta+273;
figure('Name','Irradiated Stress-Strain')
for dose=20:20:100
    PlotStressStrain_Irradiated(temp,dose)
end