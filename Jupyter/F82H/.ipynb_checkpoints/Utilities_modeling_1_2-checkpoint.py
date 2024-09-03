## Package imports and utility functions written by Indro:
# Installation note - conda install the following packages:
# jupyterlab numpy scipy sympy matplotlib pandas conda-forge::openpyxl conda-forge::lmfit conda-forge::numdifftools

import pandas as pd
import numpy as np
from lmfit import Model, Parameters
from lmfit.models import PolynomialModel
import sympy
from sympy import Symbol, Poly, N, latex
from IPython.display import display, HTML, Markdown, Latex

# Load the data from the Excel file:

# 3rd argument is header_rows_list, containing a minimum of 1 and a maximum of 2 row integers
# Denotes what rows to consider in constructing variable names -
# If two row integers are given, then the first row (e.g. material name) is used as a prefix,
# while the second row (e.g. indepedent or dependent variable) is used as a suffix.
# If two row integers are given, it is assume that the format is:
# |                  Material Name 1              |   ...   |                  Material Name n              |
# | Independent variable 1 | Dependent variable 1 |   ...   | Independent variable n | Dependent variable n |

# If only one row integers are given, it is assume that the format is:
# | Independent variable 1 | Dependent variable 1 |   ...   | Independent variable n | Dependent variable n |

# Row integers start counting from 1 like in an Excel spreadsheet.

translation_table = {ord(' ') : None, ord(',') : None, ord('.') : None, ord('-') : None, ord('°') : None, ord('\'') : None, ord('"') : None,\
                     ord('(') : None, ord(')') : None, ord('[') : None, ord(']') : None, ord('{') : None, ord('}') : None}

def load_data(filename, sheet_name, header_rows_list=[1, 3], num_data_rows=20, room_temp=293, display_data_table_bool=True):

    # Column labels, used to construct variable names
    # Variable names that mirror the column labels, only removing non-alphanumeric characters in the translation_table
    if len(header_rows_list) == 1:
        
        col_names = list(pd.read_excel(filename, sheet_name=sheet_name, header=header_rows_list[0]-1, nrows=1))
        cols_with_data = [i for i in range(0, len(col_names)) if "Unnamed" not in col_names[i]]
        col_names = [col_name for col_name in col_names if "Unnamed" not in col_name]
        var_names = [col.translate(translation_table) for col in col_names]
        
    elif len(header_rows_list) == 2:
        
        col_names_prefix = list(pd.read_excel(filename, sheet_name=sheet_name, header=header_rows_list[0]-1, nrows=1))
        col_names_prefix = [col_name for col_name in col_names_prefix if "Unnamed" not in col_name]
        var_names_prefix = [col.translate(translation_table) for col in col_names_prefix]
        
        col_names_suffix = list(pd.read_excel(filename, sheet_name=sheet_name, header=header_rows_list[1]-1, nrows=1))
        cols_with_data = [i for i in range(0, len(col_names_suffix)) if "Unnamed" not in col_names_suffix[i]]
        col_names_suffix = [col_name for col_name in col_names_suffix if "Unnamed" not in col_name]
        var_names_suffix = [col.translate(translation_table) for col in col_names_suffix]

        var_names = []
        for i in range(0, len(col_names_prefix)):
            for j in range(2*i, 2*i+2):
                var_names.append(var_names_prefix[i] + var_names_suffix[j])
    else:
        raise ValueError("header_rows_list must be a list containing a minimum of 1 and a maximum of 2 row integers!")
        
    # Temporarily store the columnar Excel data
    # with pd.option_context('future.no_silent_downcasting', True):
    temp_data = pd.read_excel(filename, sheet_name=sheet_name, header=header_rows_list[-1]-1, nrows=num_data_rows, usecols=cols_with_data).replace('RT', room_temp)
  
    temp_data.columns = var_names
    if display_data_table_bool:
        display(pd.DataFrame(temp_data))
    
    exec(", ".join(var_names) + " = [temp_data[col].dropna().to_numpy() for col in temp_data]")
    print(temp_data)
    return var_names, list(eval(", ".join(var_names)))


# Concatenate and sort lists of x and y data
def concatenate_and_sort(x_list, y_list):

    x_concat = np.concatenate(x_list)
    y_concat = np.concatenate(y_list)

    x_sorted_indices = x_concat.argsort()
    x_sorted = x_concat[x_sorted_indices[::-1]]
    y_sorted = y_concat[x_sorted_indices[::-1]]

    return x_sorted, y_sorted


##################################################################################################
# Polynomial function generator of arbitrary degree
def polynomial_generator(deg):

    args_string = ''
    func_string = ''
    
    for i in range(0, deg):
        args_string += alphabet_list[i] + ', '
    args_string += alphabet_list[deg]
    
    for i in range(0, deg-1):
        func_string += alphabet_list[i] + '*x**' + str(deg-i) + " + "

    func_string += alphabet_list[deg-1] + '*x' + " + " + alphabet_list[deg]

    return eval("lambda x, " + args_string + ": " + func_string)

##################################################################################################
# Weibull distribution model function
# When x < p_1: the function is zero because the distribution starts at p_1
# This is a key characteristic, as the Weibull distribution is defined only for x ≥ p_1.
# For x ≥ p_1: The distribution takes on different shapes depending on the value of :
# p_2 < 1: The hazard function is decreasing, indicating a higher probability of failure (or event) early on, with the rate decreasing over time.
# The PDF has a peak at  x=p_1 and decreases monotonically.
# p_2 = 1: The distribution simplifies to an exponential distribution with a constant hazard function.
# The PDF is a decreasing exponential function.
# p_2 > 1: The hazard function is increasing, indicating a lower probability of failure early on, with the rate increasing over time.
# The PDF initially increases, reaches a peak, and then decreases, showing a typical "bell" shape.
# Impact of p_0:
# Larger values of p_0 stretch the distribution, making it wider and less peaked.
# Smaller values of p_0 compress the distribution, making it narrower and more peaked.
# Impact of p_1:
# The location parameter p_1 shifts the entire distribution along the x-axis.
# Changing p_1 does not affect the shape of the distribution but changes the starting point.

p_0_default_w = 1
p_1_default_w = 0
p_2_default_w = 1
def weibull(x, p_0=p_0_default_w, p_1=p_1_default_w, p_2=p_2_default_w):
    return (p_2 / p_0) * ((x - p_1) / p_0)**(p_2 - 1) * np.exp(-((x - p_1) / p_0)**p_2)

####################################################################################################
# Generalized Exponential model function
# Constant Term (p_0): This term shifts the entire function vertically. 
# It determines the baseline value of the function when all other terms are zero.
# Linear Term (p_1 + p_2 x): introduces a linear component that depends on x
# p_1 is the y-intercept of this linear component.
# p_2 is the slope of the linear component, determining how quickly the value of 
# p_1 + p_2 x changes with x
# Exponential Term (exp(p_3 x)): It controls the rate of exponential growth or decay:
# If p_3 > 0 , the function grows exponentially.
# If p_3 < 0, the function decays exponentially.

p_0_default_e = 0
p_1_default_e = 0
p_2_default_e = 1
p_3_default_e = 1
def exponential(x, p_0=p_0_default_e, p_1=p_1_default_e, p_2=p_2_default_e, p_3=p_3_default_e):
    return p_0 + (p_1 + p_2 * x) * np.exp(p_3 * x)

###################################################################################################
# Transition function
# The function starts near a for large negative x. It transitions smoothly around x = p_3, 
# controlled by the parameter p_4. It ends up behaving like p_1 + p_2 x for large positive x
# p_0: Shifts the entire function vertically.
# p_1: Controls the final value for large positive x
# p_2: Controls the slope of the linear component added to p_1
# p_3: Controls the center of the transition.
# p_4: Controls the steepness of the transition

p_0_default_t = 0
p_1_default_t = 0
p_2_default_t = 1
p_3_default_t = 0
p_4_default_t = 1
def transition(x, p_0=p_0_default_t, p_1=p_1_default_t, p_2=p_2_default_t, p_3=p_3_default_t, p_4=p_4_default_t):
    return p_0 + 0.5 * (p_1 - p_0 + p_2 * x) * (1 + np.tanh((x - p_3) / p_4))

###################################################################################################

# Calculate confidence intervals
def get_model_fit_and_print_it(x, y, fit_func='poly', method='leastsq', param_initials=None, 
                               material_name=None, property_name=None, eq_digits=6, print_bool=False, fit_symbol='T'):

    # Model fitting based on specified fitting function ('fit_func') and fitting method ('method')
    if fit_func == 'poly':
        
        poly_deg = len(param_initials)-1
        model = PolynomialModel(degree=poly_deg, nan_policy='propagate')

        args = ''
        for i in range(0, poly_deg):
            args += 'c' + str(i) + '=' + str(param_initials[i]) + ", "
        args += 'c' + str(poly_deg) + '=' + str(poly_deg)

        params = eval("model.make_params("  + args + ")") 
        result = model.fit(y, x=x, method=method, params=params)
        
    elif fit_func == 'weibull':
        
        model = Model(weibull)
        params = Parameters()

        if not len(param_initials) == 3:
            raise ValueError("Must give 3 parameters to use the weibull fitting function. Parameters may include NaN to fix a variable to its constant default.")
            
        if not np.isnan(param_initials[0]):
            params.add('p_0', value=param_initials[0], min=1e-10, max=1e3)
        else:
            params.add('p_0', value=p_0_default_w, vary=False)

        if not np.isnan(param_initials[1]):
            params.add('p_1', value=param_initials[1])
        else:
            params.add('p_1', value=p_1_default_w, vary=False)

        if not np.isnan(param_initials[2]):
            params.add('p_2', value=param_initials[2], min=1e-10, max=1e3)
        else:
            params.add('p_2', value=p_2_default_w, vary=False)

        result = model.fit(y, x=x, method=method, params=params, nan_policy='propagate')

    elif fit_func == 'exponential':
        
        model = Model(exponential)
        params = Parameters()

        if not len(param_initials) == 4:
            raise ValueError("Must give 4 parameters to use the exponential fitting function. Parameters may include NaN to fix a variable to its constant default.")

        # default_args = {'a': p_0_default_exp, 'b': p_1_default_exp, 'c': p_2_default_exp, 'd': p_3_default_exp}

        if not np.isnan(param_initials[0]):
            params.add('p_0', value=param_initials[0])
        else:
            params.add('p_0', value=p_0_default_e, vary=False)

        if not np.isnan(param_initials[1]):
            params.add('p_1', value=param_initials[1])
        else:
            params.add('p_1', value=p_1_default_e, vary=False)

        if not np.isnan(param_initials[2]):
            params.add('p_2', value=param_initials[2])
        else:
            params.add('p_2', value=p_2_default_e, vary=False)

        if not np.isnan(param_initials[3]):
            params.add('p_3', value=param_initials[3])
        else:
            params.add('p_3', value=p_3_default_e, vary=False)
            
        result = model.fit(y, x=x, method=method, params=params, nan_policy='propagate')
        
    elif fit_func == 'transition':
        
        model = Model(transition)
        params = Parameters()

        if not len(param_initials) == 5:
            raise ValueError("Must give 5 parameters to use the transition fitting function. Parameters may include NaN to fix a variable to its constant default.")

        if not np.isnan(param_initials[0]):
            params.add('p_0', value=param_initials[0])
        else:
            params.add('p_0', value=p_0_default_t, vary=False)

        if not np.isnan(param_initials[1]):
            params.add('p_1', value=param_initials[1])
        else:
            params.add('p_1', value=p_1_default_t, vary=False)

        if not np.isnan(param_initials[2]):
            params.add('p_2', value=param_initials[2])
        else:
            params.add('p_2', value=p_2_default_t, vary=False)

        if not np.isnan(param_initials[3]):
            params.add('p_3', value=param_initials[3])
        else:
            params.add('p_3', value=p_3_default_t, vary=False)

        if not np.isnan(param_initials[4]):
            params.add('p_4', value=param_initials[4])
        else:
            params.add('p_4', value=p_4_default_t, vary=False)
                
        result = model.fit(y, x=x, method=method, params=params, nan_policy='propagate')
        
    else:
        raise ValueError("Please give a valid fit_func string among: 'poly', 'weibull', 'exponential', 'transition'!")

    # Printing the fitting parameters and equation
    if print_bool:
        
        display(HTML("<hr>"))
        display(Markdown(f'**Fitting parameters for {material_name} {property_name}** \n'))
        print(result.fit_report())
        display(HTML("<hr>"))
        display(Markdown(f'**The equation for {material_name} {property_name} is:**\n'))
        
        if fit_func == 'poly':
            
            sym = Symbol(fit_symbol)
                
            latex_list = []
            c_list = ['c0', 'c1', 'c2', 'c3', 'c4', 'c5', 'c6', 'c7']
            for i in range(0, poly_deg+1):
                latex_list.insert(0, latex(N(result.params[c_list[i]].value, eq_digits) * sym**(poly_deg-i), min=0, max=0))
            
            latex_to_print = ''
            for i in range(0, poly_deg+1):
                if "+" == latex_list[i].lstrip()[0] or "-" == latex_list[i].lstrip()[0]:
                    latex_to_print += latex_list[i] + " "
                else:
                    latex_to_print += "+ " + latex_list[i] + " "
                    
            latex_to_print = '\\boxed{ ' + latex_to_print + ' }'
            display(Latex(f'${latex_to_print}$'))
        
        elif fit_func == 'weibull':
            
            p_0_fit = N(result.params['p_0'].value, eq_digits)
            p_1_fit = N(result.params['p_1'].value, eq_digits)
            p_2_fit = N(result.params['p_2'].value, eq_digits)
            sym = Symbol(fit_symbol)
            
            latex_to_print = '\\boxed{ '\
            + latex((p_2_fit / p_0_fit) * ((sym - p_1_fit) / p_0_fit)**(p_2_fit - 1) * sympy.exp(-((sym - p_1_fit) / p_0_fit)**p_2_fit), min=0, max=0)\
            + ' }'
            
            display(Latex(f'${latex_to_print}$'))
            
        elif fit_func == 'exponential':

            p_0_fit = N(result.params['p_0'].value, eq_digits)
            p_1_fit = N(result.params['p_1'].value, eq_digits)
            p_2_fit = N(result.params['p_2'].value, eq_digits)
            p_3_fit = N(result.params['p_3'].value, eq_digits)
            sym = Symbol(fit_symbol)

            a_term_latex = latex(p_0_fit)
            exp_term_latex = latex((p_1_fit + p_2_fit * sym) * sympy.exp(p_3_fit * sym), min=0, max=0)

            if "+" != a_term_latex.lstrip()[0] and "-" != a_term_latex.lstrip()[0]:
                a_term_latex = "+ " + a_term_latex + " "

            if "+" != exp_term_latex.lstrip()[0] and "-" != exp_term_latex.lstrip()[0]:
                exp_term_latex = "+ " + exp_term_latex
            
            latex_to_print = '\\boxed{ ' + a_term_latex + exp_term_latex + ' }'
            
            display(Latex(f'${latex_to_print}$'))

        elif fit_func == 'transition':
            
            p_0_fit = N(result.params['p_0'].value, eq_digits)
            p_1_fit = N(result.params['p_1'].value, eq_digits)
            one_half_times_p_1_minus_p_0_fit = N(0.5*(result.params['p_1'].value - result.params['p_0'].value), eq_digits)
            one_half_times_p_2_fit = N(0.5*result.params['p_2'].value, eq_digits)
            p_3_fit = N(result.params['p_3'].value, eq_digits)
            p_4_fit = N(result.params['p_4'].value, eq_digits)
            sym = Symbol(fit_symbol)
    
            a_term_latex = latex(p_0_fit)
            tanh_term_latex = latex((one_half_times_p_1_minus_p_0_fit + one_half_times_p_2_fit * sym) * (1 + sympy.tanh((sym - p_3_fit) / p_4_fit)), min=0, max=0)

            if "+" != a_term_latex.lstrip()[0] and "-" != a_term_latex.lstrip()[0]:
                a_term_latex = "+ " + a_term_latex + " "

            if "+" != tanh_term_latex.lstrip()[0] and "-" != tanh_term_latex.lstrip()[0]:
                tanh_term_latex = "+ " + tanh_term_latex
            
            latex_to_print = '\\boxed{ ' + a_term_latex + tanh_term_latex + ' }'
            
            display(Latex(f'${latex_to_print}$'))
            
        else:
            pass # valid fit_func string checked in previous if block
            
    return result