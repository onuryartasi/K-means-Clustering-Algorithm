n=200;
X=round(1+127*rand(2,n));
cluster=7;
C=round(1+127*rand(2,cluster));
colorspec = {'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6]}; %kümelere renk atama
Dist=zeros(cluster,n);
Clusters=zeros(cluster,n);
oldC=zeros(2,cluster);
Centroid=zeros(1,cluster);


 
%Distance calculation
for i=1:n
    for j=1:cluster
        Dist(j,i)=sqrt((C(1,j)-X(1,i)).^2+(C(2,j)-X(2,i)).^2);
    end
end

%Clustering and set element counts by distance
for i=1:n
    min=0;
   for j=1:cluster
       if (min==0)
           min=Dist(j,i);
           position=j;
       end
       if(Dist(j,i)<min)
           min=Dist(j,i);
           position=j;
           
       end
   
   end 
      Clusters(position,i)=1;
      Centroid(position)=Centroid(position)+1;
        hold on
      plot(X(1,i),X(2,i),'Color',colorspec{position},'marker','*');
    
end

%Back-up of centroids
for j=1:cluster
  oldC(1,j)=C(1,j);
  oldC(2,j)=C(2,j);
    
end
%Printing Centroid

hold on
h1=plot(C(1:cluster-1:2*cluster),C(2:cluster-1:2*cluster),'yx');

C=zeros(2,cluster);

%New centroid calculation
for j=1:cluster
    for i=1:n
       if(Clusters(j,i)==1)
           C(1,j)=C(1,j)+X(1,i)/Centroid(j);
           C(2,j)=C(2,j)+X(2,i)/Centroid(j);
       elseif (Centroid(j)==0) %If there are no elements in the cluster, the old centroid
           C(1,j)=oldC(1,j);
           C(2,j)=oldC(2,j);
       end
      
    end
    
end

hold on
set(h1,'Visible','off')
h2 = plot(C(1:2:2*cluster),C(2:2:2*cluster),'ko');


disp(C)


