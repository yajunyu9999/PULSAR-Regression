clear all

root_dataRead = '';
root_dataSave = '';

NumSelect = 15;
DF_Select = 20;

for NOF = [477, 469, 1163, 352, 639, 888, 2095, 1800, 3785]

B_stat_abs = zeros(NOF-1, 50);
B_stat_cnt = zeros(NOF-1, 50);

RE_stat_abs = zeros(NOF-1, 50);
RE_stat_cnt = zeros(NOF-1, 50);

for num = 1:50

aa=load([root_dataRead, '\FeatureSelected_Lasso_whole_sort_Ensemble_NOF',num2str(NOF),'\FSelected_pytorch\Img_FS_Lasso_all_delta_Loop',num2str(num),'.mat']);
B1=aa.B1;
FitInfo = aa.FitInfo;
RE = aa.RE;

DF = FitInfo.DF;
idx_DF = find(DF>=DF_Select);

bb_B=B1(:,idx_DF(end));
bb_RE=RE(:,idx_DF(end));

[cc_B, I_B]=sort(abs(bb_B), 'descend');

B_stat_abs(I_B(1:NumSelect), num) = cc_B(1:NumSelect);
B_stat_cnt(I_B(1:NumSelect), num) = 1;

[cc_RE, I_RE]=sort(abs(bb_RE), 'ascend');
idx = find(cc_RE~=0);

RE_stat_abs(I_RE(idx(1):idx(1)+NumSelect-1), num) = cc_RE(idx(1):idx(1)+NumSelect-1);
RE_stat_cnt(I_RE(idx(1):idx(1)+NumSelect-1), num) = 1;

end
    
B_stat_abs_avg = mean(B_stat_abs, 2);
B_stat_cnt_avg = mean(B_stat_cnt, 2);
RE_stat_abs_avg = mean(RE_stat_abs, 2);
RE_stat_cnt_avg = mean(RE_stat_cnt, 2);

figure(4)
subplot(4,1,1)
bar(B_stat_abs_avg, 2, 'r')
set(gca, 'FontSize', 15)
subplot(4,1,2)
bar(B_stat_cnt_avg, 2, 'r')
set(gca, 'FontSize', 15)
subplot(4,1,3)
bar(RE_stat_abs_avg, 2, 'r')
set(gca, 'FontSize', 15)
subplot(4,1,4)
bar(RE_stat_cnt_avg, 2, 'r')
set(gca, 'FontSize', 15)
xlabel('Index of full features')

[A1, I_B_stat_abs] = sort(B_stat_abs_avg, "descend");
[A2, I_B_stat_cnt] = sort(B_stat_cnt_avg, "descend");
[A3, I_RE_stat_abs] = sort(RE_stat_abs_avg, "descend");
[A4, I_RE_stat_cnt] = sort(RE_stat_cnt_avg, "descend");

save([root_dataSave, '\FeatureSelected_Lasso_whole_sort_Ensemble_NOF',num2str(NOF),'\Rank_nonCS_DF',num2str(DF_Select),'_NSelect',num2str(NumSelect),'.mat'],...
    "I_B_stat_abs","I_B_stat_cnt","I_RE_stat_abs","I_RE_stat_cnt")
end
