
function[pl,pob]= tsp(alp,matrixAdj,size)

pl=zeros(1,1);

seed=[1:size];

% creacion de nuetra poblacion permutada
for i=1:150
   pob(i,:)= seed(randperm(length(seed)));
    
end
pobsize=length(pob);
x=zeros(1,pobsize);
padres=zeros(10,size);


for k=1:alp
for i=1:pobsize
    x(i)=fitness(pob(i,:),matrixAdj);
end
%seleccion por ruleta;
x=x/sum(x);

for i=1:pobsize*.50
    a=rand;
    sig=0;
    for j=1:pobsize
    sig=sig+x(j);
      if sig>a
        padres(i,:)=pob(j,:);
        break;
      end
    end
end
sons=zeros(10,size);
 %cruza
 for i=1:2:pobsize*.50
    ar1=randi([1,pobsize*.50],1,1);
    ar2=randi([1,pobsize*.50],1,1);
    [ch1,ch2]=OX(padres(ar1,:),padres(ar2,:));
    sons(i,:)=ch1;
    sons(i+1,:)=ch2;
 end

%mutacion
len=length(sons);
    for j=1:4
         a=randi([1,pobsize*.50],1,1);         
         v=padres(a,:);
         sons(len+j,:)=v(randperm(length(v)));
    end
 len=length(pob);
 %add hujos to poblation 
 for j=1:length(sons)
       pob(len+j,:)=sons(j,:);
 end
 
 temp=pob;
  %evaluacion
   for i=1:length(pob(:,1))
      pob(i,size+1)=fitness(temp(i,:),matrixAdj);
   end
   temp=zeros(10,size);
   %sort poblation
   
   sortPop=sortrows(pob,size+1);
   for i=1:pobsize
    temp(i,:)=sortPop(i,1:size);
   end
   pob=temp;
  
   pl(k)=sortPop(1,size+1);
end
   pob=pob(1,:); 
end

%Cruza usando la cruza especial para permutaciones OX
function[child1,child2]=OX(a,b)
size=length(a);
    ar1=randi([1,size],1,1);
    ar2=randi([1,size],1,1);
    while(ar1==ar2)
        ar2=randi([1,size],1,1);
    end
    a1=min(ar1,ar2);
    a2=max(ar1,ar2);
    ox=a1;
    child1=a(a1:a2);
    child2=b(a1:a2);
    
    for i=1:length(a)
        concurrent=ox;
        if ox==length(a)
            ox=0;
        end
        cy1=a(concurrent);
        cy2=b(concurrent);
        if ~checkP(cy2,child1)
           child1(end+1)=cy2;
        end
        if ~checkP(cy1,child2)
           child2(end+1)=cy1;
        end      
        ox=ox+1;
    end
    shiftby=a1;
    child1=[child1(end - shiftby + 1: end), child1(1:end - shiftby)];
    child2=[child2(end - shiftby + 1: end), child2(1:end - shiftby)];
    
end
function fla=checkP(a,b)
    fla=false;   
    for i=1:length(b)
       if a==b(i)
           fla=true;
           break;
       end
    end
end

%la funcion objetivo evalua que tanto cuesta el viaje completo 
%lista ya permutada.
function[fit]=fitness(c,g)

   sigma=0;
    for i=1:length(c)-1
    sigma=sigma+g(c(i),c(i+1));
    end
    fit=sigma;
end



