%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by 
% Qi liu
% Weihua Zhao zarazhao@uestc.edu.cn
% Last edited June 2023
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('phase_diff_data.mat')

maxk=10;
for k = 2 : maxk 
    disp(['Calculating for ' num2str(k) 'clusters'])
    [IDX, C, SUMD, D]=kmeans(phase_diff_data,k,'Distance','cityblock','Start','plus','MaxIter',10000,'Replicates',20,'Display','final'); %,'Options',opt);   
    Kmeans_results{k}.IDX=IDX;    
    Kmeans_results{k}.C=C;       
    Kmeans_results{k}.SUMD=SUMD; 
    Kmeans_results{k}.D=D; 
end

save Kmeans_results.mat Kmeans_results

Tol_CSS=zeros(10,1);     
for k = 2 : 10
    
     disp(['Calculating for ' num2str(k) 'clusters'])
     
     for clu_num = 1:k
         for win_num = 1:length(phase_diff_data)
             if Kmeans_results{1,k}.IDX(win_num) == clu_num
                single_CSS = (phase_diff_data(win_num,:) - Kmeans_results{1,k}.C(clu_num,:))*(phase_diff_data(win_num,:) - Kmeans_results{1,k}.C(clu_num,:))';
                Tol_CSS(k)=Tol_CSS(k)+single_CSS;
             end
         end
     end
     
end

plot(2:10,Tol_CSS(2:10),'o');
hold on
plot(2:10,Tol_CSS(2:10));


