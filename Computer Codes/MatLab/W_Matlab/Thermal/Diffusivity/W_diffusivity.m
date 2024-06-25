clc, clear all
fsize=16;msize=12;
FolderName = 'C:\Users\Owner\My Drive\Research\Material Databases\Tungsten\Matlab\Thermal\Diffusivity';
File1= fullfile(FolderName, 'Diffusivity_Fujitsuka');
File2= fullfile(FolderName, 'Diffusivity_Tanabe');
File3= fullfile(FolderName, 'Diffusivity_Touloukian');
File4= fullfile(FolderName, 'Diffusivity_SingleCrystal');

load(File1);load(File2);load(File3);load(File4);

t=[Diffusivity_Fujitsuka(:,1);Diffusivity_Tanabe(:,1);...
    Diffusivity_Touloukian(:,1);Diffusivity_SingleCrystal(:,1)];
diffusivity=[Diffusivity_Fujitsuka(:,2);Diffusivity_Tanabe(:,2);...
        Diffusivity_Touloukian(:,2);Diffusivity_SingleCrystal(:,2)];

T=linspace(0,1200,100);
eqn = @(a,b,c,x) a*exp(b*x)+c ; % equation to fit  
x0 = [80 0 30]; 
fitfun = fittype(eqn);
% [fitted_curve,gof] = fit(t,diffusivity,'poly2')
[fitted_curve,gof] = fit(t,diffusivity,fitfun,'StartPoint',x0)

figure( 'Name', 'W Diffusivity' );
p=plot(Diffusivity_Fujitsuka(:,1),Diffusivity_Fujitsuka(:,2),'o');
p.MarkerSize=msize;
p.MarkerFaceColor='red';
hold on
p=plot(Diffusivity_Tanabe(:,1),Diffusivity_Tanabe(:,2),'square');
p.MarkerSize=msize;
p.MarkerFaceColor='blue';
hold on
p=plot(Diffusivity_Touloukian(:,1),Diffusivity_Touloukian(:,2),'square');
p.MarkerSize=msize;
p.MarkerFaceColor='black';
hold on
p=plot(Diffusivity_SingleCrystal(:,1),Diffusivity_SingleCrystal(:,2),'square');
p.MarkerSize=msize;
p.MarkerFaceColor='green';
hold on

plot(T,fitted_curve(T),'-k','LineWidth',2)

xlabel('Temperature [C]','FontName','Times New Roman','FontSize',fsize)
ylabel('Thermal Diffusivity [mm^2/s]','FontSize',fsize,'FontName', 'Times New Roman')
title('Thermal diffusivity of pure W')
ax = gca;
ax.FontSize = fsize; 
xlim([0 1200])
ylim([0 80])
legend('Fujitsuka','Tanabe','Touloukian','Single Crystal')
hold off