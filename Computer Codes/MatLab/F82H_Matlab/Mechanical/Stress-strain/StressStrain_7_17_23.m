close all; clc; clear all
global eps sig strain stress cntr_max fsize  msize Phi_max  x y 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fsize=14; msize=10;
cntr_max=300;
temp_max=8;
stress=zeros(cntr_max+1,temp_max);
strain=zeros(cntr_max+1,temp_max);
eps=zeros(cntr_max,1);
sig=zeros(cntr_max,1);

Phi_max=0;
del_dpa=1;
Phi=(0:1:Phi_max)*del_dpa;
HardeningFit()

for theta=200:100:600
    T=theta+273;
    PlotHardening(T,Phi)
end
plot(x(:,1),x(:,2),'o','MarkerFaceColor',"r")
legend({'200 ^\circ C','300 ^\circ C','400 ^\circ C','500 ^\circ C','600 ^\circ C','Experimental Data'},...
    'Location','northwest','NumColumns',2,'FontSize',msize)

for j=1:8

    PlotStressStrain(j)
end

HeliumFit()