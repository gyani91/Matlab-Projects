clear all;
close all;

% Loading data
load('swissmetro.mat')

%Parameters
K = 2;
N = size(Y,1);
elements = 1:N;

% Finding the number of Yes
yes = sum(Y);

% Kmeans Clustering
rng(4);
[Y_kmeans,C] = kmeans(X,K);
Y_kmeans(Y_kmeans==2)=0;

C_kmeans = confusionmat(Y, Y_kmeans);
Accuracy_kmeans = plot_cm(C_kmeans, N);

%Support Vector Machine
svmStruct = fitcsvm(X,Y,'KernelFunction','RBF');
Y_svm = svmStruct.predict(X);

C_svm = confusionmat(Y, Y_svm);
Accuracy_svm = plot_cm(C_svm, N);

%Logit Regression
[b, dev, stats] = glmfit(X, Y,'binomial','link','logit');
Y_logit = round(glmval(b, X,'logit'));

C_logit = confusionmat(Y, Y_logit);
Accuracy_logit = plot_cm(C_logit, N);

function acc = plot_cm(confmat,N)
figure;
numlabels = size(confmat, 1); % number of labels
labels = {'No', 'Yes'};

% calculate the percentage accuracies
confpercent = 100*confmat./N;

% plotting the colors
imagesc(confpercent);
title('Confusion Matrix');
xlabel('Output Class'); ylabel('Target Class');

% set the colormap
colormap(flipud(gray));

% Create strings from the matrix values and remove spaces
textStrings = num2str([confmat(:), confpercent(:)], '%d\n%.1f%%\n');
textStrings = strtrim(cellstr(textStrings));

% Create x and y coordinates for the strings and plot them
[x,y] = meshgrid(1:numlabels);
hStrings = text(x(:),y(:),textStrings(:), ...
    'HorizontalAlignment','center');

% Get the middle value of the color range
midValue = mean(get(gca,'CLim'));

% Choose white or black for the text color of the strings so
% they can be easily seen over the background color
textColors = repmat(confpercent(:) > midValue,1,3);
set(hStrings,{'Color'},num2cell(textColors,2));

% Setting the axis labels
set(gca,'XTick',1:numlabels,...
    'XTickLabel',labels,...
    'YTick',1:numlabels,...
    'YTickLabel',labels,...
    'TickLength',[0 0]);

%Calculate the accuracy for the model
acc = (confmat(1,1)+confmat(2,2))/N;
end
