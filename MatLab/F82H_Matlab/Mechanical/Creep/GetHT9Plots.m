function GetHT9Plots()
global HT9s26T873 HT9s39T873 HT9s53T873 HT9s66T873 HT9s105T873 ...
    HT9s227T823 HT9s363T773 fsize msize

t=3600*(0:100:15000)';
t_h=t/3600;
n_size=size(t,1);

e1=zeros(n_size,1);
e2=zeros(n_size,1);
e3=zeros(n_size,1);
e4=zeros(n_size,1);

P_0=@(T) 0.5-2600/T;
P_1=@(T) 1+50/T;
e_p=@(s,T) 10^(P_0(T)+P_1(T)*log10(s));
m=2e-6;s0=@(s) 0.025*s+0.0055*s^2;
S_l=@(T) -5.7-5562.28/T;
e_s=@(s,T) 10^(S_l(T)+2.5*log10(s-s0(s)));
eps=@(s,T,t) e_p(s,T)*(1-exp(-m*t))+e_s(s,T)*t;
t_R=10^7*3600;

for i=1:n_size
e1(i)=eps(26,873,t(i));
e2(i)=eps(39,873,t(i));
e3(i)=eps(53,873,t(i));
e4(i)=eps(66/(1-(t(i)/t_R)^(1/3.5)),873,t(i));
end


figure( 'Name', 'HT9 Creep Strain - Low Stress' );
plot(t_h,e1,'r',t_h,e2,'k',t_h,e3,'c',t_h,e4,'g','LineWidth',2);
hold on
p1=plot(HT9s26T873(:,1),HT9s26T873(:,2),'o');
p1.MarkerSize=msize;
p1.MarkerFaceColor='red';
hold on
p2=plot(HT9s39T873(:,1),HT9s39T873(:,2),'^');
p2.MarkerSize=msize;
p2.MarkerFaceColor='k';
p3=plot(HT9s53T873(:,1),HT9s53T873(:,2),'^');
p3.MarkerSize=msize;
p3.MarkerFaceColor='c';
p4=plot(HT9s66T873(:,1),HT9s66T873(:,2),'^');
p4.MarkerSize=msize;
p4.MarkerFaceColor='g';
xlabel('Time [hour]','FontName','Times New Roman','FontSize',fsize)
ylabel('Strain (\epsilon)','FontSize',fsize,'FontName', 'Times New Roman')
% xlim([0 1000])
% ylim([0 0.5])
legend({'s26T873','s39T873','s53T873','s66T873'},...
    'Location','northwest','NumColumns',1,FontSize=msize)
title('Thermal Creep Strain of HT9')
ax = gca;
ax.FontSize = fsize; 


P_0=@(T) 0.5-2600/T;
P_1=@(T) 1+50/T;
e_p=@(s,T) 10^(P_0(T)+P_1(T)*log10(s));
m=2e-6;s0=@(s) 0.025*s+0.006*s^2;
S_l=@(T) -5.7-5562.28/T;
e_s=@(s,T) 10^(S_l(T)+2.2*log10(s-s0(s)));
eps=@(s,T,t) e_p(s,T)*(1-exp(-m*t))+e_s(s,T)*t;

t_105=13000*3600;
t_227=10000*3600;
t_363=5000*3600;
e_limit=15;
t_h=(0:100:10000)';
t=t_h*3600;
n_size=size(t,1);

for i=1:n_size
s1=105/(1-(t(i)/t_105));
s2=227/(1-(t(i)/t_227));
s3=363/(1-(t(i)/t_363));

e5(i)=eps(s1,873,t(i));
e6(i)=eps(s2,873,t(i));
e7(i)=eps(s3,873,t(i));
% e5(i)=eps(105,873,t(i));
% e6(i)=eps(227,873,t(i));
% e7(i)=eps(363,873,t(i));
    if e5(i)>e_limit || e5(i)<0
        e5(i)=e_limit
    elseif e6(i)>e_limit|| e6(i)<0
        e6(i)=e_limit;
    elseif e7(i)>e_limit|| e7(i)<0
        e7(i)=e_limit;
    end
end


figure( 'Name', 'HT9 Creep Strain - High Stress' );
plot(t_h,e5,'r',t_h,e6,'g',t_h,e7,'c','LineWidth',2);
hold on
p7=plot(HT9s105T873(:,1),HT9s105T873(:,2),'o');
p7.MarkerSize=msize;
p7.MarkerFaceColor='red';
hold on
p5=plot(HT9s227T823(:,1),HT9s227T823(:,2),'^');
p5.MarkerSize=msize;
p5.MarkerFaceColor='green';
p6=plot(HT9s363T773(:,1),HT9s363T773(:,2),'^');
p6.MarkerSize=msize;
p6.MarkerFaceColor='cyan';
xlabel('Time [hour]','FontName','Times New Roman','FontSize',fsize)
ylabel('Strain (\epsilon)','FontSize',fsize,'FontName', 'Times New Roman')
xlim([0 10000])
ylim([0 20])
legend({'s105T873','s227T823','s363T773'},...
    'Location','northwest','NumColumns',1,FontSize=msize)
title('Thermal Creep Strain of HT9')
ax = gca;
ax.FontSize = fsize; 
hold off
end
