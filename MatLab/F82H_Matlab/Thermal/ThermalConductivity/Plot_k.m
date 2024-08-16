
fsize=14;
T=300:20:6000;
n=size(T,2)
k=zeros(n,1);

F82H_k=@(T) 28.384-0.011777*T-1.0632e-6*T^2-8.2935e-9*T^3;

for i=1:n
k(i)=F82H_k(T(i));
end

figure( 'Name', 'W Thermal Conductivity' );
plot(T,k,'k','LineWidth',2)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('k [W/m.K]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([300 1000])
ylim([0 50])
title('Thermal Conductivity of F82H')
ax = gca;
ax.FontSize = fsize; 
hold off