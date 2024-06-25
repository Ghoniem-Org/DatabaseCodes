close all; clc; clear all;
global fsize msize y1 y2 y3 y4 LM1 LM2 sig_over_E TimeSteps SigSteps ...
    sig_LM  MinSig MaxSig TempSteps
format shortG
fsize=14;
msize=6;
TimeSteps=5e4;
SigSteps=10;
TempSteps=3;

f1=@(x,a,b) a*x.^b;

%%%%% Basic Data Input  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=linspace(2000,2200,TempSteps);
sigma=30e6;
MinSig=-6;
MaxSig=-3;

sig_over_E=logspace(MinSig,MaxSig,SigSteps);  %  MPa
sig_LM=logspace(0,3,SigSteps) ; %  MPa

y1=f1(sig_over_E,9e26,4.5);
y2=f1(sig_over_E,8e40,7.5);
y3=f1(sig_over_E,9e29,4.5);
y4=f1(sig_over_E,3e41,7.5);
LM1=f1(sig_LM,53,-0.2);
LM2=f1(sig_LM,72,-0.2);


GetCreepData()
GetCreepRate(T,sigma)
GeneratePlots(T,sigma)
