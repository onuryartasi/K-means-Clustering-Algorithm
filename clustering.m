X=y';
n=size(X,2);
disp(n);
%X=round(1+127*rand(2,n));
K=4;
randInd=randperm(n,K);
C_means=X(:,randperm(n,K));
disp(C_means);

colorspec = {'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6]}; %definition color
Dist=zeros(K,n);
oldC=zeros(2,K);
cont=1;
maxIter=20;
t=0;
while(cont)
    t=t+1;
    Clusters=zeros(K,n);
    Centroid=zeros(1,K);
%Clustering and set element counts by distance
figure(t);
for i=1:n
     for j=1:K
        Dist(j,i)=sqrt((C_means(1,j)-X(1,i)).^2+(C_means(2,j)-X(2,i)).^2);
    end
    minim=0;
   for j=1:K
       if (minim==0)
           minim=Dist(j,i);
           position=j;
       end
       if(Dist(j,i)<minim)
           minim=Dist(j,i);
           position=j;
           
       end
   
   end 
      Clusters(position,i)=1;
      Centroid(position)=Centroid(position)+1;
     
        hold on
      plot(X(1,i),X(2,i),'Color',colorspec{position},'marker','*');
    
end

%Back-up of centroids
for j=1:K
  oldC(:,j)=C_means(:,j);
end
%Printing Centroid
C_means=zeros(2,K);

%New centroid calculation
for j=1:K
    for i=1:n
       if(Clusters(j,i)==1)
           C_means(:,j)=C_means(:,j)+X(:,i)/Centroid(j);
           
       elseif (Centroid(j)==0) %If there are no elements in the cluster, the old centroid
           C_means(:,j)=oldC(:,j);
           
       end
    end
end
%Centroid center control
cont= (C_means~=oldC) & t<maxIter;     
end
hold on
h2 = plot(C_means(1:2:2*K),C_means(2:2:2*K),'ko');
disp(C_means)