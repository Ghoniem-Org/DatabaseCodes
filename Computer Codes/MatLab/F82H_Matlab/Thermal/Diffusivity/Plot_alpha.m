
fsize=14;
T=300:20:6000;
n=size(T,2)
k=zeros(n,1);

F82H_alpha=@(T) 1e-6*(0.089188+1.4051e-5* T-5.7859e-8* T^2);

for i=1:n
k(i)=F82H_alpha(T(i));
end

figure( 'Name', 'W Thermal Diffusivity' );
plot(T,k,'k','LineWidth',2)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('\alpha [m^2/s]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([300 1000])
ylim([0 1e-7])
title('Thermal Diffusivity of F82H')
ax = gca;
ax.FontSize = fsize; 
hold off