
fsize=14;
T=300:20:6000;
n=size(T,2)
k=zeros(n,1);
for i=1:n
k(i)=W_k(T(i));
end

figure( 'Name', 'W Thermal Conductivity' );
plot(T,k,'k','LineWidth',2)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('k [W/m.K]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([0 6000])
ylim([0 180])
title('Thermal Conductivity of pure W')
ax = gca;
ax.FontSize = fsize; 
hold off