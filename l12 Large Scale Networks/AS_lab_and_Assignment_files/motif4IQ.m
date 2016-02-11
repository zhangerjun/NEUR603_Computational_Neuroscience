function [I Q F]=motif4IQ(W)
%[I Q F]=motif4IQ(W)
%Input: weighted graph W (all weights [0,1]).
%Output by node: total intensity I, total coherence Q, motif count F.
%Average intensity and coherence may be obtained as I./F and Q./F.
%
%Mika Rubinov, July 2007

n=length(W);                                    %number of vertices in W
I=zeros(199,n);                                 %intensity
Q=zeros(199,n);                                 %coherence
F=zeros(199,n);                                 %frequency

A=1*(W~=0);                                     %adjacency matrix
As=A|A.';                                       %symmetrized adjacency
load motif34lib M4 ID4 N4                       %load motif data

for u=1:n-3                                     %loop u 1:n-2
    V1=[false(1,u) As(u,u+1:n)];                %v1: neibs of u (>u)
    for v1=find(V1)
        V2=[false(1,u) As(v1,u+1:n)];           %v2: all neibs of v1 (>u)
        V2(V1)=0;                               %not already in V1
        V2=V2|([false(1,v1) As(u,v1+1:n)]);     %and all neibs of u (>v1)
        for v2=find(V2)
            vz=max(v1,v2);                      %vz: largest rank node
            V3=([false(1,u) As(v2,u+1:n)]);     %v3: all neibs of v2 (>u)
            V3(V2)=0;                           %not already in V1&V2
            V3=V3|([false(1,v2) As(v1,v2+1:n)]);%and all neibs of v1 (>v2)
            V3(V1)=0;                           %not already in V1
            V3=V3|([false(1,vz) As(u,vz+1:n)]); %and all neibs of u (>vz)
            for v3=find(V3)

                w=[W(v1,u) W(v2,u) W(v3,u) W(u,v1) W(v2,v1) W(v3,v1)...
                    W(u,v2) W(v1,v2) W(v3,v2) W(u,v3) W(v1,v3) W(v2,v3)];
                a=[A(v1,u);A(v2,u);A(v3,u);A(u,v1);A(v2,v1);A(v3,v1);...
                    A(u,v2);A(v1,v2);A(v3,v2);A(u,v3);A(v1,v3);A(v2,v3)];
                ind=(M4*a)==N4;                 %find all contained isomorphs
                m=sum(ind);                     %number of isomorphs

                M=M4(ind,:).*repmat(w,m,1);
                id=ID4(ind);
                l=N4(ind);
                x=sum(M,2)./l;                  %arithmetic mean
                M(M==0)=1;                      %enable geometric mean
                i=prod(M,2).^(1./l);            %intensity
                q=i./x;                         %coherence

                [idu j]=unique(id);             %unique motif occurences
                j=[0;j];
                mu=length(idu);                 %number of unique motifs
                i2=zeros(mu,1);
                q2=i2; f2=i2;

                for h=1:mu                      %for each unique motif
                    i2(h)=sum(i(j(h)+1:j(h+1)));    %sum all intensities,
                    q2(h)=sum(q(j(h)+1:j(h+1)));    %coherences
                    f2(h)=j(h+1)-j(h);              %and frequencies
                end

                %then add to cumulative count
                I(idu,[u v1 v2 v3])=I(idu,[u v1 v2 v3])+[i2 i2 i2 i2];
                Q(idu,[u v1 v2 v3])=Q(idu,[u v1 v2 v3])+[q2 q2 q2 q2];
                F(idu,[u v1 v2 v3])=F(idu,[u v1 v2 v3])+[f2 f2 f2 f2];
            end
        end
    end
end