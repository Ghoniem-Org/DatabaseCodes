function W_Mechanical(T)
global s_u_W s_u_KWRe  e_u_W e_u_KWRe e_t_W e_t_KWRe p_sig_u_W ...
    p_sig_u_KWRe RA_W_f RA_KWRe_f plansee_y plansee_u



s_u_W=0;s_u_KWRe=0;
n=5;

%%%%%%%%%%%%%%  FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ductility=@(T,T1,T2,TW,K_0,K_max,a,b) ...
a*T.*exp(-b*T).*((1+tanh((T-T1)/TW))/2)+((K_max+b*T-K_0)).*((1+tanh((T-T2)/TW))/2);
RA=@(T,T_0,TW,RA_0,RA_max,a) (RA_max+a*T-RA_0).*((1+tanh((T-T_0)/TW))/2);
ultimate_2_yield=@(T,T_0,TW,R_max,a)...
    (0.2+R_max.*exp(-a*T)).*((1+tanh((T-T_0)/TW))/2)+1;
Yield=@(T,a0,a1,a2,T1,T2,TW) a0+a1*exp(-T/T1)+a2*(1-((1+tanh((T-T2)/TW))/2));

%%%% Polynomial fits  %%%%%%%%%%%%%%%%
for i=1:n
    s_u_W=s_u_W+p_sig_u_W(i)*T^(n-i);
    s_u_KWRe=s_u_KWRe+p_sig_u_KWRe(i)*T^(n-i);
end
e_u_W=ductility(T,500,1450,50,4,25,0.06,3.5e-3);
e_u_KWRe=ductility(T,300,1700,200,6,20,0.12,3.5e-3);
e_t_W=ductility(T,500,1450,50,4,60,0.25,3.2e-3);
e_t_KWRe=ductility(T,400,1500,200,4,40,0.25,3e-3);
RA_W_f=RA(T,525,85,0.5,60,0.018);
RA_KWRe_f=RA(T,550,200,5,70,0.01);
u_2_y_ratio=ultimate_2_yield(T,650,150,3.5,0.0055);
plansee_y=Yield(T,35,3200,350,180,1700,200); 
plansee_u=plansee_y.*u_2_y_ratio;
end