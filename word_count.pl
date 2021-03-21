% ["Medicine","MEDICINE by Lucian Green Head of State Head Ache Prevention 1 of 4.txt",0,algorithms,"See also Hours Prayer."]

:-include('../../listprologinterpreter/la_strings.pl').
:-include('../../listprologinterpreter/la_strings_string.pl').

% word_count(["file","file.txt"],Words).
% Words = 69.

% word_count(["string","a b c"],Words).
% Words = 3.

word_count([Type,String1],Words) :-
	SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",

	(Type="file"->
	(phrase_from_file_s(string(String2), String1));
	String1=String2),
	split_string(String2,SepandPad,SepandPad,String3),
	%writeln(String3),
	length(String3,Words).
	

