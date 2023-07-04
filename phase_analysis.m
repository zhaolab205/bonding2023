%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by 
% Qi liu
% Weihua Zhao zarazhao@uestc.edu.cn
% Last edited June 2023
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


load('play_channel_signal_0.01-0.09.mat')
signal_data = channel_signal;
ndyad = length(channel_signal)-1;

HRF_delay = 47;
ncha = 20;
play_length = 3749;  % 8min
tic


parent_data = zeros(play_length+1+2*HRF_delay,ndyad);
child_data = zeros(play_length+1+2*HRF_delay,ndyad);
phase_diff = zeros(play_length+1+2*HRF_delay,20,ndyad);
phase_parent = zeros(play_length+1+2*HRF_delay,20,ndyad);
phase_child = zeros(play_length+1+2*HRF_delay,20,ndyad);
for dyad_num = 1 : ndyad
    
    

    parent_data= signal_data{dyad_num+1,2}(470:470+play_length+2*HRF_delay,:);
    child_data= signal_data{dyad_num+1,3}(470:470+play_length+2*HRF_delay,:);
    
    hilbert_parent = hilbert(parent_data); %form the analytical signal
    hilbert_child = hilbert(child_data); %form the analytical signal
    
    phase_parent(:,:,dyad_num) = unwrap(angle(hilbert_parent));
    phase_child(:,:,dyad_num) = unwrap(angle(hilbert_child));
    phase_diff(:,:,dyad_num) = cos(unwrap(angle(hilbert_parent))-unwrap(angle(hilbert_child))); %inst phase
    
    
end


