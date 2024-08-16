close all; clear all;
fsize=14;msize=12;
T=300:10:1000;
n=size(T,2);
s1=zeros(n,1);
s2=zeros(n,1);

Polished=[428.823529411765	0.119205789571349;
524.705882352941	0.130441269252180;
625.882352941177	0.142931898311375;
725.882352941176	0.155424011876044;
822.352941176471	0.174860642048617];

Rolled=[472.352941176471	0.181611430692151;
572.941176470588	0.214922991278530;
674.117647058824	0.244448320653182;
772.352941176471	0.273977361291520;
874.117647058824	0.302240118760438];

%%%% Source : Infrared emissivity of re duce d-activation Eurofer 97 for fusion reactor applications
%%%  T. Echániz a , ∗, I. González, JNM 549 (2021) 152907 %%%%%%%%


rho1=@(T) 100*(4.2757e-07+7.6271e-10*T-2.2529e-13*T^2);
rho2=@(T) 100*(7e-07+3.15e-9*T-2.8e-14*T^2);
sigma1=@(T) 0.766*(rho1(T)*T )^0.5-(0.309-0.0889*log (rho1(T)*T ))*(rho1(T)*T )-0.0175*(rho1(T)*T )^1.5;
sigma2=@(T) 0.766*(rho2(T)*T )^0.5-(0.309-0.0889*log (rho2(T)*T ))*(rho2(T)*T )-0.0175*(rho2(T)*T )^1.5;

for i=1:n
s1(i)=sigma1(T(i));
s2(i)=sigma2(T(i));
end

figure( 'Name', 'F82H Emissivity' );
plot(T,s1,T,s2,'k','LineWidth',2);
hold on
p1=plot(Polished(:,1),Polished(:,2),'o');
p1.MarkerSize=msize;
p1.MarkerFaceColor='red';
hold on
p2=plot(Rolled(:,1),Rolled(:,2),'^');
p2.MarkerSize=msize;
p2.MarkerFaceColor='green';
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('Emissivity (\sigma)','FontSize',fsize,'FontName', 'Times New Roman')
xlim([300 1000])
% ylim([0 0.5])
legend({'Polished fit','Rolled fit','Polished data','Rolled data'},...
    'Location','northwest','NumColumns',1,FontSize=msize)
title('Thermal Emissivity of F82H')
ax = gca;
ax.FontSize = fsize; 
