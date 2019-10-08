%% Reading the Groundtruths from the exported data of image labeller
%% here: imageLabelingSession.mat 
%% and converting them to txt file for readabilty

clc
clear all;
GT = load('gt_d_clutter.mat');
loc = GT.gTruth.LabelData.Variables; %extracts all the variables without headers
writecell(loc, 'readGT.txt')
