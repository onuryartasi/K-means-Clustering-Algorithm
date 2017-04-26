n=200;
X=round(1+127*rand(2,n));
cluster=3;
C=round(1+127*rand(2,cluster));
colorspec = {'k','b','r','g','y',[.5 .6 .7],[.8 .2 .6]}; %kümelere renk atama
Dist=zeros(cluster,n);
Clusters=zeros(cluster,n);
oldC=zeros(2,cluster);
Centroid=zeros(1,cluster);

%uzaklýk hesaplama
for i=1:n
    for j=1:cluster
        Dist(j,i)=sqrt((C(1,j)-X(1,i)).^2+(C(2,j)-X(2,i)).^2);
    end
end

%Uzaklýklara göre Kümeleme iþlemi ve eleman sayýlarý
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

%Centroidlerin yedeklenmesi
for j=1:cluster
  oldC(1,j)=C(1,j);
  oldC(2,j)=C(2,j);
    
end
%Orta noktalarýn yazdýrýlmasý

hold on
h1=plot(C(1:cluster-1:2*cluster),C(2:cluster-1:2*cluster),'yx');

C=zeros(2,cluster);

%Yeni Centroid hesap
for j=1:cluster
    for i=1:n
       if(Clusters(j,i)==1)
           C(1,j)=C(1,j)+X(1,i)/Centroid(j);
           C(2,j)=C(2,j)+X(2,i)/Centroid(j);
       elseif (Centroid(j)==0) %Kümede hiçbir eleman yoksa eski centroid
           C(1,j)=oldC(1,j);
           C(2,j)=oldC(2,j);
       end
      
    end
    
end

hold on
set(h1,'Visible','off')
h2 = plot(C(1:cluster-1:2*cluster),C(2:cluster-1:2*cluster),'gx');


