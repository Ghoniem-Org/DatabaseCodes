
fsize=14;
T=300:20:6000;
n=size(T,2);
CTE=zeros(n,1);

C_TE=@(T) 3.873+2.562e-3*T-2.8613e-6*T^2+1.9862e-9*T^3-0.58608e-12*T^4+0.070586e-15*T^5;

for i=1:n
CTE(i)=C_TE(T(i));
end

figure( 'Name', 'W Thermal Conductivity' );
plot(T,CTE,'k','LineWidth',2)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('CTE [ppm]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([300 3500])
ylim([0 12])
title('Linear Thermal Exapansion Coefficient of pure W')
ax = gca;
ax.FontSize = fsize; 
hold off