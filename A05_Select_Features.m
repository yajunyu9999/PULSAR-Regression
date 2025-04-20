clear all

root_dataRead = '';
root_dataSave = '';

NumSelect = 15;
DF_Select = 20;

for NOF = [477, 469, 1163, 352, 639, 888, 2095, 1800, 3785]

file_path = [root_dataRead, '\FeatureSelected_Lasso_whole_sort_Ensemble_NOF',num2str(NOF)];

aa=load([file_path,'\Rank_nonCS_DF',num2str(DF_Select),'_NSelect',num2str(NumSelect),'.mat']);
I_B_stat_abs = aa.I_B_stat_abs;
I_B_stat_cnt = aa.I_B_stat_cnt;
I_RE_stat_cnt = aa.I_RE_stat_cnt;

for num = 1:50
sheetname=[root_dataRead, '\train_test_DataPreprocessing\Features_img_mask_',num2str(NOF),'_preprocessed_Ensemble\Data_Loop',num2str(num),'.xlsx'];
    TrainData = readtable(sheetname, 'Sheet','TrainData');
    TestData = readtable(sheetname, 'Sheet','TestData');

%%
    for num_fs = 1:NumSelect
        idx = I_B_stat_abs(1:num_fs);
        TrainSelect = TrainData(:, [1; idx+1]);
        TestSelect = TestData(:, [1; idx+1]);
file_w=[root_dataSave,'\DF',num2str(DF_Select),'_NSelect',num2str(NumSelect),'\Loop',num2str(num),'\B_stat_abs_NumFS',num2str(num_fs),'.xlsx'];
        writetable(TrainSelect, file_w, 'Sheet','TrainSelect')
        writetable(TestSelect, file_w, 'Sheet','TestSelect')
    end
%%
    for num_fs = 1:NumSelect
        idx = I_B_stat_cnt(1:num_fs);
        TrainSelect = TrainData(:, [1; idx+1]);
        TestSelect = TestData(:, [1; idx+1]);
file_w=[root_dataSave,'\DF',num2str(DF_Select),'_NSelect',num2str(NumSelect),'\Loop',num2str(num),'\B_stat_cnt_NumFS',num2str(num_fs),'.xlsx'];
        writetable(TrainSelect, file_w, 'Sheet','TrainSelect')
        writetable(TestSelect, file_w, 'Sheet','TestSelect')
    end
%%
    for num_fs = 1:NumSelect
        idx = I_RE_stat_cnt(1:num_fs);
        TrainSelect = TrainData(:, [1; idx+1]);
        TestSelect = TestData(:, [1; idx+1]);
file_w=[root_dataSave,'\DF',num2str(DF_Select),'_NSelect',num2str(NumSelect),'\Loop',num2str(num),'\RE_stat_cnt_NumFS',num2str(num_fs),'.xlsx'];
        writetable(TrainSelect, file_w, 'Sheet','TrainSelect')
        writetable(TestSelect, file_w, 'Sheet','TestSelect')
    end

end

end
