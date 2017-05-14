
arc([N,PCost],M,Seed,Cost) :- M is N*Seed, Cost is PCost + 1.
arc([N,PCost],M,Seed,Cost) :- M is N*Seed + 1, Cost is PCost +2.

goal([N,Cost],Target,Found) :- 0 is N mod Target, Found = N.
is_goal(N,Target) :- 0 is N mod Target.

h(N,Hvalue,Target) :- is_goal(N,Target), !, Hvalue is 0; Hvalue is 1/N.

less_than([Node1,Cost1],[Node2,Cost2],Target) :-
h(Node1,Hvalue1,Target), h(Node2,Hvalue2,Target),
F1 is Cost1+Hvalue1, F2 is Cost2+Hvalue2,
F1 =< F2.

find_min([Min],Min,_).
find_min([First,Second|T],Min,Target):- less_than(First,Second,Target),!,find_min([First|T],Min,Target).
find_min([First,Second|T],Min,Target):- find_min([Second|T],Min,Target).

add-to-frontier(Children,[],[Min|Rest], Target):-
find_min(Children,Min,Target),
add2frontier(Children,[],NewFrontier),
delete(NewFrontier,Min,Rest).

%when adding to frontier, find min in children and in previous frontier, and add it to the front of the frontier

add-to-frontier(Children,PrevFrontier,[Min|Rest], Target):-
find_min(Children,MinChild,Target),
find_min(PrevFrontier,MinFrontier,Target),
find_min([MinChild,MinFrontier],Min,Target),
add2frontier(Children,PrevFrontier,NewFrontier),
%remove the minimumn and add it at the head.
delete(NewFrontier,Min,Rest).

%actually add the child to the previous frontier to build the new front
add2frontier([],[],[]).
add2frontier([],F,F).
add2frontier([N|Children],F,[N|FNew]) :-  add2frontier(Children,F,FNew).


search([Node|FRest],Seed,Target,Found) :- goal(Node,Target,Found).

search([Node|FRest],Seed,Target,Found):- setof([X,Cost],arc(Node,X,Seed,Cost), FNode),
add-to-frontier(FNode,FRest,FNew, Target),
search(FNew,Seed,Target,Found).

%start searching
start(Start,Seed,Target,Found):- search([[Start,0]],Seed,Target,Found).

%astar algorithm
a-star(Start,Seed,Target,Found):- start(Start,Seed,Target,Found).
