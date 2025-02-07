% Main script to compute and plot the stress-strain curves
T = 550+273; % Example temperature, modify as needed
[E, sig_y, sig_u, e_u, e_tot] = Eurofer_Mechanical(T);

% Compute engineering stress-strain points
eps_y = sig_y / E;
sigma_y = sig_y;
eps_u = e_u;
sigma_u = sig_u;
eps_t = e_tot;
sigma_f = (0.45-(T-300)*6e-4)*sig_u;

% Define given stress-strain points
eps_control = [0, eps_y, eps_u, eps_t];
sigma_control = [0, sigma_y, sigma_u, sigma_f];

% Use PCHIP interpolation to maintain monotonicity
strain_fine = linspace(0, eps_t, 100);
stress_constrained = pchip(eps_control, sigma_control, strain_fine);

% Compute true stress-strain curve
true_strain = 100 * log(1 + 4 * strain_fine / 100);
true_stress = stress_constrained .* (1 + 4 * strain_fine / 100);

% Plot the constrained PCHIP fit
figure;
plot(eps_control, sigma_control, 'ro', 'DisplayName', 'Original Points');
hold on;
plot(strain_fine, stress_constrained, 'b-', 'DisplayName', 'Constrained PCHIP Fit');
plot(eps_control, sigma_control, 'k--', 'DisplayName', 'Linear Tangents');
yline(sigma_u, 'r--', 'DisplayName', 'Max Stress Constraint');
xlabel('Strain');
ylabel('Stress');
title('Monotonic B-Spline Fit Inscribed in Linear Segments with Tangency Constraints');
legend;
grid on;
hold off;

% Plot the true stress-strain curve
figure;
plot(true_strain, true_stress, 'g-', 'DisplayName', 'True Stress-Strain Curve');
hold on;
plot(strain_fine, stress_constrained, 'b-', 'DisplayName', 'Constrained PCHIP Fit');
xlabel('True Strain');
ylabel('True Stress');
title('Derived True Stress-Strain Curve from Engineering Stress-Strain Fit');
legend;
grid on;
hold off;

% Save figure
saveas(gcf, 'true_stress_strain.jpg');