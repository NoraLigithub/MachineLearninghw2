function [w,y0,y1]=myLDA(data)
%clear; clc;
format long;
%data = csvread('melon.csv');
[num,dim] = size(data); 
%size�õ����ݵ�������ά��
x0=data(find(data(:,dim)==-1),1:dim-1);
x1=data(find(data(:,dim)==1),1:dim-1);
mu0=mean(x0);
%find(data(:,dim)==1)�ҵ����һ��Ϊ1���У���һ������ֵΪ����ɵ����������˴�����Ҫ�ڶ�������ֵ
%dataȡ���ص��������ȥ���һ�к��������
%data������λ�ÿ�����һ��������������λ�ÿ�����һ��������
%mean��ƽ��ֵ��mean(A)�õ�һ��������,mean(A,2)�õ�һ��������
mu1=mean(x1);
mu0=mu0';
% ת��Ϊ������
mu1=mu1';
% ת��Ϊ������
s0=0;
s1=0;
for i=1 :num
    x=data(i,1:dim-1)';
    % ת��Ϊ������
    y=data(i,dim);
    if y==-1
        s0=s0+(x-mu0)*(x-mu0)';
    else
        s1=s1+(x-mu1)*(x-mu1)';
    end
end
sw=s0+s1;
 w=pinv(sw)*(mu0-mu1);
 y0=w'*mu0; %���ĵ�λ��
 y1=w'*mu1; %���ĵ�λ��
end