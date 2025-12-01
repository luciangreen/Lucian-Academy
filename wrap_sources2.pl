:-include('../listprologinterpreter/la_strings.pl').
:-include('../listprologinterpreter/la_strings_string.pl').
wrap_sources:-
	directory_files("sources/",F),
	delete_invisibles_etc(F,G),
%%trace,
%SepandPad="#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\!'0123456789",
	findall(_,(member(Folderx1,G),
	string_concat("sources/",Folderx1,Folderx),
	directory_files(Folderx,F1),
	delete_invisibles_etc(F1,G1),
	
	findall(_,(member(Filex1,G1),
	%trace,
	((foldr(string_concat,["sources/",Folderx1,"/",Filex1],Filex),
	foldr(string_concat,["sources1/",Folderx1,"/",Filex1],Filexx),
	
	split_string(Filex1," "," ",Filex2),
	Filex3=Filex2,
	findall([Filex31," "],(member(Filex31,Filex3)),Filex32),
	maplist(append,[Filex32],[Filex321]),
	concat_list(Filex321,Filex33),
	string_concat(Filex4,".txt ",Filex33),
		phrase_from_file_s(string(String00a), Filex),
		string_codes(String02c,String00a),

	atomic_list_concat(B,"\"",String02c),
	atomic_list_concat(B,"\\""",C),
	%atomic_list_concat(C1,"\\",C),
	%atomic_list_concat(C1,"\\\\",C2),
	atom_string(C,String02b),
	
	once((string_concat(A,B1,Filex1),string_length(A,4))),
	(not(A="dot-") ->
	
		(%trace,
		Line=String02c,	Filexx=Filexx2)
;
		
	(	%trace,
	foldr(string_concat,["sources1/",Folderx1,"/",B1],Filexx2),
string_concat(B2,".txt",B1),
		concat_list(["[\"Green, L 2024, <i>",B2,"</i>, Lucian Academy Press, Melbourne.\",","\"Green, L 2024\",",1,",\"",String02b,"\"]"],Line)
	)),
		%atom_to_term(String02b,String02a,[]),
%term_to_atom(Line,Line1),
	foldr(string_concat,["sources1/",Folderx1,"/"],Folderxx1),
	(exists_directory(Folderxx1)->true;make_directory(Folderxx1)),		
	(open_s(Filexx2,write,Stream1),
%%	string_codes(BrDict3),
	write(Stream1,Line),
	close(Stream1))
	)->true;(writeln(["Error:",Filex1,"didn't convert."])))
	),_)),_).
		
delete_invisibles_etc(F,G) :-
	findall(J,(member(H,F),atom_string(H,J),not(J="."),not(J=".."),not(string_concat(".",_,J))),G).

string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).
