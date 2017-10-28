:- consult('../../sets/combosets.pro').
:- consult('../v2/crypto.pro').

%% Order 5 solver
crypto(N1,N2,N3,N4,N5,G,Expr) :-
	combos(set(N1,N2,N3,N4,N5),combo(A,B),extras(C,D,E)),
	crypto(A,B,SG,SGExpr),
	crypto(C,D,E,SG,G,UGExpr),
	substitute(SGExpr,SG,UGExpr,Expr).
