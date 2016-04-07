function [w,y0,y1]=myLDA(data)
%clear; clc;
format long;
%data = csvread('melon.csv');
[num,dim] = size(data); 
%size得到数据的行数与维度
x0=data(find(data(:,dim)==-1),1:dim-1);
x1=data(find(data(:,dim)==1),1:dim-1);
mu0=mean(x0);
%find(data(:,dim)==1)找到最后一列为1的行，第一个返回值为行组成的列向量，此处不需要第二个返回值
%data取返回的行数与减去最后一列后的其他列
%data行数的位置可以用一个列向量，列数位置可以用一个行向量
%mean求平均值，mean(A)得到一个行向量,mean(A,2)得到一个列向量
mu1=mean(x1);
mu0=mu0';
% 转置为列向量
mu1=mu1';
% 转置为列向量
s0=0;
s1=0;
for i=1 :num
    x=data(i,1:dim-1)';
    % 转置为列向量
    y=data(i,dim);
    if y==-1
        s0=s0+(x-mu0)*(x-mu0)';
    else
        s1=s1+(x-mu1)*(x-mu1)';
    end
end
sw=s0+s1;
 w=pinv(sw)*(mu0-mu1);
 y0=w'*mu0; %中心点位置
 y1=w'*mu1; %中心点位置
end