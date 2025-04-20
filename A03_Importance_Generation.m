clear all

root_dataRead = '';
root_dataSave = '';

for NOF = [477, 469, 1163, 352, 639, 888, 2095, 1800, 3785]

for num = 1:50
sheetname = [root_dataRead, '\train_test_DataPreprocessing\Features_img_mask_',num2str(NOF),'_preprocessed_Ensemble\Data_Loop',num2str(num),'.xlsx'];
    TrainData = readtable(sheetname, 'Sheet','TrainData');
    TestData = readtable(sheetname, 'Sheet','TestData');

    train_arr = table2array(TrainData);

    train_ratio = train_arr(:,1);
    train_fs = train_arr(:,2:end);

[B1, FitInfo] = lasso(train_fs,train_ratio,'MaxIter',1e8,'Options',statset('UseParallel',true),'Alpha',1,'NumLambda',100,'LambdaRatio',1e-2);

RE = zeros(size(B1));
[row, col] = find(B1~=0);

for kk = 1:size(col,1)
    idx1 = row(kk);
    idx2 = col(kk);
    xx = B1(idx1, idx2);
    Fi = train_fs(:,idx1);

    res = norm((train_ratio-Fi*xx), 2);
    RE(idx1, idx2) = res;
end

save([root_dataSave, '\FeatureSelected_Lasso_whole_sort_Ensemble_NOF',num2str(NOF),'\FSelected_pytorch\Img_FS_Lasso_all_delta_Loop',num2str(num),'.mat'],"B1","FitInfo","RE")

end
end
