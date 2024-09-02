## Package imports and utility functions written by Indro:
# Installation note - conda install the following packages:
# jupyterlab numpy scipy sympy matplotlib pandas conda-forge::openpyxl conda-forge::lmfit conda-forge::numdifftools

import pandas as pd
import numpy as np
from lmfit import Model, Parameters
import sympy
from sympy import Symbol, Poly, N
from IPython.display import display, Markdown, HTML
import string
abet_list = list(string.ascii_lowercase)
# abet_list stores the following for use in polynomial generation:
# ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

# Load the data from the Excel file

# 3rd argument is header_rows_list, containing a minibm of 1 and a maxibm of 2 row integers
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

def load_data(filename, sheet_name, header_rows_list=[1, 3], num_data_rows=20, room_temp=293):

    # Column labels, used to construct variable names
    # Variable names that mirror the column labels, only removing non-anumeric characters in the translation_table
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
        raise ValueError("header_rows_list bst be a list containing a minibm of 1 and a maxibm of 2 row integers!")
        
    temp_data = pd.read_excel(filename, sheet_name=sheet_name, header=header_rows_list[-1]-1, nrows=num_data_rows, usecols=cols_with_data).replace('RT', room_temp)
    temp_data.columns = var_names
    display(pd.DataFrame(temp_data))
    variables = [temp_data[col].dropna().to_numpy() for col in var_names]

    return var_names, variables


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
        args_string += abet_list[i] + ', '
    args_string += abet_list[deg]
    
    for i in range(0, deg-1):
        func_string += abet_list[i] + '*x**' + str(deg-i) + " + "

    func_string += abet_list[deg-1] + '*x' + " + " + abet_list[deg]

    return eval("lambda x, " + args_string + ": " + func_string)

##################################################################################################
# Weibull distribution model function
# When x < μ:the function is zero because the distribution starts at 𝜇
# This is a key characteristic, as the Weibull distribution is defined only for x ≥ μ.
# For x ≥ μ: The distribution takes on different shapes depending on the value of :
# γ < 1: The hazard function is decreasing, indicating a higher probability of failure (or event) early on, with the rate decreasing over time.
# The PDF has a peak at  x=μ and decreases monotonically.
# γ = 1: The distribution simplifies to an exponential distribution with a constant hazard function.
# The PDF is a decreasing exponential function.
# γ > 1: The hazard function is increasing, indicating a lower probability of failure early on, with the rate increasing over time.
# The PDF initially increases, reaches a peak, and then decreases, showing a typical "bell" shape.
# Impact of α:
# Larger values of α stretch the distribution, making it wider and less peaked.
# Smaller values of α compress the distribution, making it narrower and more peaked.
# Impact of μ:
# The location parameter μ shifts the entire distribution along the x-axis.
# Changing μ does not affect the shape of the distribution but changes the starting point.

c_default = 1
a_default = 1
b_default = 0
def weibull(x, c=c_default, a=a_default, b=b_default):
    return (c / a) * ((x - b) / a)**(c - 1) * np.exp(-((x - b) / a)**c)

####################################################################################################
# Generalized Exponential model function
# Constant Term (a): This term shifts the entire function vertically. 
# It determines the baseline value of the function when all other terms are zero.
# Linear Term (𝑏+𝑐𝑥): introduces a linear component that depends on 𝑥
# b is the y-intercept of this linear component.
# c is the slope of the linear component, determining how quickly the value of 
# b+cx changes with 𝑥
# Exponential Term (exp(dx)): It controls the rate of exponential growth or decay:
# If 𝑑 > 0 , the function grows exponentially.
# If 𝑑 < 0, the function decays exponentially.

a_default_exp = 0
b_default_exp = 0
c_default_exp = 1
d_default_exp = 1
def exponential(x, a=a_default_exp, b=b_default_exp, c=c_default_exp, d=d_default_exp):
    return a + (b + c * x) * np.exp(d * x)

###################################################################################################
# Transition function
#  The function starts near 𝑎 for large negative 𝑥. It transitions smoothly around 𝑥 = 𝑑, 
# controlled by the parameter 𝑒. It ends up behaving like 𝑏+𝑐𝑥 for large positive 𝑥
# a: Shifts the entire function vertically.
# b: Controls the final value for large positive x
# c: Controls the slope of the linear component added to 𝑏
# d: Controls the center of the transition.
# e: Controls the steepness of the transition


a_default_tran = 0
b_default_tran = 0
c_default_tran = 1
d_default_tran = 0
e_default_tran = 1
def transition(x, a=a_default_tran, b=b_default_tran, c=c_default_tran, d=d_default_tran, e=e_default_tran):
    return a + 0.5 * (b - a + c * x) * (1 + np.tanh((x - d) / e))

###################################################################################################

# Calculate confidence intervals
def get_model_fit_and_print_it(x, y, fit_func='poly', method='leastsq', fit_fun_args_and_initials={}, 
                               material_name=None, property_name=None, eq_digits=6, print_bool=False):

    # Model fitting based on specified fitting function ('fit_func') and fitting method ('method')
    if fit_func == 'poly':
        poly_deg = len(fit_fun_args_and_initials)-1
        model = Model(polynomial_generator(poly_deg))
        
        initial_guess_args = ''
        for arg, initial in fit_fun_args_and_initials.items():
            if not arg == list(fit_fun_args_and_initials)[-1]:
                initial_guess_args += arg + '=' + str(initial) + ", "
            else:
                initial_guess_args += arg + '=' + str(initial)
                
        result = eval("model.fit(y, x=x, method=method, " + initial_guess_args + ")")
        
    elif fit_func == 'weibull':
        
        model = Model(weibull)
        params = Parameters()

        default_args = {'c': c_default, 'a': a_default, 'b': b_default}
        
        for arg, initial in fit_fun_args_and_initials.items():
            if arg == 'c':
                params.add('c', value=initial, min=1e-10, max=1e3)
            elif arg == 'a':
                params.add('a', value=initial, min=1e-10, max=1e3)
            else: # var == 'b':
                params.add('b', value=initial)

        for arg, initial in default_args.items():
            if arg not in fit_fun_args_and_initials:
                if arg == 'c':
                    params.add('c', value=c_default, vary=False)
                elif arg == 'a':
                    params.add('a', value=a_default, vary=False)
                else: # var == 'b':
                    params.add('b', value=b_default, vary=False)

        result = model.fit(y, x=x, method=method, params=params, nan_policy='propagate')

    elif fit_func == 'exponential':
        
        model = Model(exponential)
        params = Parameters()

        default_args = {'a': a_default_exp, 'b': b_default_exp, 'c': c_default_exp, 'd': d_default_exp}
        
        for arg, initial in fit_fun_args_and_initials.items():
            params.add(arg, value=initial)
            
        for arg, initial in default_args.items():
            if arg not in fit_fun_args_and_initials:
                params.add(arg, value=initial, vary=False)
                
        result = model.fit(y, x=x, method=method, params=params, nan_policy='propagate')
        
    elif fit_func == 'transition':
        
        model = Model(transition)
        params = Parameters()

        default_args = {'a': a_default_tran, 'b': b_default_tran, 'c': c_default_tran, 'd': d_default_tran, 'e': e_default_tran}
        
        for arg, initial in fit_fun_args_and_initials.items():
            params.add(arg, value=initial)
            
        for arg, initial in default_args.items():
            if arg not in fit_fun_args_and_initials:
                params.add(arg, value=initial, vary=False)
                
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
            
            display(N(Poly([result.params[abet_list[i]].value for i in range(0, poly_deg+1)],\
                           Symbol("T")).as_expr(), eq_digits))
            
        elif fit_func == 'weibull':
            
            c_fit = result.params['c'].value
            a_fit = result.params['a'].value
            b_fit = result.params['b'].value
            T = Symbol("T")
            display(N((c_fit / a_fit) * ((T - b_fit) / a_fit)**(c_fit - 1) * sympy.exp(-((T - b_fit) / a_fit)**c_fit), eq_digits))

        elif fit_func == 'exponential':

            a_fit = result.params['a'].value
            b_fit = result.params['b'].value
            c_fit = result.params['c'].value
            d_fit = result.params['d'].value
            T = Symbol("T")
            display(N(a_fit + (b_fit + c_fit * T) * sympy.exp(d_fit * T), eq_digits))

        elif fit_func == 'transition':
            
            a_fit = result.params['a'].value
            b_fit = result.params['b'].value
            c_fit = result.params['c'].value
            d_fit = result.params['d'].value
            e_fit = result.params['e'].value
            T = Symbol("T")
            display(N(a_fit + 0.5 * (b_fit - a_fit + c_fit * T) * (1 + sympy.tanh((T - d_fit) / e_fit)), eq_digits))
            
        else:
            pass # valid fit_func string checked in previous if block
            
    return result