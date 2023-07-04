function test_IDX = myknn(train_data,train_label,test_data)

ndata=length(test_data);
test_IDX=zeros(ndata,1);

Mdl = KDTreeSearcher(train_data);
[n,~] = knnsearch(Mdl,test_data,'k',1);

for data_num = 1 : ndata
    
    
    tempClass = train_label(n(data_num,:),1);
    result = mode(tempClass);
    test_IDX(data_num,1) = result;
    
end