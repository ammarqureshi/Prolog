

incr(f0(null),f1(null)).
incr(f1(null),f0(f1(null))).

incr(f0(X),f1(X)) :- incr(X,Y).
incr(f1(X), f0(Y)) :- incr(X, Y).



legal(f0(null)).
legal(X) :- legal(Y),incr(Y,X).  %start from first legal term f0, incr(f0) -> f1



incR(X,Y) :- legal(X), incr(X,Y),nl.



add(f0(null),X1,X1).

add(P1,P2,P3) :- incr(Z,P1),        %decrement P1
                incr(P2,Q),         %increment P2
                add(Z,Q,P3).        %adding to Q, taking from first arg and putting it in the second arg


mult(X,f0(null),f0(null)).
mult1(X,f1(null),X,_).


mult(f0(null),X,f0(null)).
mult1(f1(null),X,X,_).




mult(P1,P2,P3) :- mult1(P1,P2,P3,P1).
mult1(P1,P2,P3,Stable) :-
                          incr(Z,P2),
                          add(P1,Stable,Res),
                          mult1(Res,Z,P3,Stable).



revers(P,RevP):- revAcc(P,null,RevP).
revAcc(f0(P),Acc,RevP) :- revAcc(P,f0(Acc),RevP).
revAcc(f1(P),Acc,RevP) :- revAcc(P,f1(Acc),RevP).
revAcc(null,Acc,Acc).




normalize(null,f0(null)).
normalize(f0(null),f0(null)).
normalize(f1(null),f1(null)).

normalize(X,Y) :- X\=null, revers(X,Z), removeZeros(Z,Y).


removeZeros(f1(X),f1(X)).
removeZeros(f0(X),Y) :- removeZeros(X,Y).



% test add inputting numbers N1 and N2
testAdd(N1,N2,T1,T2,Sum,SumT) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
                                 add(T1,T2,SumT), pterm2numb(SumT,Sum).



% test mult inputting numbers N1 and N2
testMult(N1,N2,T1,T2,N1N2,T1T2) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
                                   mult(T1,T2,T1T2), pterm2numb(T1T2,N1N2).



% test revers inputting list L
testRev(L,Lr,T,Tr) :- ptermlist(T,L), revers(T,Tr), ptermlist(Tr,Lr).


% test normalize inputting list L
testNorm(L,T,Tn,Ln) :- ptermlist(T,L), normalize(T,Tn), ptermlist(Tn,Ln).


% make a pterm T from a number N    numb2term(+N,?T)
numb2pterm(0,f0(null)).
numb2pterm(N,T) :- N>0, M is N-1, numb2pterm(M,Temp), incr(Temp,T).


% make a number N from a pterm T  pterm2numb(+T,?N)
pterm2numb(null,0).
pterm2numb(f0(X),N) :- pterm2numb(X,M), N is 2*M.
pterm2numb(f1(X),N) :- pterm2numb(X,M), N is 2*M +1.


% reversible  ptermlist(T,L)
ptermlist(null,[]).
ptermlist(f0(X),[0|L]) :- ptermlist(X,L).
ptermlist(f1(X),[1|L]) :- ptermlist(X,L).
