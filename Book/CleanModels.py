import pandas as pd
import numpy as np
from lmfit import Model, Parameters
from lmfit.models import PolynomialModel
import sympy
from sympy import Symbol, Poly, N, latex
from IPython.display import display, HTML, Markdown, Latex


def LOADDATA(
        filename:str,
        sheet_name:str,
        header_rows_list=[1, 3],
        num_data_rows=20,
        room_temp=293,
        display_bool=True
):

    translation_table = {
        ord(' '): None, ord(','): None, ord('.'): None, ord('-'): None, ord('°'): None, ord('\''): None, ord('"'): None,
        ord('('): None, ord(')'): None, ord('['): None, ord(']'): None, ord('{'): None, ord('}'): None
    }

    if len(header_rows_list) == 1:
        col_names = list(pd.read_excel(filename, sheet_name=sheet_name, header=header_rows_list[0] - 1, nrows=1))
        cols_with_data = [i for i in range(0, len(col_names)) if "Unnamed" not in col_names[i]]
        col_names = [col_name for col_name in col_names if "Unnamed" not in col_name]
        var_names = [col.translate(translation_table) for col in col_names]

    elif len(header_rows_list) == 2:

        col_names_prefix = list(pd.read_excel(filename, sheet_name=sheet_name, header=header_rows_list[0] - 1, nrows=1))
        col_names_prefix = [col_name for col_name in col_names_prefix if "Unnamed" not in col_name]
        var_names_prefix = [col.translate(translation_table) for col in col_names_prefix]

        col_names_suffix = list(pd.read_excel(filename, sheet_name=sheet_name, header=header_rows_list[1] - 1, nrows=1))
        cols_with_data = [i for i in range(0, len(col_names_suffix)) if "Unnamed" not in col_names_suffix[i]]
        col_names_suffix = [col_name for col_name in col_names_suffix if "Unnamed" not in col_name]
        var_names_suffix = [col.translate(translation_table) for col in col_names_suffix]

        var_names = []
        for i in range(0, len(col_names_prefix)):
            for j in range(2 * i, 2 * i + 2):
                var_names.append(var_names_prefix[i] + var_names_suffix[j])
    else:
        raise ValueError("header_rows_list must be a list containing a minimum of 1 and a maximum of 2 row integers!")

    temp_data = pd.read_excel(filename, sheet_name=sheet_name, header=header_rows_list[-1] - 1, nrows=num_data_rows, usecols=cols_with_data)
    temp_data = temp_data.replace('RT', room_temp)
    temp_data.columns = var_names
    variables = [temp_data[col].dropna().to_numpy() for col in var_names]

    if display_bool:
        display(pd.DataFrame(temp_data).dropna(how='all'))

    return var_names, variables, temp_data


def weibull(x, p_0=1, p_1=0, p_2=1):
    return (p_2 / p_0) * ((x - p_1) / p_0)**(p_2 - 1) * np.exp(-((x - p_1) / p_0)**p_2)
def exponential(x, p_0=0, p_1=0, p_2=1, p_3=1):
    return p_0 + (p_1 + p_2 * x) * np.exp(p_3 * x)
def transition(x, p_0=0, p_1=1, p_2=0, p_3=100, p_4=10):
    return p_0 + 0.5 * (p_1 - p_0 + p_2 * x) * (1 + np.tanh((x - p_3) / p_4))
def dip(x, p_0=0, p_1=1, p_2=1, p_3=1, p_4=1, p_5=1, p_6=1):
    return p_0 + p_1 * (1 + np.tanh((x - p_2) / p_3))+ p_4 * (1 + np.tanh((x - p_5) / p_6))
def hardening(x, p_0=0, p_1=1, p_2=1):
    return (p_0 + p_1 * x**(1/2)) * (1 - np.exp(-x/p_2))**(1/2)
def swelling(x, p_0=1, p_1=1):
    return p_0 * x * (1 - np.exp(-x/p_1))


def ModelFit(
        x,
        y,
        param_initials,
        sigma=3,
        fit_func='poly',
        method='leastsq'
):

    if any(np.isnan(x) for x in param_initials):
        print("Warning: 'param_initials' contains NaN values!")

    # Model fitting based on specified fitting function ('fit_func') and fitting method ('method')
    if fit_func == 'poly':
        poly_deg = len(param_initials) - 1
        model = PolynomialModel(degree=poly_deg, nan_policy='propagate')

        args = ''
        for i in range(0, poly_deg):
            args += 'c' + str(i) + '=' + str(param_initials[i]) + ", "
        args += 'c' + str(poly_deg) + '=' + str(poly_deg)

        params = eval("model.make_params(" + args + ")")
        result = model.fit(y, x=x, method=method, params=params)

        fit_for_x = result.eval(result.params, x=x)
        dely = result.eval_uncertainty(sigma=sigma, x=x)
        result_min = model.fit(fit_for_x - dely, x=x, method=method, params=params)
        result_max = model.fit(fit_for_x + dely, x=x, method=method, params=params)

    elif fit_func == 'weibull':
        if not len(param_initials) == 3:
            raise ValueError(
                "Must give 3 initial parameters to use the weibull fitting function. Initial params may include NaN to fix a variable to its constant default."
            )

        model = Model(weibull)
        params = Parameters()
        for i in range(0, len(param_initials)):
            params.add('p_' + str(i), value=param_initials[i])
        result = model.fit(y, x=x, method=method, params=params, nan_policy='propagate')

        fit_for_x = result.eval(result.params, x=x)
        dely = result.eval_uncertainty(sigma=sigma, x=x)
        result_min = model.fit(fit_for_x - dely, x=x, method=method, params=params, nan_policy='propagate')
        result_max = model.fit(fit_for_x + dely, x=x, method=method, params=params, nan_policy='propagate')

    elif fit_func == 'exponential':
        if not len(param_initials) == 4:
            raise ValueError(
                "Must give 4 initial parameters to use the exponential fitting function. Initial params may include NaN to fix a variable to its constant default."
            )

        model = Model(exponential)
        params = Parameters()
        for i in range(0, len(param_initials)):
            params.add('p_' + str(i), value=param_initials[i])
        result = model.fit(y, x=x, method=method, params=params, nan_policy='propagate')

        fit_for_x = result.eval(result.params, x=x)
        dely = result.eval_uncertainty(sigma=sigma, x=x)
        result_min = model.fit(fit_for_x - dely, x=x, method=method, params=params, nan_policy='propagate')
        result_max = model.fit(fit_for_x + dely, x=x, method=method, params=params, nan_policy='propagate')

    elif fit_func == 'transition':
        if not len(param_initials) == 5:
            raise ValueError(
                "Must give 5 initial parameters to use the transition fitting function. Initial params may include NaN to fix a variable to its constant default."
            )

        model = Model(transition)
        params = Parameters()
        for i in range(0, len(param_initials)):
            params.add('p_' + str(i), value=param_initials[i])
        result = model.fit(y, x=x, method=method, params=params, nan_policy='propagate')

        fit_for_x = result.eval(result.params, x=x)
        dely = result.eval_uncertainty(sigma=sigma, x=x)
        result_min = model.fit(fit_for_x - dely, x=x, method=method, params=params, nan_policy='propagate')
        result_max = model.fit(fit_for_x + dely, x=x, method=method, params=params, nan_policy='propagate')

    elif fit_func == 'dip':
        if not len(param_initials) == 7:
            raise ValueError(
                "Must give 7 parameters to use the dip fitting function. Parameters may include NaN to fix a variable to its constant default."
            )

        model = Model(dip)
        params = Parameters()
        for i in range(0, len(param_initials)):
            params.add('p_' + str(i), value=param_initials[i])
        result = model.fit(y, x=x, method=method, params=params, nan_policy='propagate')

        fit_for_x = result.eval(result.params, x=x)
        dely = result.eval_uncertainty(sigma=sigma, x=x)
        result_min = model.fit(fit_for_x - dely, x=x, method=method, params=params, nan_policy='propagate')
        result_max = model.fit(fit_for_x + dely, x=x, method=method, params=params, nan_policy='propagate')

    elif fit_func == 'hardening':
        if not len(param_initials) == 3:
            raise ValueError(
                "Must give 3 parameters to use the hardening fitting function. Parameters may include NaN to fix a variable to its constant default."
            )

        model = Model(hardening)
        params = Parameters()
        for i in range(0, len(param_initials)):
            params.add('p_' + str(i), value=param_initials[i])
        result = model.fit(y, x=x, method=method, params=params, nan_policy='propagate')

        fit_for_x = result.eval(result.params, x=x)
        dely = result.eval_uncertainty(sigma=sigma, x=x)
        result_min = model.fit(fit_for_x - dely, x=x, method=method, params=params, nan_policy='propagate')
        result_max = model.fit(fit_for_x + dely, x=x, method=method, params=params, nan_policy='propagate')

    elif fit_func == 'swelling':
        if not len(param_initials) == 2:
            raise ValueError(
                "Must give 2 parameters to use the hardening fitting function. Parameters may include NaN to fix a variable to its constant default.")

        model = Model(swelling)
        params = Parameters()
        for i in range(0, len(param_initials)):
            params.add('p_' + str(i), value=param_initials[i])
        result = model.fit(y, x=x, method=method, params=params, nan_policy='propagate')

        fit_for_x = result.eval(result.params, x=x)
        dely = result.eval_uncertainty(sigma=sigma, x=x)
        result_min = model.fit(fit_for_x - dely, x=x, method=method, params=params, nan_policy='propagate')
        result_max = model.fit(fit_for_x + dely, x=x, method=method, params=params, nan_policy='propagate')

    else:
        raise ValueError(
            "Please give a valid fit_func string among: 'poly', 'weibull', 'exponential', 'transition', 'dip', 'hardening', 'swelling'!")

    return result, fit_for_x, dely, result_min, result_max




