function [X,idx] = kMeans(y)
X = [randn(100,2)+1.5*ones(100,2);...
     randn(100,2)-2*ones(100,2);]; %...
     % randn(100,2)+[-3*ones(100,1) 2*ones(100,1)];];
opts = statset('Display','final');

[idx,ctrs] = kmeans(X,y,...
                    'Distance','city',...
                    'Replicates',100,...
                    'Options',opts);
figure(1);
clf;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
plot(X(idx==3,1),X(idx==3,2),'g.','MarkerSize',12)
plot(ctrs(:,1),ctrs(:,2),'kx',...
     'MarkerSize',12,'LineWidth',2)
plot(ctrs(:,1),ctrs(:,2),'ko',...
     'MarkerSize',12,'LineWidth',2)
legend('Cluster 1','Cluster 2','Cluster 3','Centroids',...
       'Location','NW')
figure(2);
clf;
plot(X(:,1),X(:,2),'k.','MarkerSize',12)
end;