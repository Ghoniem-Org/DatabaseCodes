
close all; clear all;
fsize=14;
T=300:10:1000;
n=size(T,2);
nu=zeros(n,1);

Poisson=@(T) 0.28247+6.1902e-6*(T-298)+3.162e-9*T.^2;

for i=1:n
nu(i)=Poisson(T(i));
end

figure( 'Name', 'W Poisson Ratio' );
plot(T,nu,'k','LineWidth',2)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('Poisson Ratio (\nu)','FontSize',fsize,'FontName', 'Times New Roman')
xlim([300 1000])
ylim([0 0.5])
title('Poisson Ration of F82H')
ax = gca;
ax.FontSize = fsize; 
hold off