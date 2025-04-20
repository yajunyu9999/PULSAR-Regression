clear all
tic;

root_dataRead = '';
root_dataSave = '';

filepath = [root_dataRead, '\Relative GTV.xlsx'];
T = readtable(filepath);
ratio = T.Relative_GTV;


T1=readtable([root_dataRead, '\Features_Radiomics_init.xlsx']);
T_fs1 = T1(idx_50, 3:end);
fs1 = table2array(T_fs1);

T2=readtable([root_dataRead, '\Features_Radiomics_intra.xlsx']);
T_fs2 = T2(idx_50, 3:end);
fs2 = table2array(T_fs2);

T3=readtable([root_dataRead, '\Features_Dosiomics_init.xlsx']);
T_fs3 = T3(idx_50, 3:end);
fs3 = table2array(T_fs3);

T4=readtable([root_dataRead, '\Features_Dosiomics_intra.xlsx']);
T_fs4 = T4(idx_50, 3:end);
fs4 = table2array(T_fs4);

%% Preprocessing
[s1 s2]=size(fs1);
features1_2 = zeros(s1,s2);
features2_2 = zeros(s1,s2);
features3_2 = zeros(s1,s2);
features4_2 = zeros(s1,s2);

% Stadardization
features1_1 = normalize(fs1, 1);
features2_1 = normalize(fs2, 1);
features3_1 = normalize(fs3, 1);
features4_1 = normalize(fs4, 1);

% Normalization
for j = 1:s2
    features1_2(:,j)=features1_1(:,j)./norm(features1_1(:,j),2);
    features2_2(:,j)=features2_1(:,j)./norm(features2_1(:,j),2);
    features3_2(:,j)=features3_1(:,j)./norm(features3_1(:,j),2);
    features4_2(:,j)=features4_1(:,j)./norm(features4_1(:,j),2);
end

fs_delta_img = (features1_2-features2_2)./features1_2;
fs_delta_dose = (features3_2-features4_2)./features3_2;

% fs_whole = [features1_2, features2_2, fs_delta_img, features3_2, features4_2, fs_delta_dose];
% fs_whole = [fs1, fs2, fs_delta_img, fs3, fs4, fs_delta_dose];
% fs_whole = [fs_delta_img, fs_delta_dose];
fs_whole = [features3_2, features4_2, fs_delta_dose];


[s1, s2]=size(fs_whole);

features2_2 = zeros(s1,s2);

%% Preprocessing
% Stadardization
features2_1 = normalize(fs_whole, 1);

% Normalization
for j = 1:s2
    features2_2(:,j)=features2_1(:,j)./norm(features2_1(:,j),2);
end

T_fs_new = features2_2;
[nan_row, nan_col] = find(isnan(T_fs_new));
T_fs_new(:,nan_col) = [];

V = var(T_fs_new);
idx_V0 = find(V<0.001);
T_fs_new(:,idx_V0) = [];


G1 = T_fs_new'*T_fs_new;
G1_up = triu(G1, 1);

[row, col] = find(abs(G1_up) > 0.95);

T_fs_new(:,col) = [];

arr = [ratio, T_fs_new];
tbl_all = array2table(arr);

[num1, num2] = size(tbl_all);

writetable(tbl_all, [root_dataSave, '\Features_img_mask_',num2str(num2),'_preprocessed_Ensemble.xlsx'])

toc;