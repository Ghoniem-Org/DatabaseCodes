
function rho=W_rho(T)
if (T>= 0) && (T<= 3695)
rho=19.25-2.66207e-4*(T-298)-3.0595e-9*(T-298)^2-9.5185e-12*(T-298)^3;
elseif (T>= 3695) && (T<= 6000)
rho =16.267-7.679e-4*(T-3695)-8.091e-8*(T-3695)^2; 
end
rho=rho*1e3;
end