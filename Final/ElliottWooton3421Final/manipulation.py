import pandas as pd
import numpy as np

from sklearn.preprocessing import StandardScaler

def min_max(df):
    temp = df.drop('level_group', axis=1)
    names = temp.drop(['checkpoint_sum','map_click_sum','notification_click_sum'],axis=1).columns

    for name in names:
        UIQR=temp[name].quantile(.75)+1.5*(temp[name].quantile(.75)-temp[name].quantile(.25))
        LIQR=temp[name].quantile(.25)-1.5*(temp[name].quantile(.75)-temp[name].quantile(.25))
        temp[name] = np.where(temp[name]<LIQR, temp[name].median(), temp[name])
        temp[name] = np.where(temp[name]>UIQR, temp[name].median(), temp[name])

    temp = (temp-temp.min())/(temp.max()-temp.min())
    new_df = pd.concat([df.level_group, temp],axis=1)
    return new_df
    
def std(df):
    std_scaler = StandardScaler()
    temp = df.drop('level_group', axis=1)
    temp = std_scaler.fit_transform(temp)

    temp = pd.DataFrame(temp)
    temp = temp.set_axis(list(df.index),axis=0)
    temp.index.name = 'session_id'
    temp = temp.set_axis(df.drop('level_group', axis=1).columns.values,axis=1)
    new_temp = pd.concat([df.level_group, temp],axis=1)
    return new_temp