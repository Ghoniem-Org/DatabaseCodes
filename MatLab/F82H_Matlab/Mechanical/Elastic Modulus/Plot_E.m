
fsize=14;
T=300:20:6000;
n=size(T,2);
E=zeros(n,1);

Young=@(T) 4.0761e11-3.5521e7*T-5.871e3*T.^2;

for i=1:n
E(i)=Young(T(i))*1e-9;
end

figure( 'Name', 'W Thermal Conductivity' );
plot(T,E,'k','LineWidth',2)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('E [GPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([300 3500])
ylim([0 400])
title('Elastic Modulus of W')
ax = gca;
ax.FontSize = fsize; 
hold off