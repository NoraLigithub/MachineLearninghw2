function [finalAve,finalStd]=crossvalindTest(data,fold)
[num,dim]=size(data);
% indices = crossvalind('kfold',num,fold);
% 列向量划分结果
errorResult=[]; %%最终得到的错误率向量
totalTimes=1;
for times=1:totalTimes
    %fold次随机化
    indices = crossvalind('kfold',num,fold);
% 列向量划分结果
errorVector=[]; %每一次的结果都是进行一次fold折交叉检验的结果
for i=1:fold
    test=(indices==i); %indices表示第几次可作为测试集
    train = ~test; %test与train是两个列向量，只有0与1的logic值
    dataTest=data(test,:); %参数可以是逻辑值构成的列向量
    dataTrain=data(train,:);
     [w,y0,y1]=myLDA(dataTrain);%得到参数
     [p,q]=size(dataTest);
     errorNum=0;
     for j=1:p
         y=w'* (dataTest(j,1:q-1)'); %不要忘记转置，应该为列向量
         dis0=abs(y-y0);
         dis1=abs(y-y1);
         if (dis0<=dis1) && (dataTest(j,q)==1)
             errorNum = errorNum+1;
         else if (dis0>dis1) && (dataTest(j,q)==-1)
                 errorNum=errorNum+1;
             end
         end
     end
     errorRate=errorNum/p;
     errorVector=[errorVector,errorRate];
end
ave=mean(errorVector,2);
% std(errorVector,0,2);
errorResult=[errorResult,ave];
errorVector;
end
errorResult;
finalAve=0;
finalStd=0;
if(totalTimes==1)
    finalAve=ave;
    finalStd=std(errorVector,0,2);
else
    finalAve=mean(errorResult,2);
    finalStd=std(errorResult,0,2);
end
end