read_line(L,C) :-
	get_char(C),
	(isEOFEOL(C), L = [], !;
		read_line(LL,_),
		[C|LL] = L).

isEOFEOL(C) :-
	C == end_of_file;
	(char_code(C,Code), Code==10).
    
read_lines(Ls) :-
	read_line(L,C),
	( C == end_of_file, Ls = [] ;
	read_lines(LLs), Ls = [L|LLs]
	).

:- dynamic rel/2.

split_line([],[[]]) :- !.
split_line([' '|T], [[]|S1]) :- !, split_line(T,S1).
split_line([32|T], [[]|S1]) :- !, split_line(T,S1).
split_line([H|T], [[H|G]|S1]) :- split_line(T,[G|S1]).

split_lines([],[]).
split_lines([L|Ls],[H|T]) :- split_lines(Ls,T), split_line(L,H).

create_relations([]).
create_relations([Head|Rest]) :- create_relation(Head), create_relations(Rest).
create_relation([X,Y]) :- 
	member(R1,X),
	member(R2,Y),
	assertz(rel(R1,R2)).
create_relation(_).

start :-
	prompt(_, ''),
	read_lines(LL),
	split_lines(LL,S),
	create_relations(S),
	hamiltonianPath(Res),
	write_lines2(Res),
	halt.

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

hamiltonianPath(Respath) :- 
	nodes([H|_]), 
	findall(P,path(H,H,P),Ps), 
	maplist(sort, Ps, SortedPaths), 
	sort(SortedPaths, Respaths),
	twoNodesEdgecase(Respaths,Respath).

twoNodesEdgecase(L,[]) :- length(L,1).
twoNodesEdgecase(L,L).

write_lines2([]).
write_lines2([H|T]) :- 
	add_separators(H,Res), 
	atomic_list_concat(Res,' ',Res2), 
	writeln(Res2), 
	write_lines2(T).

add_separators([],[]).
add_separators([H|T],[S|R]) :- atomic_list_concat(H,'-',S), add_separators(T,R).
