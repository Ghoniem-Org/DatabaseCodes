
function C_p=W_SpecificHeat(T)
mole=0.183;                         % 1 mole=183 g=0.183 Kg
if (T>= 0) && (T<= 3080)
C_p= 21.868372+8.068661e-3*T-3.756196e-6*T^2+1.075862e-9*T^3+1.406637e4/T^2;
elseif (T>= 3080) && (T<= 3695)
    C_p=2.022+1.315e-2*T;
elseif (T>=3695)
   C_p=51.3;
end
C_p=C_p/mole;
end