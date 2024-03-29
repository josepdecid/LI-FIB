:- use_module(library(clpfd)).

%ejemplo(_, Big, [S1...SN]): how to fit all squares of sizes S1...SN in a square of size Big?
ejemplo(0,   3, [2,1,1,1,1,1]).
ejemplo(1,   4, [2,2,2,1,1,1,1]).
ejemplo(2,   5, [3,2,2,2,1,1,1,1]).
ejemplo(3,  19, [10,9,7,6,4,4,3,3,3,3,3,2,2,2,1,1,1,1,1,1]).
ejemplo(4, 112, [50,42,37,35,33,29,27,25,24,19,18,17,16,15,11,9,8,7,6,4,2]).
ejemplo(5, 175, [81,64,56,55,51,43,39,38,35,33,31,30,29,20,18,16,14,9,8,5,4,3,2,1]).

doExample(E) :-
    ejemplo(E, Big, Sides),
    nl, write('Fitting all squares of size '), write(Sides), write(' into big square of size '), write(Big), nl,nl,
    length(Sides, N),
    length(RowVars, N), % get list of N prolog vars: Row coordinates of each small square
    length(ColVars, N), % get list of N prolog vars: Col coordinates of each small square
    RowVars ins 1..Big,
    ColVars ins 1..Big,
    insideBigSquare(N, Big, Sides, RowVars),
    insideBigSquare(N, Big, Sides, ColVars),
    nonoverlapping(N, Sides, RowVars, ColVars),
    append(RowVars, ColVars, Vars),
    label(Vars),
    displaySol(N, Sides, RowVars, ColVars).

insideBigSquare(_, _, [], []) :- !.
insideBigSquare(N, Big, [S|Sides], [V|Vars]) :-
    V + S - 1 #=< Big, insideBigSquare(N, Big, Sides, Vars).

nonoverlapping(1, _, _, _) :- !.
nonoverlapping(N, [S|Sides], [R|RowVars], [C|ColVars]) :-
    squareRCSnoOverlapsL(S, R, C, Sides, RowVars, ColVars),
    NP is N - 1, nonoverlapping(NP, Sides, RowVars, ColVars).

squareRCSnoOverlapsL(_, _, _, [], [], []) :- !.
squareRCSnoOverlapsL(S, R, C, [SP|Sides], [RP|RowVars], [CP|ColVars]) :-
    RP #>= R + S #\/ RP + SP #=< R #\/ CP #>= C + S #\/ CP + SP #=< C,
    squareRCSnoOverlapsL(S, R, C, Sides, RowVars, ColVars).

displaySol(N, Sides, RowVars, ColVars):-
    between(1, N, Row), nl, between(1, N, Col),
    nth1(K, Sides, S),
    nth1(K, RowVars, RV), RVS is RV + S - 1, between(RV, RVS, Row),
    nth1(K, ColVars, CV), CVS is CV + S - 1, between(CV, CVS, Col),
    writeSide(S), fail.
displaySol(_,_,_,_):- nl.

writeSide(S):- S < 10, write('  '), write(S), !.
writeSide(S):- write(' '), write(S), !.

main:-
    doExample(0),
    doExample(1),
    doExample(2),
    doExample(3),
    doExample(4),
    doExample(5),
    halt.
