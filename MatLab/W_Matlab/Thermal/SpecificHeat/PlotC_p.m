
fsize=14;
T=300:20:6000;
n=size(T,2)
C_p=zeros(n,1);
for i=1:n
C_p(i)=W_SpecificHeat(T(i));
end

figure( 'Name', 'W specific heat' );
plot(T,C_p,'k','LineWidth',2)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('C_p [J/Kg.K]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([300 6000])
ylim([0 300])
title('Specific Heat of pure W')
ax = gca;
ax.FontSize = fsize; 
hold off