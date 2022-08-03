clc
clear 
close all
%Reducir o eliminar el ruido presente en la imagen
%La delimitación se sobre ponga en la imagen original en RGB
img = imread('imgNoise.jpg');
subplot(3,3,1);
imshow(img);
title('imagene original');
%obtengo cada expectro
imgR =img(:,:,1);
imgG =img(:,:,2);
imgB =img(:,:,3);
%Fin de primera pregunta
%reducir el ruido 
imgR=medfilt2(imgR);
imgG=medfilt2(imgG);
imgB=medfilt2(imgB);
%recontruir imagen
newimgR(:,:,1)=imgR;
newimgR(:,:,2)=imgG;
newimgR(:,:,3)=imgB;
%Mostra Imagen
subplot(3,3,2);
imshow(newimgR);
title('imagene sin ruido');
%fin
%Se desea observar la parte rojiza del cielo 
%en menor intensidad e incrementar la tonalidad azul del cielo
%obtener los nuevos expectros
imgRed=newimgR(:,:,1);
imgGree=newimgR(:,:,2);
imgBlue=newimgR(:,:,3);
imgRed=imgRed-75;
imgBlu=imgBlue+95;
ImgUnit(:,:,1)=imgRed;
ImgUnit(:,:,2)=imgGree;
ImgUnit(:,:,3)=imgBlue;
%Mostrar imagen
subplot(3,3,3);
imshow(ImgUnit);
title('imagene rojiza menor intensidad y azul mayor');
%La zona de la imagen en la que se observa unos árboles tomen algo de tonalidad verde
imgGren(:,:,2)=ImgUnit(:,:,2);
aux=find(imgGren<10);
for i=1: length(aux)
    imgGren(aux(i))=255;
end
imgGren(:,:,1)=ImgUnit(:,:,1);
imgGren(:,:,3)=ImgUnit(:,:,3);
subplot(3,3,4);
imshow(imgGren);
title('arboles tonalidad verde ');
%4:Se seleccione y se defina la zona de los árboles
%La delimitación se sobre ponga en la imagen original en
ig=rgb2gray(img);
ig=imbinarize(ig,0.1);
ig=~ig;
props = regionprops(ig,'Area','Perimeter','BoundingBox','Image');
a = find([props.Area] == max([props.Area]));
subplot(3,3,5);
imshow(imgGren);
title("4 DEFINIR LA ZONA DE LOS ARBOLES");
rectangle('Position',props(a).BoundingBox, 'EdgeColor','r', 'LineWidth', 2);
%La delimitación se sobre ponga en la imagen original en RGB
%bordes
subplot(3,3,6)
imshow(newimgR);
title("delimitacion imagen original");
hold on
borde=bwboundaries(ig);
for i=1:length(borde)
 border = borde(i);
plot(border{1 ,1}(:,2),border{1 ,1}(:,1), 'r','LineWidth',2);
end
hold off





