function Cossimilarity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Functional connectivity analysis
%
% This function calculates the functional connections between the channels
% of per emotion,per trial and per subject 
% Input:
% ----- sub_anger; sub_fear; sub_happy; sub_sad: Fnirs data for each emotion
% Output:
% -----   cos_similarity: The cosine similarity between happy and anger/
%                         sad/ fear
%         angle_cos_sim: The Angle of cosine similarity
%              
% Written by 
% Qi liu
% Weihua Zhao zarazhao@uestc.edu.cn
% Last edited Sep 2022 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load sub_anger
load sub_fear
load sub_happy
load sub_sad
subNum = length(sub_anger);  %number of participants
for sub = 1 : subNum
    happy_anger_value(sub) = sum(sub_happy(sub,1:6).*sub_anger(sub,1:6));
    happy_fear_value(sub) = sum(sub_happy(sub,1:6).*sub_fear(sub,1:6));
    happy_sad_value(sub) = sum(sub_happy(sub,1:6).*sub_sad(sub,1:6));
    
    happy_square(sub) = sqrt(sum(sub_happy(sub,1:6).*sub_happy(sub,1:6)));
    anger_square(sub) = sqrt(sum(sub_anger(sub,1:6).*sub_anger(sub,1:6)));
    fear_square(sub) = sqrt(sum(sub_fear(sub,1:6).*sub_fear(sub,1:6)));
    sad_square(sub) = sqrt(sum(sub_sad(sub,1:6).*sub_sad(sub,1:6))); 
    
     %Calculate the cosine similarity happy-anger happy-fear happy-sad
    cos_similarity(sub,1) = happy_anger_value(sub)/(happy_square(sub).*anger_square(sub));
    cos_similarity(sub,2) = happy_fear_value(sub)/(happy_square(sub).*fear_square(sub));
    cos_similarity(sub,3) = happy_sad_value(sub)/(happy_square(sub).*sad_square(sub));
    
    %Calculate the angle of cosine similarity happy-anger happy-fear happy-sad
    angle_cos_sim(sub,1)=acos(cos_similarity(sub,1)).*180./pi;
    angle_cos_sim(sub,2)=acos(cos_similarity(sub,2)).*180./pi;
    angle_cos_sim(sub,3)=acos(cos_similarity(sub,3)).*180./pi;
end
save cos_similarity cos_similarity
save angle_cos_sim angle_cos_sim