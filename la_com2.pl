#!/usr/bin/swipl -f -q

:- initialization main.

:-include('la_com1.pl').

main :-
	la_com1,halt.

main :- halt(1).
