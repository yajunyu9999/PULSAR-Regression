clear all

root_dataRead = '';
root_dataSave = '';

NumOfFs = 477; % 477, 469, 1163, 352, 639, 888, 2095, 1800, 3785 

T1 = readtable([root_dataRead, '\Features_img_mask_',num2str(NumOfFs),'_preprocessed_Ensemble.xlsx']);
T1_arr = table2array(T1);
fs_names = T1.Properties.VariableNames;

for num = 1:50
    aa=load(['E:\PULSAR_dose_image_mask\GeneratedData_16_FsReduced\train_test_index\train_test_idx_',num2str(num),'.mat']);
    train_idx = aa.train_idx;
    test_idx = aa.test_idx;
    train_fs = T1_arr(train_idx,2:end);
    train_label = T1_arr(train_idx,1);
    test_fs = T1_arr(test_idx,2:end);
    test_label = T1_arr(test_idx,1);

    train_data = array2table([train_label, train_fs], "VariableNames",fs_names);
    test_data = array2table([test_label, test_fs], "VariableNames",fs_names);

file_w=[root_dataSave, '\train_test_DataPreprocessing\Features_img_mask_',num2str(NumOfFs),'_preprocessed_Ensemble\Data_Loop',num2str(num),'.xlsx'];
writetable(train_data, file_w, 'Sheet','TrainData')
writetable(test_data, file_w, 'Sheet','TestData')

end
