%load the global variable ADT
:- consult('../../global_variable_adt/gv1.pro').

%establish the problem parameters
establishCryptoProblemParameters :-
	declare(low,0),
	declare(high,15).

:- establishCryptoProblemParameters.

%generate a random number within the desired range
generateRandomCryptoNumber(N) :-
	valueOf(low,Low),
	valueOf(high,High),
	UpperBound is High + 1,
	random(Low,UpperBound,N).

%generate random crypto problem and add it to the KB
generateRandomCryptoProblem :-
	generateRandomCryptoNumber(N1),
	generateRandomCryptoNumber(N2),
	generateRandomCryptoNumber(N3),
	generateRandomCryptoNumber(N4),
	generateRandomCryptoNumber(N5),
	generateRandomCryptoNumber(G),
	addCryptoProblemToKnowledgeBase(N1,N2,N3,N4,N5,G).

addCryptoProblemToKnowledgeBase(N1,N2,N3,N4,N5,G) :-
	retractall(problem(_,_)),
	assert(problem(numbers(N1,N2,N3,N4,N5),goal(G))).

%display the crypto problem that is stored in the KB
displayProblem :-
	problem(numbers(N1,N2,N3,N4,N5),goal(G)),
	write('Numbers = {'),
	write(N1),write(', '),
	write(N2),write(', '),
	write(N3),write(', '),
	write(N4),write(', '),
	write(N5),write('} Goal = '),
	write(G),
	nl.

%Demo
demo :-
	generateRandomCryptoProblem,
	displayProblem.

%generate and display some number of crypto problems
generate(1) :-
	demo.
generate(N) :-
	demo,
	NM1 is N-1,
	generate(NM1).
