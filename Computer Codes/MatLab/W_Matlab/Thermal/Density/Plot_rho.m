
fsize=14;
T=300:20:6000;
n=size(T,2)
rho=zeros(n,1);
for i=1:n
rho(i)=W_rho(T(i));
end

figure( 'Name', 'W Thermal Conductivity' );
plot(T,rho,'k','LineWidth',2)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('\rho [Kg/m^3]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([0 6000])
ylim([0 25e3])
title('Density of pure W')
ax = gca;
ax.FontSize = fsize; 
hold off