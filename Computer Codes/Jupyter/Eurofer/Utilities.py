import numpy as np
from scipy.optimize import curve_fit
from IPython.display import display, Markdown, Math, HTML
import matplotlib.pyplot as plt
from scipy.stats import t


# Define the general polynomial model of degree n
# def polynomial_model(x, *coeffs):
#     return sum(c * x**i for i, c in enumerate(coeffs))

def polynomial_model(x, *params):
    return sum([p * (x ** i) for i, p in enumerate(params)])


# Function to calculate and return goodness-of-fit parameters
def fit_poly(x, y, degree):
    # Perform curve fitting
    initial_guess = np.ones(degree + 1)  # Initial guess for the coefficients
    popt, _ = curve_fit(polynomial_model, x, y, p0=initial_guess)

    # Calculate the residuals
    residuals = y - polynomial_model(x, *popt)

    # Calculate the total sum of squares (TSS)
    ss_tot = np.sum((y - np.mean(y)) ** 2)

    # Calculate the residual sum of squares (RSS)
    ss_res = np.sum(residuals ** 2)

    # Calculate R-squared
    r_squared = 1 - (ss_res / ss_tot)

    # Calculate the reduced chi-squared
    # Degrees of freedom: number of observations - number of parameters
    degrees_of_freedom = len(x) - len(popt)
    reduced_chi_squared = ss_res / degrees_of_freedom

    # Data to be written
    fit_data = {
        'Optimized parameters': popt,
        "R-squared": r_squared,
        "Reduced chi-squared": reduced_chi_squared
    }

    # Display the formatted output in the Jupyter Notebook cell
    output = "# Goodness-of-fit parameters\n"
    for key, value in fit_data.items():
        output += f'\n{key}: {value}\n'

    return output, popt


# Function to format coefficients in scientific notation for LaTeX
def format_coefficient(value):
    sci = "{:.5e}".format(value).split('e')
    base = sci[0]
    exponent = int(sci[1])
    sign = "-" if base.startswith('-') else "+"
    base = base.lstrip('-')
    return f"{sign} {base} \\times 10^{{{exponent}}}"


# Generalized function to display fitting parameters and LaTeX equation
def display_fitting(material_name, property_name, output, popt):
    # Print the output
    display(HTML("<hr>"))
    text = f'**Fitting parameters for {material_name}** \n'
    display(Markdown(text))
    print(output)

    # Format the coefficients
    formatted_coeffs = [format_coefficient(c) for c in popt]

    # Handle T^0 term separately
    equation_terms = [formatted_coeffs[0]]  # Start with the constant term

    # Create the polynomial equation in LaTeX format for terms T^i where i > 0
    for i in range(1, len(popt)):
        term = formatted_coeffs[i]
        if term.startswith('+'):
            equation_terms.append(f"{term} T^{i}")
        else:
            equation_terms.append(f"{term} T^{i}")

    # Join the terms without adding an extra plus sign at the beginning
    equation = rf'{property_name} = ' + ' '.join(equation_terms).replace(' + -', ' -')

    # Display the equation using LaTeX formatting with the formatted coefficients
    print(f'The equation for {material_name} {property_name} is:\n')
    # display(Math(equation))
    # Display the equation using LaTeX formatting with the formatted coefficients inside a box
    boxed_equation = f"""
    <div style="border: 2px solid black; padding: 10px; display: inline-block;">
        $$ {equation} $$
    </div>
    """
    display(HTML(boxed_equation))
    print('\n\n')


def custom_plot(x_data, y_data, x_fit, y_fit,
                x_label='X-axis', y_label='Y-axis',
                title='Plot',
                scale='linear', font_size=16,
                xlim=None, ylim=None,
                grid=True, legend=True,
                data_label='Data', fit_label='Fit',
                data_color='blue', fit_color='red',
                data_marker_size=12, fit_line_width=3, x_label_font_size=16, y_label_font_size=16,
                title_font_size=16):
    plt.figure(figsize=(10, 6))

    if scale == 'linear':
        plt.xscale('linear')
        plt.yscale('linear')
    elif scale == 'log-log':
        plt.xscale('log')
        plt.yscale('log')
    elif scale == 'log-x':
        plt.xscale('log')
        plt.yscale('linear')
    elif scale == 'log-y':
        plt.xscale('linear')
        plt.yscale('log')
    else:
        raise ValueError("Scale must be 'linear', 'log-log', 'log-x', or 'log-y'")

    plt.plot(x_data, y_data, 'o', label=data_label, color=data_color, markersize=data_marker_size)
    plt.plot(x_fit, y_fit, '-', label=fit_label, color=fit_color, linewidth=fit_line_width)

    plt.xlabel(x_label, fontsize=font_size)
    plt.ylabel(y_label, fontsize=font_size)
    plt.title(title, fontsize=font_size)
    plt.xticks(fontsize=18)
    plt.yticks(fontsize=18)

    if xlim:
        plt.xlim(xlim)
    if ylim:
        plt.ylim(ylim)

    if grid:
        plt.grid(True, which='both', linestyle='--', linewidth=0.5)
    else:
        plt.grid(False)

    if legend:
        plt.legend()

    plt.show()


def custom_multi_plot(x_data_list, y_data_list, x_fit_list=None, y_fit_list=None,
                      x_label='X-axis', y_label='Y-axis', title='Plot',
                      scale='linear', font_size=16, xlim=None, ylim=None,
                      grid=True, legend=True, data_labels=None, fit_labels=None,
                      data_colors=None, fit_colors=None, data_marker_sizes=None,
                      fit_line_widths=None, x_label_font_size=16, y_label_font_size=16,
                      title_font_size=16):
    plt.figure(figsize=(10, 6))

    # Set default values if not provided
    if data_labels is None:
        data_labels = [f'Data {i + 1}' for i in range(len(x_data_list))]
    if fit_labels is None and x_fit_list is not None and y_fit_list is not None:
        fit_labels = [f'Fit {i + 1}' for i in range(len(x_fit_list))]
    if data_colors is None:
        data_colors = ['blue'] * len(x_data_list)
    if fit_colors is None and x_fit_list is not None and y_fit_list is not None:
        fit_colors = ['red'] * len(x_fit_list)
    if data_marker_sizes is None:
        data_marker_sizes = [20] * len(x_data_list)
    if fit_line_widths is None and x_fit_list is not None and y_fit_list is not None:
        fit_line_widths = [3] * len(x_fit_list)

    # Ensure the lists have the same length
    if len(x_data_list) != len(y_data_list):
        raise ValueError("x_data_list and y_data_list must have the same length.")
    if x_fit_list is not None and y_fit_list is not None and len(x_fit_list) != len(y_fit_list):
        raise ValueError("x_fit_list and y_fit_list must have the same length.")

    # Plot data points
    for i, (x_data, y_data) in enumerate(zip(x_data_list, y_data_list)):
        plt.scatter(x_data, y_data, label=data_labels[i], color=data_colors[i], s=data_marker_sizes[i])

    # Plot fit lines if provided
    if x_fit_list is not None and y_fit_list is not None:
        for i, (x_fit, y_fit) in enumerate(zip(x_fit_list, y_fit_list)):
            plt.plot(x_fit, y_fit, label=fit_labels[i], color=fit_colors[i], linewidth=fit_line_widths[i])

    plt.xlabel(x_label, fontsize=x_label_font_size)
    plt.ylabel(y_label, fontsize=y_label_font_size)
    plt.title(title, fontsize=title_font_size)
    plt.xscale(scale)
    plt.yscale(scale)
    if xlim:
        plt.xlim(xlim)
    if ylim:
        plt.ylim(ylim)
    if grid:
        plt.grid(True)
    if legend:
        plt.legend()
    plt.show()


def fit_poly_with_confidence(x, y, degree, confidence=0.95):
    # Perform curve fitting
    initial_guess = np.ones(degree + 1)  # Initial guess for the coefficients
    try:
        popt, pcov = curve_fit(polynomial_model, x, y, p0=initial_guess)

        # Calculate the mean fit
        mean_fit = polynomial_model(x, *popt)

        # Calculate the residuals
        residuals = y - mean_fit

        # Calculate the total sum of squares (TSS)
        ss_tot = np.sum((y - np.mean(y)) ** 2)

        # Calculate the residual sum of squares (RSS)
        ss_res = np.sum(residuals ** 2)

        # Calculate R-squared
        r_squared = 1 - (ss_res / ss_tot)

        # Calculate the reduced chi-squared
        # Degrees of freedom: number of observations - number of parameters
        degrees_of_freedom = len(x) - len(popt)
        reduced_chi_squared = ss_res / degrees_of_freedom

        # Calculate the 95% confidence intervals for the fit parameters
        alpha = 1.0 - confidence
        dof = max(0, degrees_of_freedom)
        t_val = t.ppf(1.0 - alpha / 2., dof)
        ci = t_val * np.sqrt(np.diag(pcov))

        # Calculate the prediction intervals
        sum_squared_errors = np.sum(residuals ** 2)
        mean_x = np.mean(x)
        n = len(x)
        t_val = t.ppf((1.0 + confidence) / 2.0, dof)

        pred_interval = []
        for i in range(len(x)):
            s_err = np.sqrt(1 / n + (x[i] - mean_x) ** 2 / np.sum((x - mean_x) ** 2))
            margin = t_val * np.sqrt(sum_squared_errors / dof) * s_err
            pred_interval.append(margin)

        pred_interval = np.array(pred_interval)
        lower_pred = mean_fit - pred_interval
        upper_pred = mean_fit + pred_interval

        # Data to be written
        fit_data = {
            'Optimized parameters': popt,
            "R-squared": r_squared,
            "Reduced chi-squared": reduced_chi_squared,
            "Confidence intervals": ci,
            "Mean fit": mean_fit,
            "Lower 95% prediction": lower_pred,
            "Upper 95% prediction": upper_pred
        }

    except Exception as e:
        print("Exception occurred:", e)
        fit_data = {
            'Optimized parameters': None,
            "R-squared": None,
            "Reduced chi-squared": None,
            "Confidence intervals": None,
            "Mean fit": None,
            "Lower 95% prediction": None,
            "Upper 95% prediction": None,
            "Error": str(e)
        }

    return fit_data


def plot_fit_with_confidence(x, y, fit_data,
                             x_label='X-axis', y_label='Y-axis',
                             title='Plot',
                             scale='linear', font_size=16,
                             xlim=None, ylim=None,
                             grid=True, legend=True,
                             data_label='Data', fit_label='Fit',
                             data_color='blue', fit_color='red',
                             data_marker_size=12, fit_line_width=3, x_label_font_size=16, y_label_font_size=16,
                             title_font_size=16):
    plt.figure(figsize=(10, 6))

    plt.plot(x, y, 'o', label=data_label, color=data_color, markersize=data_marker_size)
    if fit_data['Mean fit'] is not None:
        plt.plot(x, fit_data['Mean fit'], label='Mean Fit', color='red', linewidth=3)
        plt.fill_between(x, fit_data['Lower 95% prediction'], fit_data['Upper 95% prediction'],
                         color='gray', alpha=0.2, label='95% Prediction Interval')

    if scale == 'linear':
        plt.xscale('linear')
        plt.yscale('linear')
    elif scale == 'log-log':
        plt.xscale('log')
        plt.yscale('log')
    elif scale == 'log-x':
        plt.xscale('log')
        plt.yscale('linear')
    elif scale == 'log-y':
        plt.xscale('linear')
        plt.yscale('log')
    else:
        raise ValueError("Scale must be 'linear', 'log-log', 'log-x', or 'log-y'")

    plt.xlabel(x_label, fontsize=font_size)
    plt.ylabel(y_label, fontsize=font_size)
    plt.title(title, fontsize=font_size)
    plt.xticks(fontsize=18)
    plt.yticks(fontsize=18)

    if xlim:
        plt.xlim(xlim)
    if ylim:
        plt.ylim(ylim)

    if grid:
        plt.grid(True, which='both', linestyle='--', linewidth=0.5)
    else:
        plt.grid(False)

    if legend:
        plt.legend()

    plt.show()


