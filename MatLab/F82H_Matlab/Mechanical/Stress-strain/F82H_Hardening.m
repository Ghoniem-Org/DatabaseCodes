function Del_sig=F82H_Hardening(T,dpa)
global Phi_max
%%%%%%%%%%%%%%%%%%%%  DATA  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

C_He=500;
D_0=1e-5;
U_a=0.93; 
h=5;
m=7;
k_B=8.617333e-5;
D=D_0*exp(-U_a/(k_B*T));
D_300=D_0*exp(-U_a/(k_B*300));
D_rel=D/D_300;
appm=h*dpa;
A_He=C_He*(D_rel)^(-1/m);

a_h =-233.5;
b_h=17.33;
c_h=0.02922;
b_h=(A_He/43.2)*b_h;
a =3700;
b =-7.9;
c = 9.992;
d = 0.0039;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  CALCULATIONS %%%%%%%%%%%%%%%%%%%%%%%%

% pre=(a+b*T+d*T^2)*(1-exp(-T/800));
pre=(a+b*T+d*T^2);
Del_sig_d= pre*(1-exp(- dpa/(c))).^(0.5);
Del_sig_He=(a_h+b_h*appm.^0.5).*(1-exp(- appm/(c_h))).^(0.5);
for i=1:Phi_max+1
    if Del_sig_He(i)<0
        Del_sig_He(i)=0;
    end
Del_sig=Del_sig_d+Del_sig_He;
end