
%% Restricted Exhaustive Crypto Problem Solver for orders 2,3,4

:- consult('../../sets/combosets.pro').

%% Order 2 solver

crypto(N1,N2,G,ex(N1,+,N2)) :- G is N1 + N2.
crypto(N1,N2,G,ex(N1,*,N2)) :- G is N1 * N2.
crypto(N1,N2,G,ex(N1,-,N2)) :- G is N1 - N2.
crypto(N1,N2,G,ex(N1,-,N2)) :- G is N2 - N1.
crypto(N1,N2,G,ex(N1,/,N2)) :- N2 > 0, G is N1 / N2.
crypto(N1,N2,G,ex(N1,/,N2)) :- N1 > 0, G is N2 / N1.

%% Order 3 Solver

crypto(N1,N2,N3,G,Expr) :-
  combos(set(N1,N2,N3),combo(A,B),extras(C) ),
  crypto(A,B,SG,SGExpr),
  crypto(C,SG,G,UGExpr),
  substitute(SGExpr,SG,UGExpr,Expr).

%% Order 4 Solver

crypto(N1,N2,N3,N4,G,Expr) :-
  combos(set(N1,N2,N3,N4),combo(A,B),extras(C,D)),
  crypto(A,B,SG,SGExpr),
  crypto(C,D,SG,G,UGExpr),
  substitute(SGExpr,SG,UGExpr,Expr).

%% Substitutions rules

substitute(New,Old,ex(Old,O,Z),ex(New,O,Z)).
substitute(New,Old,ex(X,O,Old),ex(X,O,New)).
substitute(New,Old,ex(X,O,Z),ex(Q,O,Z)) :-
  substitute(New,Old,X,Q).
substitute(New,Old,ex(X,O,Z),ex(X,O,Q)) :-
  substitute(New,Old,Z,Q).
