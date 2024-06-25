
fsize=14;
T=300:20:6000;
n=size(T,2);
CTE=zeros(n,1);

C_TE=@(T) 9.0955+4.6477e-3*T-1.2141e-6*T^2;

for i=1:n
CTE(i)=C_TE(T(i));
end

figure( 'Name', 'W Thermal Conductivity' );
plot(T,CTE,'k','LineWidth',2)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('CTE [ppm]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([300 1000])
ylim([0 15])
title('Linear Thermal Exapansion Coefficient of F82H')
ax = gca;
ax.FontSize = fsize; 
hold off