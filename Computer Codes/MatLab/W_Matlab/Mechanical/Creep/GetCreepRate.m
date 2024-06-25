function GetCreepRate(Temp,sig)

global timelog taulog eps_dot_PM eps_dot_AM TimeSteps t_r eps1 eps2 eps3 tau_p e_ss ...
    tau_r tau_t eps_tot eps_0 tau_0 e_r TempSteps del_t

%%%%%%%%%%%%%%%%  Creep rate Calculations %%%%%%%%%%%%%%%%%%%%%%

D_dc_0=1e-8;
D_l_0=5.6e-4;
Q_dc=378.7e3;  %%%%%%%% J/mol
Q_l=585.8e3;  %%%%%%%% J/mol
R=8.314;  %%%%% J/mol.K
Young=@(T) 4.0761e11-3.5521e7*T-5.871e3*T.^2;
f1=@(x,a,b) a.*x.^b;
f2=@(x,a,b) a'.*x+b';

%%%%%%%%%%%%%%%%%%%%%%%% CALCS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tau_0=-5;
gamma=0.95;
D_eff=D_dc_0*exp(-Q_dc./(R*Temp))+D_l_0*exp(-Q_l./(R*Temp));  %%%% m^2/s
E=Young(Temp);
eps_dot_PM=D_eff.*(f1(sig./E,9e26,4.5)+f1(sig./E,8e40,7.5));
eps_dot_AM=D_eff.*(f1(sig./E,9e29,4.5)+f1(sig./E,3e41,7.5));
Z=f1(sig*1e-6,62,-0.2);
t_r=10.^(1000*Z./Temp-11.5);
tau_r=log10(t_r);
tau_p=tau_r-3;
e_ss=log10(eps_dot_PM);
tau_t=gamma*tau_r;
eps_0=-2;
e_r=e_ss+1.5;
timelog=logspace(tau_0,max(tau_r),TimeSteps); % creates a vector of TimeSteps logarithmically spaced values between 10^-2 and 10^6 [hrs]
taulog=log10(timelog);
LinearTime=linspace(1,3.6e3*max(t_r),TimeSteps);
LinearTau=log10(LinearTime/3600);
a1=(eps_0-e_ss)./(tau_0-tau_p);
b1=eps_0-a1.*tau_0;
a3=(e_r-e_ss)./abs((tau_r-tau_t));
b3=e_r-a3.*tau_r;


eps2=e_ss'*ones(size(taulog));
eps1=f2(taulog,a1,b1);
eps3=f2(taulog,a3,b3);
eps_tot=log10(10.^eps1+10.^eps2+10.^eps3);

eps2_lin=e_ss'*ones(size(LinearTau));
eps1_lin=f2(LinearTau,a1,b1);
eps3_lin=f2(LinearTau,a3,b3);
eps_dot=10.^eps1_lin+10.^eps2_lin+10.^eps3_lin;
del_t=max(t_r*3.6e3)/TimeSteps;

for i=1:TempSteps
    for j=1:TimeSteps
q(i,j)=100*del_t*trapz(eps_dot(i,2:j));
    end
end    
GetWCreepPlots(Temp,sig,LinearTime-del_t,q)

end