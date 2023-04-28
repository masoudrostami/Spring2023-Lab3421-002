import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from statsmodels.stats.outliers_influence import variance_inflation_factor
from os import mkdir

def density_plots(df,PATH,NAMES,LEVEL,subfolder: str = "default/", subtype: str = "", color: str = "blue", save: bool = False):
    try:
        mkdir(str(PATH+'graphs/'+subfolder))
    except: pass
    
    for name in NAMES:
        df.drop(["level_group"],axis=1)[name].hist(density=True,color=color)
        plt.title(str(name+subtype+"_"+LEVEL))

        if save:
            plt.savefig(str(PATH+'graphs/'+subfolder+name+subtype+"_"+LEVEL+'.jpg'))
        plt.show()

def vif(df):
    train_vif = pd.DataFrame()
    train_vif["feature"] = df.drop("level_group",axis=1).columns

    train_vif["VIF"] = [variance_inflation_factor(df.drop("level_group",axis=1),i) for i in range(len(df.drop("level_group",axis=1).columns))]

    return train_vif