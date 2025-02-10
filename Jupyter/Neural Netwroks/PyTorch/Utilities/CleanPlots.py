import numpy as np
from itertools import cycle
import matplotlib.pyplot as plt

def DATAPLOT(
        x_data_list=None,
        y_data_list=None,
        x_label=None,
        y_label=None,
        title=None,
        data_labels=None,
        marker_size=25,
        x_fit_list=None,
        y_fit_list=None,
        fit_labels=None,
        fit_line_width=1,
        fit_colors=None,
        xy_label_font_size=10,
        title_font_size=10,
        scale='linear',
        x_lim=None,
        y_lim=None,
        grid=True,
        legend_loc="best",
        legend_num_cols=2,
        legend_font_size=4,
        conf_int=False,
        sigma=3,
        dely=None
):
    """
    Plots scatter data and optional fit lines with customizable styles.

    :param x_data_list: List of lists, where each sublist contains the x-coordinates of a dataset. Each sublist represents a separate dataset for scatter plotting.
    :param y_data_list: List of y-coordinates for scatter data points. Must have the same length as x_data_list.
    :param x_label: Label for the x-axis.
    :param y_label: Label for the y-axis.
    :param title: Title of the plot.
    :param data_labels: List of labels for the scatter data sets. Defaults to "Data 1", "Data 2", etc., if None.
    :param marker_size: Size of the markers in the scatter plot. Default is 5.
    :param x_fit_list: List of x-coordinates for fit lines. Should match the length of y_fit_list if provided.
    :param y_fit_list: List of y-coordinates for fit lines. Should match the length of x_fit_list if provided.
    :param fit_line_width: Line width for the fit lines. Default is 1.
    :param fit_colors: List of colors for the fit lines. Defaults to black if not provided.
    :param xy_label_font_size: Font size for the x and y-axis labels. Default is 5.
    :param title_font_size: Font size for the plot title. Default is 5.
    :param scale: Scale of the axes. Options are 'linear', 'log-log', 'log-x', and 'log-y'. Default is 'linear'.
    :param x_lim: Tuple specifying x-axis limits, e.g., (xmin, xmax). Default is None.
    :param y_lim: Tuple specifying y-axis limits, e.g., (ymin, ymax). Default is None.
    :param grid: Whether to show grid lines on the plot. Default is False.
    :param legend_loc: Location of the legend. Default is "best".
    :param legend_num_cols: Number of columns in the legend. Default is 2.
    :param legend_font_size: Font size for the legend text. Default is 8.
    :return: None. Displays the plot.
    """

    # Input validation
    if x_data_list is not None and y_data_list is not None:
        if len(x_data_list) != len(y_data_list):
            raise ValueError("x_data_list and y_data_list must have the same length.")

    if x_fit_list is not None and y_fit_list is not None:
        if len(x_fit_list) != len(y_fit_list):
            raise ValueError("x_fit_list and y_fit_list must have the same length.")

    if scale not in ['linear', 'log-log', 'log-x', 'log-y']:
        raise ValueError("Scale must be 'linear', 'log-log', 'log-x', or 'log-y'.")

    if data_labels is None and x_data_list is not None:
        data_labels = [f'Data{i + 1}' for i in range(len(x_data_list))]

    if fit_labels is None and x_fit_list is not None:
        if data_labels is None:
            fit_labels = [f'Data{i + 1} fit' for i in range(len(x_fit_list))]
        else:
            fit_labels = [f'{i} fit' for i in data_labels]

    if conf_int and dely is None:
        raise ValueError("dely cannot be None.")

    # Plot initialization
    plt.figure(figsize=(6, 4), dpi=300)
    marker_cycle = cycle(('o', '^', 'v', '<', '>', 'd', 's', '*'))
    data_colors = plt.rcParams['axes.prop_cycle'].by_key()['color']

    # Plot data points if provided
    if x_data_list is not None and y_data_list is not None:
        for i, (x_data, y_data) in enumerate(zip(x_data_list, y_data_list)):
            plt.scatter(x_data, y_data, label=data_labels[i], color=data_colors[i], s=marker_size, marker=next(marker_cycle))

    # Plot fit lines if provided
    if x_fit_list is not None and y_fit_list is not None:
        if fit_colors is None:
            fit_colors = ['black']
        for i, (x_fit, y_fit) in enumerate(zip(x_fit_list, y_fit_list)):
            color = fit_colors[i % len(fit_colors)]
            plt.plot(x_fit, y_fit, label=f"{fit_labels[i]}", color=color, linewidth=fit_line_width)

            if conf_int:
                plt.fill_between(x_fit, y_fit - dely[i], y_fit + dely[i], color='blue', alpha=0.2, label=str(sigma) + "σ Conf. Int.")

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

    if x_lim:
        plt.xlim(x_lim)
    if y_lim:
        plt.ylim(y_lim)
    if grid:
        plt.grid(True)

    if x_label is not None:
        plt.xlabel(x_label, fontsize=xy_label_font_size)
    if y_label is not None:
        plt.ylabel(y_label, fontsize=xy_label_font_size)
    if title is not None:
        plt.title(title, fontsize=title_font_size)

    plt.legend(loc=legend_loc, fontsize=legend_font_size, ncol=legend_num_cols)
    plt.show()

