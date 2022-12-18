agora(File, When, Missing):-
    open(File, read, Stream),
    read_line_to_codes(Stream, LineF),
	read_line_to_codes(Stream, LineS),
    atom_codes(AtomF, LineF),
	atom_codes(AtomS, LineS),
    atom_number(AtomF, N),
	atomic_list_concat(V, ' ', AtomS),
	maplist(atom_number, V, Villages),
	close(Stream),
	reverse(Villages, RevVillages),
	mysolve1(Villages, Villages, W1, M1),
	mysolve1(RevVillages, RevVillages, W2, MT),
	M2 is N+1-MT,
	mysolve2(W1, M1, W2, M2, When, Missing).

lcm(X, Y, Z):-
	Z is abs(X * Y / gcd(X,Y)).

indexOf([X|_], X, 1):- !.
indexOf([_|L], X, Index):-
	indexOf(L, X, Index1),
	!,
	Index is Index1+1.

mysolve1(L, [X,Y,Z], W, M):-
	lcm(X, Y, T1),
	lcm(X, Z, T2),
	T1 < T2,
	W is T1,
	indexOf(L, Z, M).
mysolve1(L, [X,Y,Z], W, M):-
	lcm(X,Y,T1),
	lcm(X,Z,T2),
	T1 > T2,
	W is T2,
	indexOf(L, Y, M).	
mysolve1(_, [X,Y,Z], W, 0):-
	lcm(X,Y,T1),
	lcm(X,Z,T2),
	T1 =:= T2,
	W is T1.
mysolve1(L, [X,Y,Z|TL], W, M):-
	lcm(X,Y,T1),
	lcm(X,Z,T2),
	T1 < T2,
	mysolve1(L, [T1,Z|TL], W, M).
mysolve1(L, [X,Y,Z|TL], W, M):-
	lcm(X,Y,T1),
	lcm(X,Z,T2),
	T1 > T2,
	mysolve1(L, [T2,Y|TL], W, M).
mysolve1(L, [X,Y,Z|TL], W, M):-
	lcm(X,Y,T1),
	lcm(X,Z,T2),
	T1 =:= T2,
	mysolve1(L, [T1,Z|TL], W, M).
	
mysolve2(W1, M1, W2, _, W1, M1):-
	W1 < W2.
mysolve2(W1, _, W2, M2, W2, M2):-
	W1 > W2.
mysolve2(W1, M1, W2, _, W1, M1):-
	W1 =:= W2.
	
	
	
	
	
	
	