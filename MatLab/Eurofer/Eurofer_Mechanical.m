% Function to compute the mechanical properties of Eurofer
function [E, sig_y, sig_u, e_u, e_tot] = Eurofer_Mechanical(T)
    E = 1e9 * (211.2 + 6.666e-2*T - 1.766e-4*T.^2 + 9.24e-8*T.^3);
    sig_y = 1004 - 2.863*T + 0.005232*T.^2 - 3.317e-6*T.^3;
    sig_u = 1024 - 2.212*T + 0.003796*T.^2 - 2.546e-6*T.^3;
    e_u = (3.584 + 2.989e-2*T - 7.623e-5*T.^2 + 4.504e-8*T.^3);
    e_tot = (38.84 - 8.156e-2*T + 7.421e-5*T.^2 + 4.358e-10*T.^3);
end


