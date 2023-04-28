# this is a module inteded to be used for the Kaggle "Predict Student Performance From Game Play"
# and is set up to be able to handle very large files while avoidng memory error.
# feature engineering and large file handling from https://www.kaggle.com/code/cdeotte/xgboost-baseline-0-680?scriptVersionId=123110383
import pandas as pd
import numpy as np
from json import load

class ProcessPipeline:
    def __init__(self, path: str, target: bool = True, train_or_test: str = "train"):
        self.path = path
        self.train_or_test = train_or_test if train_or_test in ["train", "test"] else "train" 
        self.target = target if type(target) is bool else False
        
        self.__create_chunks()
        if self.target: self.__target_practice()
        
        self.__glue()

    def __call__(self, return_file: str = "df"):
        return self.targets if return_file == "targets" else self.df

    def __glue(self):
        all_pieces = []
        for k in range(self.pieces):
            SKIPS = 0
            if k>0: SKIPS = range(1,self.skips[k]+1)
            train = pd.read_csv(str(self.path+self.train_or_test+".csv"),
                                nrows=self.reads[k], skiprows=SKIPS)
            df = self.__feature_engineer(train)
            all_pieces.append(df)

        del train
        self.df = pd.concat(all_pieces, axis=0)
            
    def __target_practice(self):
        self.targets = pd.read_csv(self.path+'train_labels.csv')
        self.targets['session'] = self.targets.session_id.apply(lambda x: int(x.split('_')[0]) )
        self.targets['q'] = self.targets.session_id.apply(lambda x: int(x.split('_')[-1][1:]) )

    def __create_chunks(self):
        # READ USER ID ONLY
        tmp = pd.read_csv(str(self.path+self.train_or_test+".csv"),usecols=[0])
        tmp = tmp.groupby('session_id').session_id.agg('count')

        # COMPUTE READS AND SKIPS
        self.pieces = 10
        self.chunk = int( np.ceil(len(tmp)/self.pieces) )

        self.reads = []
        self.skips = [0]
        for k in range(self.pieces):
            a = k*self.chunk
            b = (k+1)*self.chunk
            if b>len(tmp): b=len(tmp)
            r = tmp.iloc[a:b].sum()
            self.reads.append(r)
            self.skips.append(self.skips[-1]+r)

    def __feature_engineer(self, train):
        with open("vars.json") as f :
            vars = load(f)

            categorical_vars = vars["categorical_vars"]
            numerical_vars = vars["numerical_vars"]
            events = vars["events"]
        dfs = []
        for c in categorical_vars:
            tmp = train.groupby(['session_id','level_group'])[c].agg('nunique')
            tmp.name = tmp.name + '_nunique'
            dfs.append(tmp)
        for c in numerical_vars:
            tmp = train.groupby(['session_id','level_group'])[c].agg('mean')
            tmp.name = tmp.name + '_mean'
            dfs.append(tmp)
        for c in numerical_vars:
            tmp = train.groupby(['session_id','level_group'])[c].agg('std')
            tmp.name = tmp.name + '_std'
            dfs.append(tmp)
        for c in events: 
            train[c] = (train.event_name == c).astype('int8')
        for c in events + ['elapsed_time']:
            tmp = train.groupby(['session_id','level_group'])[c].agg('sum')
            tmp.name = tmp.name + '_sum'
            dfs.append(tmp)
        train = train.drop(events,axis=1)
            
        df = pd.concat(dfs,axis=1)
        df = df.fillna(-1)
        df = df.reset_index()
        df = df.set_index('session_id')
        return df


    