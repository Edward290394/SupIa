%1 blanco 4898
%2 red    sobrante 
clc  
close all 
clear all
%leemos el archivo
xdataSet = readmatrix('winequalityN.xlsm');
%elimino la primera columna,porque los datos no son validos
xdataSet(:,1) = [];
%limpiar 
%elimino los datos que tengan errores
xdataSet(any(isnan(xdataSet),2),:)=[];
%doy la etiqueta segun loq ue corresponda en el archivo
%1= vino blanco
ydataSet(1:4898,1) =1;
%2=vino rojo 
ydataSet(4898:6463,1) =2;

%balancear data set 
%unimos dx y dy para reducir el data set
ds=[xdataSet,ydataSet];
totalWhite=sum(ydataSet == 1);
totalRed=sum(ydataSet == 2);
%calcula el exedente
totalEliminar=totalWhite-totalRed;
%Eliminar datos para balancear  al azar
for i = 1:totalEliminar
ds(1,:) = [];
end
%separamos el data set de la variable ds
xdataSet=ds(:,1:12);
ydataSet=ds(:,13);
%estandarizar 
for j=1:size(xdataSet,1)
    for i=1:size(xdataSet,2)
        xNewMatriz(j,i)=(xdataSet(j,i)-min(xdataSet(j,:)))/(max(xdataSet(j,:)-min(xdataSet(j,:))));
        if xNewMatriz(j,i)==0
            xNewMatriz(j,i)=0.001;
        end
    end
end

[row,column]= size(xNewMatriz);
ds=[xNewMatriz,ydataSet];
division =row*0.70;
xTrainClass=xNewMatriz(1:division,:);
yTrainClass=ydataSet(1:division,1);
xTestClass= xNewMatriz(division+1:end,:);
yTestClass= ydataSet(division+1:end,1);
targe=(yTrainClass==1:2);

%%
%Error de entrenamiento
errorTrain=0;
correctoTrain=0;
for j=1:size(xTrainClass,1)
yCorrecta=yTrainClass(j,1);
y=myNeuralNetworkFunction(xTrainClass(j,:));
[idx,class]=max(y);
yPre=class;
if yCorrecta==yPre;
    correctoTrain=correctoTrain+1;
end 
if yCorrecta~=yPre;
    errorTrain=errorTrain+1;
end 
end 
total = size(xTrainClass,1);
porcentajeErrorTrain =(errorTrain/total)*100;
porcentajeCorrectoTrain = (correctoTrain/total)*100;
display(porcentajeCorrectoTrain);
display(porcentajeErrorTrain);
%Errror de testeo 
errorTest=0;
correctoTest=0;
for j=1:size(xTestClass,1)
yCorrecta=yTestClass(j,1);
y=myNeuralNetworkFunction(xTestClass(j,:));
[idx,class]=max(y);
yPre=class;
if yCorrecta==yPre;
    correctoTest=correctoTest+1;
end 
if yCorrecta~=yPre;
    errorTest=errorTest+1;
end 
end 
total = size(xTestClass,1);
porcentajeErrorTest =(errorTest/total)*100;
porcentajeCorrectoTest = (correctoTest/total)*100;
display(porcentajeCorrectoTest);
display(porcentajeErrorTest);


%%
%svm

modelSVM = trainClassifierS(ds);
%Error de entrenamiento
errorTrain=0;
correctoTrain=0;
yPreTrain=modelSVM.predictFcn(xTrainClass);
for j=1:size(xTrainClass,1)
yCorrecta=yTrainClass(j,1);
yPreUnitario=yPreTrain(j,1);
if yCorrecta==yPreUnitario;
    correctoTrain=correctoTrain+1;
end 
if yCorrecta~=yPreUnitario;
    errorTrain=errorTrain+1;
end 
end 
total = size(xTrainClass,1);
porcentajeErrorTrain =(errorTrain/total)*100;
porcentajeCorrectoTrain = (correctoTrain/total)*100;
display(porcentajeCorrectoTrain);
display(porcentajeErrorTrain);
%Errror de testeo 
errorTest=0;
correctoTest=0;
yPreTest=modelSVM.predictFcn(xTestClass);
for j=1:size(xTestClass,1)
yCorrecta=yTestClass(j,1);
yPreUnitario=yPreTest(j,1);
if yCorrecta==yPreUnitario;
    correctoTest=correctoTest+1;
end 
if yCorrecta~=yPreUnitario;
    errorTest=errorTest+1;
end 
end 
total = size(xTestClass,1);
porcentajeErrorTest =(errorTest/total)*100;
porcentajeCorrectoTest = (correctoTest/total)*100;
display(porcentajeCorrectoTest);
display(porcentajeErrorTest);
