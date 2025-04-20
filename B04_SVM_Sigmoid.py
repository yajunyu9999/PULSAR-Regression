import numpy as np
import pandas as pd
from sklearn import svm
from sklearn.model_selection import GridSearchCV, RepeatedKFold, RepeatedStratifiedKFold
import os
import fnmatch
from scipy.io import loadmat

for NOF in [477, 469, 1163, 352, 639, 888, 2095, 1800, 3785]:
    NS = 15
    for DF_Select in [20]:

            accuracy_average = []
            accuracy_std = []
            NumOfFs = []
            arr_C = []
            arr_gamma = []

            rootpath = (r'...\FeatureSelected_Lasso_whole_sort_Ensemble_NOF'+str(NOF)+'\DF'+str(DF_Select)+'_NSelect'+str(NS))

            for LoopNum in range(1, 51):

                directory = (rootpath + '\Loop'+str(LoopNum))

                Score_R2 = np.zeros(NS)
                Y_Pred = np.zeros((NS, 15))
                Y_True = np.zeros((NS, 15))

                for sort_name in ['B_stat_abs', 'B_stat_cnt', 'RE_stat_cnt']:
                    cnt = 0
                    for NumFS in range(1, NS+1):

                        filepath_X_y = (directory + '\\'+sort_name+'_NumFS' + str(NumFS)+'.xlsx')
                        X_y_train = pd.read_excel(filepath_X_y, sheet_name='TrainSelect')
                        X_y_test = pd.read_excel(filepath_X_y, sheet_name='TestSelect')

                        label_train = X_y_train[X_y_train.columns[0]]
                        fs_train = X_y_train[X_y_train.columns[1:]]
                        label_test = X_y_test[X_y_test.columns[0]]
                        fs_test = X_y_test[X_y_test.columns[1:]]

                        # params
                        Cs = np.logspace(-10, 10, 21, base=2)
                        gammas = np.logspace(-10, 10, 21, base=2)
                        param_grid = dict(C=Cs, gamma=gammas)
                        grid = GridSearchCV(svm.SVR(kernel='sigmoid'), param_grid=param_grid, cv=5).fit(fs_train, label_train)
                        print(LoopNum, grid.best_params_)
                        C = grid.best_params_['C']
                        gamma = grid.best_params_['gamma']

                        cnt = cnt + 1

                        model_svm_rkf = svm.SVR(kernel='sigmoid', C=C, gamma=gamma).fit(fs_train, label_train)
                        # model_svm_rkf = svm.SVR(kernel='linear', C=C).fit(fs_train, label_train)
                        score_svm = model_svm_rkf.score(fs_test, label_test)
                        y_predict = model_svm_rkf.predict(fs_test)
                        print(score_svm)
                        Score_R2[cnt - 1] = score_svm

                        Y_Pred[cnt - 1, 0:len(y_predict)] = y_predict
                        Y_True[cnt - 1, 0:len(y_predict)] = label_test

                    np.savetxt(directory + '\Z_R2_'+sort_name+'_Sigmoid.txt', Score_R2, fmt='%f')
                    np.savetxt(directory + '\Z_y_true_'+sort_name+'_Sigmoid.txt', Y_True, fmt='%f')
                    np.savetxt(directory + '\Z_y_Pred_' + sort_name + '_Sigmoid.txt', Y_Pred, fmt='%f')
