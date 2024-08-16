function GetT91Fits()
global T91s100T873 T91s125T873 T91s150T873 T91s200T873 T91s225T873 T91s250T873 .....
    T91s100T923 T91s100T973 

global fsize msize

%  LMP = T(C + log t),
sig=[100;125;150;200;225;250;100;100];
T=[873;873;873;873;873;873;923;973];
Lt_p=[1.714713054;1.708686286;0.968665218;-0.378449948;-0.595778511;...
    -1.509406209;0.363601722;-0.75605269];
Lt_r=[3.708889059;2.532174709;2.459826983;1.567913307;0.873475186;...
0.358731906;2.764764635;1.015433183];
Lt_s=[3.60854775;2.426026294;2.411231973;1.386335072;0.679704806;...
0.170876048;2.605193682;0.852911543];
Le_s=[-9.723438583;-8.712557502;-8.022540352;-6.297816438;-5.566678037;...
-5.127286285;-7.6737544;-5.795140375];
Le_r=[-8.795866656;-7.543276385;-6.314655893;-4.642458705;-4.17086771;...
-3.632034089;-4.806632623;-4.143465902];

f_p_type = fittype('A_p*sig+B_p*T+C_p','dependent',{'Lt_p'},'independent',{'sig','T'},...
    'coefficients',{'A_p','B_p','C_p'});
f_p=fit([sig,T],Lt_p,f_p_type)
figure( 'Name', 'Log(t_p) Fit for T91' );
plot(f_p,[sig,T],Lt_p)

hold off
f_r_type = fittype('A_r*sig+B_r*T+C_r','dependent',{'L_r'},'independent',{'sig','T'},...
    'coefficients',{'A_r','B_r','C_r'});
f_r=fit([sig,T],Lt_r,f_r_type)
figure( 'Name', 'Log(t_r) Fit for T91' );
plot(f_r,[sig,T],Lt_r)

hold off
f_s_type = fittype('A_s*sig+B_s*T+C_s','dependent',{'L_s'},'independent',{'sig','T'},...
    'coefficients',{'A_s','B_s','C_s'});
f_s=fit([sig,T],Lt_s,f_s_type)
figure( 'Name', 'Log(t_s) Fit for T91' );
plot(f_s,[sig,T],Lt_s)

hold off
f_er_type = fittype('a*sig+b*T+c','dependent',{'Le_r'},'independent',{'sig','T'},...
    'coefficients',{'a','b','c'});
f_er=fit([sig,T],Le_r,f_er_type)
figure( 'Name', 'Log(e_r) Fit for T91' );
plot(f_er,[sig,T],Le_r)

hold off
f_e_type = fittype('A_e+B_e*log10(sig)+C_e*T','dependent',{'Le'},'independent',{'sig','T'},...
    'coefficients',{'A_e','B_e','C_e'});
f_e=fit([sig,T],Le_s,f_e_type)
figure( 'Name', '\epsilon Fit for T91' );
plot(f_e,[sig,T],Le_s)
end