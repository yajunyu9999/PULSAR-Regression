Paper: Leveraging Support Vector Regression, Radiomics and Dosiomics for Outcome Prediction in Personalized Ultra-fractionated Stereotactic Adaptive Radiotherapy (PULSAR)

Authors: Yajun Yu, Steve Jiang, Robert Timmerman, Hao Peng

Description:

This README file describes the data and codes accompanying the above publication.

Files:
1. Train_test_index folder: Including 50 random train-test split indices.
2. Relative GTV.xlsx: Relative GTVs at follow-up compared to the pre-treatment.
3. Features_Radiomics_init.xlsx: Extracted initial radiomic features.
4. Features_Radiomics_intra.xlsx: Extracted intra-treatment radiomic features. 
5. Features_Dosiomics_init.xlsx: Extracted initial dosiomic features.
6. Features_Dosiomics_intra.xlsx: Extracted intra-treatment dosiomic features.

Codes:
7. A01_FeaturePreprocessing.m: Feature preprocessing analysis.
8. A02_Train_Test_Generation.m: 
9. A03_Importance_Generation.m: 
10. A04_Importance_Sort.m: 
11. A05_Select_Features.m: 
12. B01_SVM_Linear.py: 
13. B02_SVM_RBF.py: 
14. B03_SVM_Poly.py: 
15. B04_SVM_Sigmoid.py: 
