
fsize=14;
T=300:10:1200;
n=size(T,2)
C_p=zeros(n,1);
SpecificHeat=@(T) 1390.2-7.8498*T+0.022969*T^2-2.7446e-5*T^3+1.1932e-8*T^4;

for i=1:n
C_p(i)=SpecificHeat(T(i));
end

figure( 'Name', 'F82H specific heat' );
plot(T,C_p,'k','LineWidth',2)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('C_p [J/Kg.K]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([300 1000])
ylim([0 1000])
title('Specific Heat of F82H')
ax = gca;
ax.FontSize = fsize; 
hold off