clc
close all 
clear all
%% REGRESION LOGÍSTICA
X=[3 2.11 1.2];
w=[0.5 -0.8 0.96 0.79];
%introducido el bias
x=[1, X];
%regrecion logistica
res=logsig(x*w');
if res>=0.5
    eti=1;
else
    eti=0;
end
fprintf('Valor Etiqueta %d \n', eti);

%% TESTEO DEL PERCEPTRON
% 2. Realizar el ejercicio de testeo del perceptrón el siguiente ejercicio.
dsX =[5 2 7; 6 5 7; 2 2 1];
dsY = [1 1 -1];

%Matriz de pesos
W=[0.8 0.25 -1.42 0.13];

%Bias
fil=size(dsX,1);
bias=[1;1;1];
%bias=ones(fil,1);
dsX=[bias,dsX];
dsX;
%etiquetas predichas
yHat=[];

for i=1: fil
    %realizar el producto punto entre los pesos (W) y valores de testeo (dsX)
    %r=dot(dsX(i,:),W);
    r=dsX(i,:)*W';
    if r>=0
        yHat=[yHat,1];
    else
        yHat=[yHat,-1];
    end

end

%porcentaje de acierto
aciertos=100*sum(yHat==dsY)/length(dsY)

%porcentaje de error
error=100*sum(yHat ~= dsY)/length(dsY)

%%
%vendedor de una prestigiosa fábrica de la ciudad de Ambato necesita recorrer
%las ciudades 

