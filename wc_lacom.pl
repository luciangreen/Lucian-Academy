% ["Medicine","MEDICINE by Lucian Green Head of State Head Ache Prevention 1 of 4.txt",0,algorithms,"See also Hours Prayer."]

:-include('../listprologinterpreter/la_strings.pl').
:-include('../listprologinterpreter/la_strings_string.pl').

% word_count(["file","file.txt"],Words).
% Words = 69.

% word_count(["string","a b c"],Words).
% Words = 3.


% given file with number of As required and gl file length, gives div and mod values for t2b

word_count(Div,Mod) :-
	
		phrase_from_file_s(string([_,Tally]), "a_tally.txt"),
		%string_codes(String02b,String00a),
		%atom_to_term(String02b,[_,Tally],[]),
		
		
SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",

	(true->
	(phrase_from_file_s(string(String2), "lacom.txt"));
	String1=String2),
	split_string(String2,SepandPad,SepandPad,String3),
	%writeln(String3),
	length(String3,Words),
	
	Div is div((Tally*80),Words),
	Mod is mod((Tally*80),Words).
	

