function [finalAve,finalStd]=crossvalindTest(data,fold)
[num,dim]=size(data);
% indices = crossvalind('kfold',num,fold);
% ���������ֽ��
errorResult=[]; %%���յõ��Ĵ���������
totalTimes=1;
for times=1:totalTimes
    %fold�������
    indices = crossvalind('kfold',num,fold);
% ���������ֽ��
errorVector=[]; %ÿһ�εĽ�����ǽ���һ��fold�۽������Ľ��
for i=1:fold
    test=(indices==i); %indices��ʾ�ڼ��ο���Ϊ���Լ�
    train = ~test; %test��train��������������ֻ��0��1��logicֵ
    dataTest=data(test,:); %�����������߼�ֵ���ɵ�������
    dataTrain=data(train,:);
     [w,y0,y1]=myLDA(dataTrain);%�õ�����
     [p,q]=size(dataTest);
     errorNum=0;
     for j=1:p
         y=w'* (dataTest(j,1:q-1)'); %��Ҫ����ת�ã�Ӧ��Ϊ������
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