:-include('../listprologinterpreter/la_strings.pl').
:-include('../listprologinterpreter/la_strings_string.pl').
wrap_sources:-
	directory_files("sources/",F),
	delete_invisibles_etc(F,G),
%%trace,
%SepandPad="#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\!'0123456789",
	findall(_,(member(Filex1,G),
	string_concat("sources/",Filex1,Filex),
	string_concat("sources1/",Filex1,Filexx),
	
	split_string(Filex1," "," ",Filex2),
	append(_,["Green"|Filex3],Filex2),
	findall([Filex31," "],(member(Filex31,Filex3)),Filex32),
	maplist(append,[Filex32],[Filex321]),
	concat_list(Filex321,Filex33),
	string_concat(Filex4,".txt ",Filex33),
		phrase_from_file_s(string(String00a), Filex),
		string_codes(String02b,String00a),
		
		concat_list(["[\"Green, L 2021, <i>",Filex4,"</i>, Lucian Academy Press, Melbourne.\",\"Green, L 2021\",1,\"",String02b,"\"]"],Line),
		%atom_to_term(String02b,String02a,[]),
		
	(open_s(Filexx,write,Stream1),
%%	string_codes(BrDict3),
	write(Stream1,Line),
	close(Stream1))),_).
		
delete_invisibles_etc(F,G) :-
	findall(J,(member(H,F),atom_string(H,J),not(J="."),not(J=".."),not(string_concat(".",_,J))),G).

string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).
