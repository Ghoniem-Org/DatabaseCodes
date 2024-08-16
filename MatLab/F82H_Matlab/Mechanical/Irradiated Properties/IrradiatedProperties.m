function [eps_u_irr, eps_tot_irr, sig_y_irr, sig_u_irr,tangent_irr,K_C]=IrradiatedProperties (T,d)

global he_dpa_ratio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=he_dpa_ratio*d;
eps_u_irr=1e-2*(0.1482 +0.8518*exp(- d/3.906))*(7.393-0.002602*T-1.649e-5*T^2 +1.282e-8*T^3);
eps_tot_irr=1e-2*(1.066-0.004282*d-0.0001004*d^2)*(62.09-0.2306*T+0.0003032*T^2-1.082e-7*T^3);
if eps_tot_irr<0.01
        eps_tot_irr=0.01;
end
sig_y_un=(960.9-2.716*T+0.00496*T^2-3.112e-6*T^3);
sig_u_un=(1065-2.468*T+0.004087*T^2-2.575e-6*T^3);
eps_u_un=(7.393-0.002602*T-1.649e-5*T^2+1.282e-8*T^3);
del_sig_y=(1-exp(-d/9.992))^0.5*(3700-7.9*T+0.0039*T^2);
del_sig_he=(-233.5+17.33*x^0.5)*(1-exp(- x/0.02922))^(0.5);
    if del_sig_he<0
        del_sig_he=0;
    end
C=1e-2*eps_u_un./ (1-sig_y_un./sig_u_un);
sig_y_irr=sig_y_un+del_sig_y+del_sig_he;
sig_u_irr=sig_y_irr./(1-1e-2*eps_u_un./C);
tangent_irr=1e-1*(sig_u_irr-sig_y_irr)./(eps_u_irr-0.001);

%%%%%%%%%%%%%%%  FRACTURE TOUGHNESS  %%%%%%%%%%%%%%%%%%%

K_0=50;
K_max=200;
T_0=-100+273;
dT=200;
A=0.01;
B=0.2*(del_sig_y+del_sig_he);
if B<0
    B=0;
end
amp=0.5*(K_0+(K_max-K_0)*exp(-d/10));
K_C=K_0+amp*(1+tanh((T-T_0*(1+B))/dT));



end