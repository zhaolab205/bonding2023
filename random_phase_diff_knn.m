%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by 
% Qi liu
% Weihua Zhao zarazhao@uestc.edu.cn
% Last edited June 2023
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('phase_diff_data.mat')
load('Kmeans_results.mat')
match_IDX = Kmeans_results{1,5}.IDX;
nper=10000;

HRF_delay = 8*6;
video_length = 470-HRF_delay;
tic
random_mean = zeros(nper,5);
random_mean_father = zeros(nper,5);
random_mean_mother = zeros(nper,5);
for per_num = 1 : nper
    disp(per_num)

    ori_inx = 1:53;
    rand_inx = ori_inx;
    stop_inx= 0;
    num = 0;
    while stop_inx == 0
        rand_inx = [randperm(25) randperm(28)+25];
        stop_inx = isnan(find(ori_inx-rand_inx == 0));
    end
    random_phase_diff = cos(phase_parent(:,:,:)-phase_child(:,:,rand_inx'));
    

    random_phase_diff_data = zeros(video_length*3*53,20);
    for dyad_num = 1 : 53
        
        for video_num = 1 : 3
            nvideo=(dyad_num-1)*3+video_num;
            random_phase_diff_data((nvideo-1)*video_length+1:nvideo*video_length,:) = random_phase_diff((video_num-1)*470+HRF_delay+1:video_num*470,:,dyad_num);
            
        end
    end
    
    
    %knn
    random_IDX = myknn(phase_diff_data,match_IDX,random_phase_diff_data);
    
    
    dyad_IDX = zeros(422*3,53);
    random_FN_pro = zeros(53,5);
    for dyad_num = 1 : 53
        dyad_IDX(:,dyad_num) = random_IDX((dyad_num-1)*422*3+1:dyad_num*422*3,1);
        for video_num = 1 : 3
            
            video_dyad_IDX = dyad_IDX((video_num-1)*422+1:video_num*422,dyad_num);
            for point_num = 1 : 422      
                random_FN_pro(dyad_num,video_dyad_IDX(point_num)) = random_FN_pro(dyad_num,video_dyad_IDX(point_num))+1;
            end
            
        end
    end
    random_FN_pro = random_FN_pro/1266;
    random_mean(per_num,:)=mean(random_FN_pro);
    random_mean_father(per_num,:)=mean(random_FN_pro(1:25,:));
    random_mean_mother(per_num,:)=mean(random_FN_pro(26:53,:));

end
