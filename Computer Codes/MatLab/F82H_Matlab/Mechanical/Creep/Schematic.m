%%%%%%%%%%%%%%%%%%  T91  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all; clear all;
global T91s100T873 T91s125T873 T91s150T873 T91s200T873 T91s225T873 T91s250T873 .....
    T91s100T923 T91s100T973 fsize msize

fsize=14;
Temp=873;
i_max=8/0.1;
x=zeros(1,i_max);
y=zeros(1,i_max);
xx=zeros(1,i_max);

%  General model:
%      f_p(sig,T) = A*sig+B*T+C
%      Coefficients (with 95% confidence bounds):
%        A =    -0.02193  (-0.02648, -0.01737)
%        B =    -0.02796  (-0.03541, -0.02051)
%        C =       28.55  (21.5, 35.6)



sig=100;

x_A=@(s,T) 31.2-0.024*s-0.03*T;
y_A=@(s,T) -33.66+11.86*log10(s+1.15*(T-873));
x_B=@(s,T) 20.8-8.5*log10(s+1.15*(T-873));
x_C=@(s,T) x_B(s,T)+0.0006*(s+T-873);

a1=(-4-y_A(sig,Temp))/(-3-x_A(sig,Temp));
b1=-4+3*a1;
a3=(-3-y_A(sig,Temp))/(x_C(sig,Temp)-x_B(sig,Temp));
b3=-3-a3*x_C(sig,Temp);
for i=1:i_max 
 x(i)=-2+(i-1)*0.1;
y_1(i)=a1*x(i)+b1;
y_2(i)=y_A(sig,Temp);
y_3(i)=a3*x(i)+b3;
end

figure(1);
plot (x,y_1,'k',x,y_2,'b',x,y_3,'g',LineWidth=2)
hold on
xline(1.01*x_C(sig,Temp),'r--',LineWidth=2)
txt1 = '\leftarrow Tertiary';
text(0.98*x_C(sig,Temp),-9,txt1,'FontSize',fsize);
hold on
xline(x_A(sig,Temp),'r--',LineWidth=2)
txt2 =  'Secondary';
text(3.2,-6,txt2,'FontSize',fsize,Rotation=90)
hold on
xline(0.98*x_B(sig,Temp),'r--',LineWidth=2)
txt3 =  'Primary';
text(0,-4,txt3,'FontSize',fsize);
txt4='(\tau_0,e_0)';
text(-1.8,-5,txt4,'FontSize',fsize);
txt5='(\tau_p,e_p)';
text(1.8,-10.2,txt5,'FontSize',fsize);
txt6='(\tau_s,e_s)';
text(2.8,-9.5,txt6,'FontSize',fsize);
txt7='(\tau_r,e_r)';
text(4,-3,txt7,'FontSize',fsize);
hold on;
plot(-2, -5, 'ro', 'MarkerSize', 8,'MarkerFaceColor','r');
hold on;
plot(x_A(sig,Temp), y_A(sig,Temp), 'ro', 'MarkerSize', 8,'MarkerFaceColor','r');
hold on;
plot(0.99*x_B(sig,Temp), y_A(sig,Temp), 'ro', 'MarkerSize', 8,'MarkerFaceColor','r');
hold on;
plot(1.01*x_C(sig,Temp), -3, 'ro', 'MarkerSize', 8,'MarkerFaceColor','r');
xlim([-2 6])
ylim([-12 -2])
ylabel('log(\epsilon) [%.s^{-1}]','FontName','Times New Roman','FontSize',fsize)
xlabel('log(time) [hour]','FontName','Times New Roman','FontSize',fsize)
% loglog(xx,y,LineWidth=2)
% loglog(10.^T91s100T873(:,1),10.^T91s100T873(:,2),'r o')
% xlim([10^(-2) 2*10^4])
% ylim([10^(-11) 10^(-2)])
% hold on
% 
% end
% q=100*cumtrapz(y);
% figure( 'Name', 'Creep Strain for T91' );
% plot(xx,q,LineWidth=2)
% % xlim=([0 10]);
% % ylim=([0 30]);
% ylabel('\epsilon [%]','FontName','Times New Roman','FontSize',fsize)
% xlabel('Time [hour]','FontName','Times New Roman','FontSize',fsize)
% 
% hold off