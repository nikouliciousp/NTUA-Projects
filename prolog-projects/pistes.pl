split_Keys(0, [], L, L).
split_Keys(1, [X], L, [X|L]).
split_Keys(N, [X|TL], Y, [X|L]):-
	TN is N-1,
	split_Keys(TN, TL, Y, L).
	
read_input(File, N, Pistes):-
    open(File, read, Stream),
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atom_number(Atom, TN),
	N is TN+1,
    read_lines(Stream, N, Pistes).

read_lines(Stream, N, Pistes):-
    ( N == 0 -> Pistes = []
    ; N > 0  -> read_line(Stream, Pista),
                Nm1 is N-1,
                read_lines(Stream, Nm1, RestPistes),
				!,
                Pistes = [Pista | RestPistes]).

read_line(Stream, pista(K, R, S, InKeys, OutKeys)):-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat([TK,TR,TS | Atoms], ' ', Atom),
	atom_number(TK, K),
	atom_number(TR, R),
	atom_number(TS, S),
    maplist(atom_number, Atoms, Keys),
	split_Keys(K, TInKeys, TOutKeys, Keys),
	sort(TInKeys, InKeys),
	sort(TOutKeys, OutKeys).
	
/*read_tuples(pista(K, R, S, InKeys, OutKeys), K, R, S, InKeys, OutKeys).*/

solve([], 0).
solve(Pistes, Ans):-
	subseq(LPistes, Pistes),
	permute(LPistes, LLPistes),
	compare_Group_Lists(LLPistes, Ans).
	
subseq([], []).
subseq(X, [_ | RestY]):-
	subseq(X, RestY).
subseq([Item | RestX], [Item | RestY]):-
	subseq(RestX, RestY).

stars(Pistes, S):-
	add_Stars(Pistes, 0, S).
	
add_Stars([], S1, S1).
add_Stars([pista(_, _, S2, _, _) | L], S1, S):-
	NS is S1+S2,
	add_Stars(L, NS, S).

same_Lists([], []).   
same_Lists([X|XL], [Y|YL]):-
    X == Y,
    same_Lists(XL, YL).

compare_Group_Lists([pista(_, _, S, _, _)], S).
compare_Group_Lists([pista(_, _, S1, InKeys1, OutKeys1), pista(_, _, S2, InKeys2, OutKeys2) | L], S):-
	append(InKeys1, InKeys2, TIn),
	sort(TIn, In),
	append(OutKeys1, OutKeys2, TOut),
	sort(TOut, Out),
	compare_Lists(In, Out, T),
	same_Lists(T, In),
	TS is S1 + S2,
	compare_Group_Lists([pista(_, _, TS, In, Out) | L], S).

	
compare_Lists([], [], []).
compare_Lists([], _, []).
compare_Lists(X, [], X).
compare_Lists([X|XL], [Y|YL], Z):-
	X =:= Y,
	compare_Lists(XL, YL, Z).
compare_Lists([X|XL], [Y|YL], [X|ZL]):-
	Y > X,
	compare_Lists(XL, [Y|YL], ZL).
compare_Lists([X|XL], [Y|YL], [X|ZL]):-
	Y < X,
	compare_Lists([X|XL], YL, ZL).

pistes(File, Ans):-
	read_input(File, N, Pistes),
	solve(Pistes, Ans).