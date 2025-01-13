import pandas as pd
import numpy as np
from IPython.display import display

def LOADDATA(excel_filename, material_property, printdata = True):
    temp_data = pd.read_excel(excel_filename, sheet_name=material_property)
    temp_data = temp_data.dropna(how='all', axis=1)
    temp_data = temp_data.dropna(how='all', axis=0)

    df = {}
    for i, col in enumerate(temp_data.columns):
        previous_col = temp_data.columns[i - 1]
        if 'Unnamed' in col:
            col_name = f"{previous_col} {temp_data.iloc[0, i]}"
        else:
            col_name = f"{col} {temp_data.iloc[0, i]}"

        col_name = col_name.replace(",", "")
        df[col_name] = pd.to_numeric(temp_data.iloc[1:, i], errors='coerce').dropna()

    df = pd.DataFrame(df)
    if printdata:
        display(df.dropna(how='all'))

    return df

def concatenate_and_sort(x_list, y_list):

    x_concat = np.concatenate(x_list)
    y_concat = np.concatenate(y_list)

    x_sorted_indices = x_concat.argsort()
    x_sorted = x_concat[x_sorted_indices]
    y_sorted = y_concat[x_sorted_indices]

    return x_sorted, y_sorted