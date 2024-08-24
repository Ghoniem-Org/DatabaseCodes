## Package imports and utility functions written by Indro:
# Installation note - conda install the following packages:
# jupyterlab numpy scipy sympy matplotlib pandas conda-forge::openpyxl conda-forge::lmfit conda-forge::numdifftools

import matplotlib.pyplot as plt
from lmfit import Model
# Slightly modified version from Professor Ghoniem
from matplotlib import pyplot as plt

    
def plot_data(x_data_list, y_data_list,T, fit_result, x_label, y_label, x_lim, y_lim, data_labels, material_property):
    
    def custom_multi_plot(x_data_list, y_data_list, x_fit_list=None, y_fit_list=None,
                      x_label=x_label, y_label=y_label, title=material_property,
                      scale='linear', font_size=16, xlim=x_lim, ylim=y_lim, 
                      grid=True, legend=True, data_labels=data_labels, fit_labels=None,
                      data_colors=None, fit_colors=None, data_marker_sizes=None, 
                      fit_line_widths=None, x_label_font_size=16, y_label_font_size=16, 
                      title_font_size=16, legend_font_size=12, legend_loc='lower left', legend_num_cols=2):

        if data_colors is None:
            data_colors = plt.rcParams['axes.prop_cycle'].by_key()['color']
        
        if fit_colors is None:
            fit_colors = plt.rcParams['axes.prop_cycle'].by_key()['color']
  
        plt.figure(figsize=(6, 4), dpi=300)

        # Ensure the data lists have the same length, and scatter plot data if provided
        if x_data_list is not None and y_data_list is not None:

            # Set default values if not provided
            if data_labels is None:
                data_labels = [f'Data {i+1}' for i in range(len(x_data_list))]

            if data_colors is None:
                data_colors = ['blue'] * len(x_data_list)

            if data_marker_sizes is None:
                data_marker_sizes = [20] * len(x_data_list)
            
            if len(x_data_list) != len(y_data_list):
                raise ValueError("x_data_list and y_data_list must have the same length.")
            
            for i, (x_data, y_data) in enumerate(zip(x_data_list, y_data_list)):
                plt.scatter(x_data, y_data, label=data_labels[i], color=data_colors[i], s=data_marker_sizes[i])

        # Ensure the fit lists have the same length, and scatter plot fit lines if provided
        if x_fit_list is not None and y_fit_list is not None:

            # Set default values if not provided
            if fit_labels is None:
                fit_labels = [f'Fit {i+1}' for i in range(len(x_fit_list))]
            
            if fit_colors is None:
                fit_colors = ['red'] * len(x_fit_list)
            
            if fit_line_widths is None:
                fit_line_widths = [3] * len(x_fit_list)
            
            if len(x_fit_list) != len(y_fit_list):
                raise ValueError("x_fit_list and y_fit_list must have the same length.")
            
            for i, (x_fit, y_fit) in enumerate(zip(x_fit_list, y_fit_list)):
                plt.plot(x_fit, y_fit, label=fit_labels[i], color=fit_colors[i], linewidth=fit_line_widths[i])

        plt.xlabel(x_label, fontsize=x_label_font_size)
        plt.ylabel(y_label, fontsize=y_label_font_size)
        plt.title(title, fontsize=title_font_size)
        
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
            
        if xlim:
            plt.xlim(xlim)
        if ylim:
            plt.ylim(ylim)
        if grid:
            plt.grid(True)
        if legend:
            plt.legend(loc=legend_loc, fontsize=legend_font_size, ncol=legend_num_cols)

    # Plot fit and confidence intervals from fitting result
    def plot_fit_and_conf(x, fit_result, sigma=2, legend=True, legend_font_size=12, 
                          legend_loc='lower left', legend_num_cols=2, fit_line_color='black',
                          pred_int_fill_color='grey', conf_int_fill_color='blue'):
        # Regression curve
        fit_for_x = fit_result.eval(fit_result.params, x=x)
        plt.plot(x, fit_for_x, color=fit_line_color, label='Data Fit')
        
        # Confidence interval
        dely = fit_result.eval_uncertainty(sigma=sigma, x=x)
        plt.fill_between(x, fit_for_x-dely, fit_for_x+dely,
                         color=conf_int_fill_color, alpha=0.2, label='95.45% Conf. Int.')

        if legend:
            plt.legend(loc=legend_loc, fontsize=legend_font_size, ncol=legend_num_cols)

    # Call the plotting functions
    custom_multi_plot(x_data_list, y_data_list)
    plot_fit_and_conf(T, fit_result)
    
    # Display the plot
    plt.show()
