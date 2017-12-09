
:- consult('modified_crypto.pro').
:- use_module(library(lists)).

% H1
%---------------------------------------------------------------------------------------------------

situation1 :-
        problem(Numbers,Goal),
        Goal=goal(0),
        Numbers=numbers(N1,N2,N3,N4,N5),
        member(0,[N1,N2,N3,N4,N5]).
action1 :-
        problem(Numbers,_),
	Numbers=numbers(N1,N2,N3,N4,N5),
	assert(solution(ex(N1,*,ex(N2,*,ex(N3,*,ex(N4,*,N5)))))).

% H2
%---------------------------------------------------------------------------------------------------

situation2 :-
        problem(numbers(N1,N2,N3,N4,N5),goal(G)),
        member(G,[N1,N2,N3,N4,N5]),
        member(0,[N1,N2,N3,N4,N5]),
        not(G=0).
action2 :-
        problem(_,goal(G)),
	other_numbers(special(G),others(A,B,C,D)),
	assert(solution(ex(G,+,ex(A,*,ex(B,*,ex(C,*,D)))))).

% H3
%---------------------------------------------------------------------------------------------------


situation3 :-
        problem(_,goal(0)),
        doubleton.
action3 :-
        doubleton(doubleton(A,B),rest(C,D,E)),
        assert(solution(ex(ex(A,-,B),*,ex(C,*,ex(D,*,E))))).  

% H4
%---------------------------------------------------------------------------------------------------

situation4 :-
	problem(_,goal(1)),
        doubleton(doubleton(A,B),rest(C,D,E)),
	remove(0, [C,D,E], Others),
	nth0(0,Others,F),
	nth0(1,Others,G),
	defTemp(A,B,0,F,G).
        
action4 :-
	temp(A,B,C,D,E),
	assert(solution(ex(ex(A,/,B),*,ex(C,*,ex(D,*,E))))).
	

% H5
%---------------------------------------------------------------------------------------------------

situation5 :-
	problem(_,goal(G)),
	doubleton(doubleton(A,B),rest(C,D,E)),
	remove(G,[C,D,E],Others),
	nth0(0,Others,F),
	nth0(1,Others,H),
	defTemp(A,B,G,F,H).

action5 :-
	temp(A,B,C,D,E),
	assert(solution(ex(C,+,ex(ex(A,-,B),*,ex(D,*,E))))).

% H6
%---------------------------------------------------------------------------------------------------

situation6 :-
	problem(numbers(A,B,C,D,E),goal(G)),
	same([A,B,C,D,E,G]),
	defTemp(A,B,G,D,E).

action6 :-
	temp(A,B,C,D,E),
	assert(solution(ex(A,+,ex(ex(B,-,C),+,ex(D,-,E))))).

% H7
%---------------------------------------------------------------------------------------------------

situation7 :-
	problem(numbers(N1,N2,N3,N4,N5),goal(G)),
	perm(s(N1,N2,N3,N4,N5),p(A,B,C,D,E)),
	twoP(A,B),
	zeroP(C,D),
	TwoLess is E - 2,
	G = TwoLess,
	defTemp(A,B,C,D,E).
action7 :-
	temp(A,B,C,D,E),
	zeroX(C,D,ZeroX),
	twoX(B,A,TwoX),
	assert(solution(ex(E,-,ex(TwoX,+,ZeroX)))).
% H8
%---------------------------------------------------------------------------------------------------

situation8 :-
	problem(numbers(N1,N2,N3,N4,N5),goal(G)),
	perm(s(N1,N2,N3,N4,N5),p(A,B,C,D,E)),
	A=B,
	C=D,
	TwoLess is E - 2,
	G = TwoLess,
	defTemp(A,B,C,D,E).
action8 :-
	temp(A,B,C,D,E),
	assert(solution(ex(E,-,ex(ex(A,/,B),+,ex(C,/,D))))).

% Predicates
%---------------------------------------------------------------------------------------------------

defTemp(N1,N2,N3,N4,N5) :-
    retractall(temp(_)),
    asserta(temp(N1,N2,N3,N4,N5)).

 defTemp(N1,N2,N3,N4,N5) :-
    asserta(temp(N1,N2,N3,N4,N5)).

zeroP(A,B) :-
	crypto(A,B,0,_).	
zeroX(A,B,X) :-
	crypto(A,B,0,X).

twoP(A,B) :-
	crypto(A,B,2,_).

twoX(A,B,X) :-
	crypto(A,B,2,X).

goalP(A,B,G) :-
	crypto(A,B,G,_).
goalX(A,B,G,X) :-
	crypto(A,B,G,X).

oneP(A,B) :-
	crypto(A,B,1,_).
oneX(A,B,X) :-
	crypto(A,B,1,X).

member(X,[X|R],R).
member(X,[Y|R],Result) :-
	member(X,R,Subresult),
	Result=[Y|Subresult].

same([]).
same([_]).
same([X,X|T]) :- 
	same([X|T]).

doubleton :- 
	problem(numbers(N1,N2,N3,N4,N5),_),
	combos(set(N1,N2,N3,N4,N5),combo(A,B),_),
	A is B.
doubleton(doubleton(A,B),rest(C,D,E)) :-
	problem(numbers(N1,N2,N3,N4,N5),_),
	combos(set(N1,N2,N3,N4,N5),combo(A,B),extras(C,D,E)),
	A is B.

other_numbers(special(N),others(N2,N3,N4,N5)) :-	
	problem(numbers(N,N2,N3,N4,N5),goal(_)).
other_numbers(special(N),others(N1,N3,N4,N5)) :-	
	problem(numbers(N1,N,N3,N4,N5),goal(_)).
other_numbers(special(N),others(N1,N2,N4,N5)) :-	
	problem(numbers(N1,N2,N,N4,N5),goal(_)).
other_numbers(special(N),others(N1,N2,N3,N5)) :-	
	problem(numbers(N1,N2,N3,N,N5),goal(_)).
other_numbers(special(N),others(N1,N2,N3,N4)) :-	
	problem(numbers(N1,N2,N3,N4,N),goal(_)).

adjacent(A,B) :-
	crypto(A,1,B,ex(_,OP,_)),member(OP,[+,-]).

%remove (from lp.pro)
%------------------------------------------------------------------

remove(_,[],[]).
remove(First,[First|Rest],Rest).
remove(Element,[First|Rest],[First|RestLessElement]) :-
	remove(Element,Rest,RestLessElement).


% SOLVE THE PROBLEM HEURISTICALLY -- ASSUMING INTERNALIZATION
%---------------------------------------------------------------------------------------------------

rule(1,situation1,action1).
rule(2,situation2,action2).
rule(3,situation3,action3).
rule(4,situation4,action4).
rule(5,situation5,action5).
rule(6,situation6,action6).
rule(7,situation7,action7).
rule(8,situation8,action8).

solveProblemHeuristically :-
	retractall(solution(_)),
	rule(Number,Situation,Action),
	%write('considering rule '),write(Number),
	%write(' ...'),nl,
	Situation,
	write('application of rule '),write(Number),
	write(' produces '),Action.

solveProblemHeuristically :-
	rule(Number,Situation,Action),
	%write('considering rule '),write(Number),write(' ...'),nl,
	Situation,
	write('application of rule '),write(Number),write(' produces '),
	Action.
solveProblemHeuristically.

% CRYPTO PROBLEM SOLVER
%---------------------------------------------------------------------------------------------------

solve(numbers(N1,N2,N3,N4,N5),goal(G)) :-
	establishSpecificCryptoProblem(N1,N2,N3,N4,N5,G),
	displayProblem,
	solveProblemHeuristically,
	displaySolution.

solve :-
	generateRandomCryptoProblem,
	displayProblem,
	solveProblemHeuristically,
	displaySolution.

% DISPLAY THE SOLUTION -- ASSUMING THAT IT HAS BEEN SOLVED
%---------------------------------------------------------------------------------------------------

displaySolution :-
	solution(S),
	displayResult(S),
	nl.
displaySolution.

% DEMO - GENERATE AND SOLVE A RANDOM CRYPTO PROBLEM
%---------------------------------------------------------------------------------------------------

demo :-
	generateRandomCryptoProblem,
	displayProblem,
	solveProblemHeuristically,
	displaySolution.

demo(0).
demo(N) :-
	demo,
	K is N-1,
	demo(K).

% ITERATOR
%---------------------------------------------------------------------------------------------------

repeat(0,_).
repeat(N,P) :-
	P,
	K is N - 1,
	repeat(K,P).
