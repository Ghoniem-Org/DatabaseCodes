
fsize=14;
T=300:10:1000;
n=size(T,2);
res=zeros(n,1);

resist=[0.502e-6 0.722e-6 0.886e-6]';
theta=[273 573 773]';

[fitted_curve,gof] = fit(theta,resist,'poly2');

F82H_resist=@(T) 3.289e-07+5.867e-10*T-1.733e-13*T^2;

for i=1:n
res(i)=F82H_resist(T(i));
end

figure( 'Name', 'F82H Electric Resistivity' );
plot(T,res,'k','LineWidth',2)
xlabel('Temperature [K]','FontName','Times New Roman','FontSize',fsize)
ylabel('Resistivity [\Omega .m]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([300 1000])
ylim([0 8e-7])
title('Electrical Resistivity of F82H')
ax = gca;
ax.FontSize = fsize; 
hold off