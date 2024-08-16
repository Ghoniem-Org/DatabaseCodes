function W_data ()
fsize=14;msize=12;

[T1,Plansee,T2,Skoro_SW,T3,Skoro_HR,T4,Drury_creep,T5,Streichen3e_4,...
    T6,Shen_HR,T7,Shen_SW] = readvars('W_Strength_data.xlsx')
TT=[T1(1:31);T4(1:8);T5(1:6);T6(1:5);T2(1:12);T3(1:9)]
sig_y=[Plansee(1:31);Drury_creep(1:8);...
    Streichen3e_4(1:6);Shen_HR(1:5);Skoro_SW(14:25);Skoro_HR(14:22)]
T=linspace(0,3000,100);
% eqn = @(a1,b1,a2,b2,x) a1*exp(b1*x)+a2*exp(b2*x) ; % equation to fit  
% x0 = [1000 -0.1 1000 -1]; 
% fitfun = fittype(eqn);
[fitted_curve,gof] = fit(TT,sig_y,'poly4')
% [fitted_curve,gof] = fit(T_all,sig_y_plansee,fitfun,'StartPoint',x0)

p=plot(T1,Plansee,'square');
p.MarkerSize=msize;
p.MarkerFaceColor='green';
hold on
% p=plot(T2,Skoro_SW,'o');
% p.MarkerSize=msize;
% p.MarkerFaceColor='red';
% hold on
% p=plot(T3,Skoro_HR,'diamond');
% p.MarkerSize=msize;
% p.MarkerFaceColor='magenta';
% hold on
p=plot(T4,Drury_creep,'>');
p.MarkerSize=msize;
p.MarkerFaceColor='blue';
hold on
p=plot(T5,Streichen3e_4,'^');
p.MarkerSize=msize;
p.MarkerFaceColor='red'; 
p.MarkerEdgeColor='k';
hold on
p=plot(T5,Shen_HR,'o');
p.MarkerSize=msize;
% p.MarkerFaceColor='yellow'; 
p.MarkerFaceColor='blue';
hold on
% p=plot(T5,Shen_SW,'square');
% p.MarkerSize=msize;
% % p.MarkerFaceColor='yellow'; 
% p.MarkerEdgeColor='red';
% hold on
p=plot(T2(1:12),Skoro_SW(14:25),'o');
p.MarkerSize=msize;
p.MarkerFaceColor='red';
hold on
p=plot(T3(1:9),Skoro_HR(14:22),'diamond');
p.MarkerSize=msize;
p.MarkerFaceColor='magenta';
hold on


plot(T,fitted_curve(T),'-k','LineWidth',2)

xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('Yield Strength [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
title('Yield Strength of W')
ax = gca;
ax.FontSize = fsize; 
xlim([0 2500])
ylim([0 2000])
legend('Plansee, W-PM-HR-ASTM03',...
    'Drury-1e-6','Streichen-1e-4','Shen-HR','Skoro W-PM-SW-ASTM06-corrected','Skoro W-PM-HR-ASTM03-corrected')
hold off
end