clear; clc;
format long;
data=csvread('melon.csv');
[w,y0,y1]=myLDA(data);
w
data=csvread('fourclass.csv');
[ave,std]=crossvalindTest(data,10)
[ave,std]=crossvalindTest(data,size(data,1))
data=csvread('heart.csv');
[ave,std]=crossvalindTest(data,10)
[ave,std]=crossvalindTest(data,size(data,1))
