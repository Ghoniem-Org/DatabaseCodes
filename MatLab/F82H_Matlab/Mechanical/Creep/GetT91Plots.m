function GetT91Plots ()
%%%%%%%%%%%%%%%%%%  T91  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global T91s100T873 T91s125T873 T91s150T873 T91s200T873 T91s225T873 T91s250T873 .....
    T91s100T923 T91s100T973 fsize msize
global F82Hs78T873 F82Hs60T973
i_max=1000;
t_max=150;
del_x=(log10(t_max)-(-2))/i_max;
del_t=(t_max)/i_max;
time=zeros(1,i_max);
epsdot=zeros(1,i_max);
x=zeros(1,i_max);
q=zeros(1,i_max);
%  General model:
%      f_p(sig,T) = A_p*sig+B_p*T+C_p
%      Coefficients (with 95% confidence bounds):
%        A_p =    -0.02193  (-0.02648, -0.01737)
%        B_p =    -0.02796  (-0.03541, -0.02051)
%        C_p =       28.55  (21.5, 35.6)
A_p=-0.02193;
B_p=-0.02796;
C_p=28.7;

% General model:
%      f_r(sig,T) = A_r*sig+B_r*T+C_r
%      Coefficients (with 95% confidence bounds):
%        A_r =    -0.02121  (-0.02698, -0.01543)
%        B_r =    -0.02329  (-0.03275, -0.01384)
%        C_r =          26  (17.05, 34.94)

% A_r =    -0.02121 ;
% B_r =    -0.02329 ;

A_r =    -0.021 ;
B_r =    -0.0231 ;
% C_r =          26.1;
C_r =          26.25;

%  General model:
%      f_e(s,T) = A_e+B_e*log10(s)+C_e*T
%      Coefficients (with 95% confidence bounds):
%        A_e =      -68.97  (-74.86, -63.09)
%        B_e =       11.75  (10.68, 12.81)
%        C_e =     0.04084  (0.03608, 0.04561)

% A_e =      -68.97;
A_e=-67.5;
B_e =       11.75;
C_e =     0.04084;

% gamma_0=1.04;
  gamma_0=1.15;
gamma_1=4e-3;
gamma_2=2e-3;
a_0=-4.2;
b_0=3.5e-3;
c_0=1e-6;


Lt_p=@(s,T) A_p*s+B_p*T+C_p;
Le=@(s,T) A_e+B_e*log10(s)+C_e*T;
Lt_r=@(s,T) A_r*s+B_r*T+C_r;
gamma=@(s,T) gamma_0+gamma_1*(T-873)+gamma_2*(s-100);
Lt_s=@(s,T) Lt_r(s,T)/gamma(s,T);
Le_r=@(s,T) -Lt_r(s,T)*1.6;
Le_0=@(s,T) a_0+b_0*(s-100)+c_0*(T-873);

sig=60;
% Temp=873;
for Temp=[973]
% for sig=[95,100,110,120]


t_r=10^Lt_r(sig,Temp)
a1=(Le_0(sig,Temp)-Le(sig,Temp))/(-3-Lt_p(sig,Temp));
b1=Le_0(sig,Temp)+3*a1;
a3=(Le_r(sig,Temp)-Le(sig,Temp))/(Lt_r(sig,Temp)-Lt_s(sig,Temp));
b3=Le_r(sig,Temp)-a3*Lt_r(sig,Temp);

for i=1:i_max 
 x(i)=-2+(i-1)*del_x;
 time(i)=10^x(i);

y_I=a1*x(i)+b1;
y_II=Le(sig,Temp);
y_III=a3*x(i)+b3;
epsdot(i)=(10^y_I+10^y_II+10^y_III);

        if  x(i)>Lt_r(sig,Temp)
            epsdot(i)=0;
        end
end
% figure(1);
% loglog(time,epsdot,LineWidth=2)
% hold on


% loglog(10.^T91s100T923(:,1),10.^T91s100T923(:,2),'k ^')
% hold on
% loglog(10.^T91s100T973(:,1),10.^T91s100T973(:,2),'b s')
% hold on
% loglog(10.^T91s100T873(:,1),10.^T91s100T873(:,2),'r o')
% hold on

% loglog(10.^T91s125T873(:,1),10.^T91s125T873(:,2),'g *')
% hold on
% loglog(10.^T91s150T873(:,1),10.^T91s150T873(:,2),'k ^')
% hold on
% loglog(10.^T91s200T873(:,1),10.^T91s200T873(:,2),'b >')
% hold on
% loglog(10.^T91s225T873(:,1),10.^T91s225T873(:,2),'y <')
% hold on
% loglog(10.^T91s250T873(:,1),10.^T91s250T873(:,2),'r *')
% hold on
% 
% xlim([10^(-2) 2*10^4])
% ylim([10^(-12) 10^(-2)])
% hold on
% ylabel('Creep rate [s^{-1}]','FontName','Times New Roman','FontSize',fsize)
% xlabel('Time [hour]','FontName','Times New Roman','FontSize',fsize)
% legend({'100 MPa fit','150 MPa fit','200 MPa fit','225 MPa fit','250 MPa fit','100 MPa data',...
%     '150 MPa data','200 MPa data','225 MPa data','250 MPa data',},...
%    'Location','southwest','NumColumns',2,'FontSize',msize)
% legend({'873 K fit','923 K fit','973 K fit',...
%     '873 K data','923 K data','973 K data'},...
%    'Location','southwest','NumColumns',2,'FontSize',msize)


for i=1:i_max 
time(i)=i*del_t;
x(i)=log10(time(i));
y_I=a1*x(i)+b1;
y_II=Le(sig,Temp);
y_III=a3*x(i)+b3;
epsdot(i)=(10^y_I+10^y_II+10^y_III);

        if epsdot(i)>10^(Le_r(sig,Temp)) && x(i)>Lt_s(sig,Temp)
            epsdot(i)=10^(Le_r(sig,Temp));
        end
                q(i)=100*del_t*trapz(3600*epsdot(1,1:i));
                if q(i)>32
                    q(i)=32;
                end

end
ReadF82HData()
% figure( 'Name', 'Creep Strain for T91' );
figure( 2 );
plot(time,q,LineWidth=2)
% xlim=([0 10]);
ylim([0 30])
ylabel('Creep Strain (\epsilon) [%]','FontName','Times New Roman','FontSize',fsize)
xlabel('Time [hour]','FontName','Times New Roman','FontSize',fsize)
legend({'700 ^{\circ}C - 60 MPa','625 ^{\circ}C','650 ^{\circ}C'},...
 'Location','northwest','NumColumns',1,'FontSize',msize)
hold on
% p1=plot(F82Hs78T873(:,1),F82Hs78T873(:,2),'r square');
p1.MarkerFaceColor='r';
p1.MarkerSize=msize;
p2=plot(F82Hs60T973(:,1),F82Hs60T973(:,2),'r o');
p2.MarkerFaceColor='b';
p2.MarkerSize=msize;
end
% yline(1,'k--',LineWidth=2)
% txt='1% strain limit';
% text(3500,1.4,txt,'FontSize',fsize);
end
