% Tests for wrap_sources2.pl.
% Run from the Lucian-Academy folder (with listprologinterpreter beside it):
%   swipl -g main -t halt tests/wrap_sources2_tests.pl
%
% It builds a scratch Books folder from the 200 io pairs, runs wrap_sources
% there, and checks:
%   P1 every io pair: the expected file exists with the expected text;
%   P2 every converted "dot-" original is gone, and nothing else is deleted;
%   P3 files that are not "dot-" .txt or .pl files are byte-for-byte unchanged;
%   P4 each folder ends with exactly as many files as it started with;
%   P5 running wrap_sources a second time changes nothing.

:- include('../wrap_sources2.pl').
:- use_module(wrap_sources2_io).

main :-
	tmp_file(wrap_sources2, T0), get_time(Now), format(atom(Tmp), "~w_~0f", [T0, Now*1000]),
	make_directory(Tmp),
	build_books(Tmp),
	snapshot(Tmp, Before),
	run_in(Tmp),
	snapshot(Tmp, After1),
	run_in(Tmp),
	snapshot(Tmp, After2),
	findall(N, (io(N,F,In,_,Out,Text), \+ p1(After1,F,In,Out,Text)), Bad1),
	findall(N, (io(N,F,In,_,Out,_), \+ p2(After1,F,In,Out)), Bad2),
	findall(N, (io(N,F,In,T,Out,_), In==Out, \+ member(file(F,In,T),After1)), Bad3),
	folder_counts(Before, C0), folder_counts(After1, C1),
	( C0 == C1 -> Bad4 = [] ; Bad4 = [C0-C1] ),
	( After1 == After2 -> Bad5 = [] ; Bad5 = [changed_on_second_run] ),
	report('P1 io pairs give the expected file and text', Bad1),
	report('P2 originals removed, nothing else deleted', Bad2),
	report('P3 other files unchanged', Bad3),
	report('P4 file count per folder unchanged', Bad4),
	report('P5 second run changes nothing', Bad5),
	( Bad1-Bad2-Bad3-Bad4-Bad5 == []-[]-[]-[]-[] -> writeln('All 200 io pairs and 5 properties passed.') ; writeln('FAILED'), halt(1) ).

p1(Files, F, _In, Out, Text) :- member(file(F,Out,Text), Files).
p2(Files, F, In, Out) :-
	( In == Out -> member(file(F,In,_), Files) ; \+ member(file(F,In,_), Files) ).

build_books(Tmp) :-
	directory_file_path(Tmp, 'Books', Books), make_directory(Books),
	forall(io(_,F,In,Text,_,_),
	       ( directory_file_path(Books, F, Dir),
	         ( exists_directory(Dir) -> true ; make_directory(Dir) ),
	         directory_file_path(Dir, In, Path),
	         setup_call_cleanup(open(Path, write, S), write(S, Text), close(S)) )).

run_in(Tmp) :-
	working_directory(Old, Tmp),
	setup_call_cleanup(true, with_output_to(string(_), wrap_sources), working_directory(_, Old)).

snapshot(Tmp, Files) :-
	directory_file_path(Tmp, 'Books', Books),
	findall(file(F,Name,Text),
	        ( directory_files(Books, Fs), member(F0, Fs), \+ sub_atom(F0,0,_,_,'.'),
	          directory_file_path(Books, F0, Dir), exists_directory(Dir),
	          directory_files(Dir, Ns), member(N0, Ns), \+ sub_atom(N0,0,_,_,'.'),
	          directory_file_path(Dir, N0, P), read_file_to_string(P, Text, []),
	          atom_string(F0, F), atom_string(N0, Name) ),
	        Files0),
	msort(Files0, Files).

folder_counts(Files, Counts) :-
	findall(F, member(file(F,_,_), Files), Fs),
	findall(F-N, (member(F, Fs), aggregate_all(count, member(F, Fs), N)), C0),
	sort(C0, Counts).

report(Name, []) :- !, format("pass  ~w~n", [Name]).
report(Name, Bad) :- length(Bad, L), format("FAIL  ~w (~w): ~w~n", [Name, L, Bad]).
