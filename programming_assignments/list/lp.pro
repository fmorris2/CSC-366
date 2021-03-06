% FILE:  lp.pro
% TYPE:  Prolog source
% LINE:  some generally useful list processing predicates
% DATE:  November 1987, 1993, 2015

%writelist
%------------------------------------------------------------------

writelist([]).
writelist([H|T]) :- write(H),nl,writelist(T).


%member
%------------------------------------------------------------------

member(X,[X|_]).
member(X,[_|Y]) :- member(X,Y).


% length
%------------------------------------------------------------------

size([],0).
size([_|T],L) :- size(T,K),L is 1+K. 


%item
%------------------------------------------------------------------

item(N,[H|_],H) :- N=0.
item(N,[_|T],E) :- N>0,K is N-1,item(K,T,E).


%append
%------------------------------------------------------------------

append([],L,L).
append([H|T1],L2,[H|T3]) :- append(T1,L2,T3).

append(L1,L2,L3,Result) :-
	append(L1,L2,L12),append(L12,L3,Result).

append(L1,L2,L3,L4,Result) :-
	append(L1,L2,L3,L123),append(L123,L4,Result).


%last
%------------------------------------------------------------------

last([H|[]],H).
last([_|T],Result) :- last(T,Result).


%remove
%------------------------------------------------------------------

remove(_,[],[]).
remove(First,[First|Rest],Rest).
remove(Element,[First|Rest],[First|RestLessElement]) :-
remove(Element,Rest,RestLessElement).


%replace
%------------------------------------------------------------------

replace(0,Object,[_|T],[Object|T]).
replace(ListPosition,Object,[H|T1],[H|T2]) :-
	K is ListPosition - 1,
	replace(K,Object,T1,T2).


%makelist
%------------------------------------------------------------------

makelist(0,_,[]).
makelist(Length,Element,[Element|Rest]) :-
	K is Length-1,	
	makelist(K,Element,Rest).


%reverse
%------------------------------------------------------------------

reverse([],[]).
reverse([H|T],R) :-
	reverse(T,Rev),lastput(H,Rev,R).


%lastput
%------------------------------------------------------------------

lastput(E,[],[E]).
lastput(E,[H|T],[H|L]) :- lastput(E,T,L).


%pick
%------------------------------------------------------------------

pick(L,Item) :-
	size(L,Length),
	random(0,Length,RN),
	item(RN,L,Item).


%take
%------------------------------------------------------------------

take(List,Element, Rest) :-
	pick(List,Element),
	remove(Element,List,Rest).


%iota
%------------------------------------------------------------------

iota(0,[]).
iota(N,IotaN) :-
	K is N-1,
	iota(K,IotaK),
	lastput(N,IotaK,IotaN).

%sum
%------------------------------------------------------------------

sum([],0).
sum([Head|Tail],Sum) :-
	sum(Tail,SumOfTail),
	Sum is Head + SumOfTail.

%min
%------------------------------------------------------------------

min([H],H).
min([H|T],Minimum) :-
	min(T,Minimum),
	Minimum < H,!.
min([H|_],H).

%max
%------------------------------------------------------------------

max([H],H).
max([H|T],Maximum) :-
	max(T,Maximum),
	Maximum > H.
max([H|_],H).


%sort_inc
%------------------------------------------------------------------

sort_inc([],[]).
sort_inc(Unordered,Ordered) :-
	max(Unordered,Last),
	remove(Last,Unordered,Rest),
	sort(Rest,Number),
	lastput(Last,Number,Ordered).
	


%sort_dec
%------------------------------------------------------------------

sort_dec([],[]).
sort_dec(Unordered,Ordered) :-
	sort_inc(Unordered,Backwards),
	reverse(Backwards,Ordered).

%alist
%------------------------------------------------------------------

insert(H,T,[H|T]).
alist([],[],[]).
alist([H|T],[H1|T1],Alist) :-
	insert(pair(H,H1),Partial,Alist),
	alist(T,T1,Partial).
	

%assoc
%------------------------------------------------------------------

assoc([pair(Key,Value)|_],Key,Value).
assoc([_|T],Key,Value) :-
	assoc(T,Key,Value).

%flatten
%------------------------------------------------------------------

flatten([],[]).
flatten([[]|T],L) :-
	flatten(T,L).
flatten([H|T],L) :-
	atom(H),
	flatten(T,Tflattened),
	append([H],Tflattened,L).
flatten([H|T],L) :-
	flatten(H,FlatHead),
	flatten(T,FlatTail),
	append(FlatHead,FlatTail,L).


