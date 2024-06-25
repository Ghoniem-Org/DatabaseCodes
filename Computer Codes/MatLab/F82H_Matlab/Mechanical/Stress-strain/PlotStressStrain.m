function PlotStressStrain(j)
global eps sig strain stress cntr_max fsize msize 

 a1=0.7; a2=0.1;
 T=j*100;
    [E,nu,sig_y,sig_u,e_u,e_tot]=F82H_Mechanical(T);
   
sig_f=(a1*sig_y+a2*sig_u);
    % toughness=1e6*(0.5*0.002.*sig_y+(e_u-0.002).*(sig_u-sig_y)/2+(e_tot-e_u).*(sig_u-sig_f)/2);
    eps_y=sig_y/(E*1e-6);
        for i=1:cntr_max
            eps(i)=i*eps_y/2;
            if eps(i)<=eps_y
                sig(i)=1e-6*E*eps(i);
            elseif (eps(i)>eps_y) && (eps(i)<=e_u)
                sig(i)=sig_y+(eps(i)-eps_y)*((sig_u-sig_y)/(e_u-eps_y));
            elseif (eps(i)>e_u) && (eps(i)<=e_tot)
                sig(i)=sig_u+(eps(i)-e_u)*((sig_f-sig_u)/(e_tot-e_u));
            end
        end 
  strain(:,j)=100*[0;eps];
  stress(:,j)=[0;sig];
 figure(3);
    plot(strain(:,1),stress(:,1),'r',strain(:,2),stress(:,2),'k',...
        strain(:,3),stress(:,3),'b',strain(:,4),stress(:,4),'c',...
        strain(:,5),stress(:,5),'g',strain(:,6),stress(:,6),'m',...
        strain(:,7),stress(:,7),'r:',strain(:,8),stress(:,8),'k--',...
        LineWidth=2)
    legend({'100 [K]','200 [K]','300 [K]','400 [K]','500 [K]',...
        '600 [K]','700 [K]','800 [K]'},...
    'Location','northeast','NumColumns',2,FontSize=msize)
    xlabel('strain [%]','FontName','Times New Roman','FontSize',fsize)
ylabel('Stress [MPa]','FontSize',fsize,'FontName', 'Times New Roman')
xlim([0 30])
ylim([0 1200])
title('Stress-strain diagrams of F82H')
ax = gca;
ax.FontSize = fsize; 
hold on
end