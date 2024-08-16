function PlotStressStrain()
global fsize msize 
global   s_u_W s_u_KWRe s_y_W s_y_KWRe e_u_W e_t_W s_f_W s_f_KWRe ...
    RA_W_f RA_KWRe_f plansee_u plansee_y
global xx yy x_ro y_ro

ultimate_2_yield=@(T,T_0,TW,R_max,a) (0.2+R_max.*exp(-a*T)).*((1+tanh((T-T_0)/TW))/2)+1;

cntr=-1;
for T=[100 150 200 250 300 350 400 450 500 ]+273
    cntr=cntr+1;
    shift=cntr*20;
    W_Mechanical(T);
    R_1=ultimate_2_yield(T,650,100,3.5,0.0055);
    n=(log(R_1)).^0.754/3.93;
    R_2=0.85+0.15*exp(-T/1000);
    s_u_W=plansee_u;
    s_y_W=plansee_y;
    s_f_W=R_2*s_u_W;
    s_y_KWRe=s_u_KWRe./R_1;
    s_f_KWRe=R_2*s_u_KWRe;
    E=4.0761e11-3.5521e7*T-5.871e3*T.^2;
    del_sig=10;
 
    sigma_tilde=0:del_sig:1000;
    sig_size=size(sigma_tilde,2);
    x_ro=zeros(1,sig_size);
    y_ro=zeros(1,sig_size);

    eps_tilde_e=1e8*sigma_tilde./E;
    H=s_y_W/(0.002).^n;
    eps_tilde_p=1e2*(sigma_tilde./H).^(1./n);
    eps_tilde=eps_tilde_e+eps_tilde_p;
%     e_max=100*log(1+e_t_W/100);
    e_max=100*log(1./(1-RA_W_f/100))/5;

%%%%%% Approximate Stress-Strain Diagrams  %%%%%%%%%%%%%%%%%%%%%%%%
figure(20);
x=[0 0.2 e_u_W e_t_W 1.05*e_t_W]+shift;
y=[0 s_y_W s_u_W s_f_W 0];
plot(x,y,LineWidth=2)
hold on
 legend({'25^\circ C','150^\circ C','200^\circ C','250^\circ C','300^\circ C',...
        '350^\circ C','400^\circ C','450^\circ C','500^\circ C'},...
    'Location','northeast','NumColumns',3,FontSize=msize)
xlabel('strain [%]','FontName','Times New Roman','FontSize',fsize)
ylabel('Stress [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([0 200])
ylim([0 1000])
xticks(0:20:200)
title('Approximate \sigma-\epsilon for W along rolling direction -')
ax = gca;
ax.FontSize = msize; 
hold on


%%%%%% Romberg-Osgood True Stress-Strain Diagrams  %%%%%%%%%%%%%%%%%%%%%%%%
figure(30);
xx=eps_tilde;
yy=sigma_tilde;

for i=1:sig_size
    x_ro(1,i)=xx(1,i);
     y_ro(1,i)=yy(1,i);
    if x_ro(1,i)>e_max
        x_ro(1,i)=e_max;
        y_ro(1,i)=0;
    end
end

plot(x_ro+shift,y_ro,LineWidth=2)
hold on
 legend({'25^\circ C','150^\circ C','200^\circ C','250^\circ C','300^\circ C',...
        '350^\circ C','400^\circ C','450^\circ C','500^\circ C'},...
    'Location','northeast','NumColumns',3,FontSize=msize)
    xlabel('strain [%]','FontName','Times New Roman','FontSize',fsize)
ylabel('Stress [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([0 200])
ylim([0 1000])
xticks(0:20:200)
title('True  \sigma-\epsilon for W along rolling direction')
ax = gca;
ax.FontSize = msize; 
hold on

figure(40);

e_ro=100*(exp(x_ro/100)-1);
sig_ro=exp(-x_ro/100).*y_ro;

plot(e_ro+shift,sig_ro,LineWidth=2)
hold on
% text(2,800,'RT',Rotation=45);
% text(25,775,'150^\circ C',Rotation=45)
% text(45,750,'200^\circ C',Rotation=45)
% text(65,700,'250^\circ C',Rotation=45)
% text(85,650,'300^\circ C',Rotation=45)
% text(105,600,'350^\circ C',Rotation=45)
% text(130,525,'400^\circ C',Rotation=45)
% text(150,475,'450^\circ C',Rotation=45)
% text(175,425,'500^\circ C',Rotation=45)
legend({'25^\circ C','150^\circ C','200^\circ C','250^\circ C','300^\circ C',...
        '350^\circ C','400^\circ C','450^\circ C','500^\circ C'},...
    'Location','northeast','NumColumns',3,FontSize=msize)

xlabel('strain [%]','FontName','Times New Roman','FontSize',fsize)
ylabel('Stress [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([0 200])
ylim([0 900])
xticks(0:20:200)
title('Engineering  \sigma-\epsilon for W along rolling direction')
ax = gca;
ax.FontSize = msize; 
hold on

end


end