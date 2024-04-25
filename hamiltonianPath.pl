rel(a,b).
rel(a,c).
rel(a,d).
rel(c,b).
rel(b,d).
rel(c,d).

nodes(L) :- setof(X,Y^(rel(X,Y);rel(Y,X)),L).
nodes_related(X,Y) :- rel(X,Y);rel(Y,X).

path(X,Y,P) :- nodes(L), path(X,Y,X,P,L).
path(X,Y,Init,[Sortedpair],Unused) :- 
    delete(Unused,X,Unusednew),
    Unusednew==[], 
    nodes_related(X,Y), 
    Y==Init,
    sort([X,Y],Sortedpair).

path(X,Y,Init,[Sortedpair|P],Unused) :- 
    nodes_related(X,Z),
    delete(Unused,X,Unusednew),
    member(Z,Unusednew),
    sort([X,Z],Sortedpair),
    path(Z,Y,Init,P,Unusednew).

hamiltonianPath(Respath) :- nodes([H|_]),findall(P,path(H,H,P),Ps), maplist(sort, Ps, SortedPaths), sort(SortedPaths, Respath).

