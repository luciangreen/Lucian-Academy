%% enter source, alg, pl or lp (with types, open), for subj/ass, date br (may be manually entered)

%% x one alg to enter alg specs 

%% x one alg to suggest algs, like combophil with filename - upper limit of algs per chapter, records algs per chapters
% - 4 per file, (then 16 per file x)

%% combophil.pl

%% Finds combinations of lines of philosophy

:-include('../listprologinterpreter/la_strings.pl').
:-include('folders.pl').

string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).

%% e.g. combophil(2). to write on a combination of philosophies

combophil_alg_log :-
	N1 = 4, %% maximum number of algorithms per file
	% find files with n or fewer algorithms
	%phrase_from_file_s(string(String00a), "combophil_alg_log.txt"),
	%string_codes(String02b,String00a),
	%trace,
	%atom_to_term(String02b,String02a,[]),
	
	working_directory(_,'Books'),
	folders(Folders),
	%Folders=["a000"],
	%trace,
	findall([Dept,G00],(member(Dept,Folders),
	concat_list([Dept],Dept1),
	directory_files(Dept1,F),
	delete_invisibles_etc(F,G),
	member(G00,G)),G1),
	%trace,
	delete_all(String02a,G1,G2),
	findall([G51,G52,0],(member([G51,G52],G2)),G6),
	%trace,
	append(String02a,G6,G3),
%trace,
	combophil_alg_log(N1,G3,G4),
 	
	%term_to_atom(G4,String1),

	%(open_s("combophil_alg_log.txt",write,Stream1),
	%write(Stream1,String1),
	%close(Stream1)),
	!.
	
delete_all([],G,G) :- !.
delete_all(G0,G1,G2) :-
	G0=[[String1,String2,_]|Strings2],
	delete(G1,[String1,String2],G3),
	delete_all(Strings2,G3,G2).
 	/**
%trace,
%SepandPad="#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\!'0123456789",
	%trace,
	findall(String02b,(member(Filex1,G),
	string_concat(Dept1,Filex1,Filex),
		phrase_from_file_s(string(String00a), Filex),
		string_codes(String02b,String00a)),Texts1),
**/
	% choose a file, algorithm y or n, record if y
combophil_alg_log(N1,G1,G2) :-
	((member([_Dept00,_Folder00,N20],G1), N20<N1)->
	(findall([Dept01,Folder01,N20],(member([Dept01,Folder01,N20],G1),N20<N1),R),random_member([Dept,Folder,N2],R),
	N2=<N1,
	get_texts1(Dept,Folder,Text),
	%concat_list(["../vpsbu 27 10 19/",Folder],Path),
	% phrase_from_file_s(string(Phil1), "../vpsbu 27 10 19/luciansphilosophy-full.txt"),
	SepandPad="\n\r",
	split_string(Text,SepandPad,SepandPad,Phil2),
	delete(Phil2,"",Phil3),
	%sort(Phil3,Phil4),
	%length(Phil4,LengthPhil4),write("Number of philosophies in luciansphilosophy.txt: "),
	%writeln(LengthPhil4),
	%length(PhilsLengthList,NumberOfPhils),
	%repeat,
	/**
	findall(Phils1,(member(_,PhilsLengthList),random_member(Phils1,Phil4)),Phils2),
	reverse(Phils2,Phils3),Phils3=[Phil6|Phils4],reverse(Phils4,Phils5),
	findall(_,(member(Phil5,Phils5),writeln1(Phil5),nl,writeln1("because"),nl),_),
	**/
	random_member(Phil4,Phil3),
	writeln1([Dept,Folder,N2,algorithms,Phil4]),nl,
	writeln("Algorithm? (y/n): "),
	read_string(user_input, "\n", "\r", _End, Input),
	(Input="n"->G1=G2
;(delete(G1,[Dept,Folder,N2],G3),
N3 is N2+1,
append(G3,[[Dept,Folder,N3]],G4),
combophil_alg_log(N1,G4,G2))));
G1=G2).


delete_invisibles_etc(F,G) :-
	findall(J,(member(H,F),atom_string(H,J),not(J="."),not(J=".."),not(string_concat(".",_,J))),G).


get_texts1(Dept0,Dept,Text) :-
	%findall(Texts2,(%member(Dept0,Dept),
	concat_list([Dept0,"/",Dept
	],Dept1),
	%directory_files(Dept1,F),
	%delete_invisibles_etc(F,G),
%trace,
%SepandPad="#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\!'0123456789",
	%trace,
	%findall(String02b,(member(Filex1,G),
	%string_concat(Dept1,Filex1,Filex),
		phrase_from_file_s(string(String00a), Dept1),
		string_codes(Text,String00a).
		/**),Texts1),
		%trace,
		choose_texts(Texts1,_Texts2,Text_a),
		% choose_texts(Texts2,Texts3,Text_b),
		% choose_texts(Texts3,_Texts4,Text_c),
		maplist(append,[[[Text_a]]],[Texts]).
		**/
		
choose_texts(Texts1,Texts2,Text) :-
	random_member(Text,Texts1),
	delete(Texts1,Text,Texts2).