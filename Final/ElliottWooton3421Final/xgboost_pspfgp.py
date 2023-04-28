import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

from sklearn.model_selection import KFold, GroupKFold
from xgboost import XGBClassifier
from sklearn.metrics import f1_score

class XGBoost_pspfgp():
    def __init__(self,
                 fold_splits: int = 5,
                 objective: str = "binary:logistic",
                 eval_metric: str = "logloss",
                 learning_rate: float = 0.05,
                 max_depth: int = 4,
                 n_estimators: int = 1000,
                 early_stopping_rounds: int = 50,
                 tree_method: str = "hist",
                 subsample: float = 0.8,
                 colsample_bytree: float = 0.4):
    
        self.__fold_splits = fold_splits 
        self.__xgb_params = {
            'objective' :objective,
            'eval_metric':eval_metric,
            'learning_rate': learning_rate,
            'max_depth': max_depth,
            'n_estimators': n_estimators,
            'early_stopping_rounds': early_stopping_rounds,
            'tree_method':tree_method,
            'subsample':subsample,
            'colsample_bytree': colsample_bytree
            }
        
        self.__gkf = GroupKFold(n_splits=self.__fold_splits)
        self.__models = {}
        
        self.__clf = XGBClassifier(**self.__xgb_params)

    def __repr__(self):
        return str(self.__clf)
    
    def fit(self, X, y, name):
        self.__name = name
        FEATURES = [c for c in X.columns if c != 'level_group']
        ALL_USERS = X.index.unique()

        self.__oof = pd.DataFrame(data=np.zeros((len(ALL_USERS),18)), index=ALL_USERS)
        
        for i, (train_index, test_index) in enumerate(self.__gkf.split(X=X, groups=X.index)):
            print('#'*25)
            print('### Fold',i+1)
            print('#'*25)

            for t in range(1,19):
            
                if t<=3: grp = '0-4'
                elif t<=13: grp = '5-12'
                elif t<=22: grp = '13-22'
                    
                train_x = X.iloc[train_index]
                train_x = train_x.loc[train_x.level_group == grp]
                train_users = train_x.index.values
                train_y = y.loc[y.q==t].set_index('session').loc[train_users]
                
                valid_x = X.iloc[test_index]
                valid_x = valid_x.loc[valid_x.level_group == grp]
                valid_users = valid_x.index.values
                valid_y = y.loc[y.q==t].set_index('session').loc[valid_users]
                
                clf = XGBClassifier(**self.__xgb_params)
                clf.fit(train_x[FEATURES].astype('float32'), train_y['correct'],
                        eval_set=[ (valid_x[FEATURES].astype('float32'), valid_y['correct']) ],
                        verbose=0)
                print(f'{t}({clf.best_ntree_limit}), ',end='')
                
                self.__models[f'{grp}_{t}'] = clf
                self.__oof.loc[valid_users, t-1] = clf.predict_proba(valid_x[FEATURES].astype('float32'))[:,1]
            
            print()

        self.__true = self.__oof.copy()
        for k in range(18):
            tmp = y.loc[y.q == k+1].set_index('session').loc[ALL_USERS]
            self.__true[k] = tmp.correct.values

        self.__scores = []; self.__thresholds = []
        self.__best_score = 0; self.__best_threshold = 0;

        for threshold in np.arange(0.4,0.81,0.01):
            preds = (self.__oof.values.reshape((-1))>threshold).astype('int')
            m = f1_score(self.__true.values.reshape((-1)), preds, average='macro')   
            self.__scores.append(m)
            self.__thresholds.append(threshold)
            if m>self.__best_score:
                self.__best_score = m
                self.__best_threshold = threshold

    def scores_(self,):
        return self.__scores

    def eval_(self,):
        plt.figure(figsize=(20,5))
        plt.plot(self.__thresholds,self.__scores,'-o',color='blue')
        plt.scatter([self.__best_threshold], [self.__best_score], color='blue', s=300, alpha=1)
        plt.xlabel('Threshold',size=14)
        plt.ylabel('Validation F1 Score',size=14)
        plt.title(f'{self.__name} Threshold vs. F1_Score with Best F1_Score = {self.__best_score:.3f} at Best Threshold = {self.__best_threshold:.3}',size=18)
        plt.show()

    def f1 (self,):
        print('When using optimal threshold...')
        for k in range(18):

            m = f1_score(self.__true[k].values, (self.__oof[k].values>self.__best_threshold).astype('int'), average='macro')
            print(f'Q{k+1}: F1 =',m)
            
        m = f1_score(self.__true.values.reshape((-1)), (self.__oof.values.reshape((-1))>self.__best_threshold).astype('int'), average='macro')
        print('==> Overall F1 =',m)

