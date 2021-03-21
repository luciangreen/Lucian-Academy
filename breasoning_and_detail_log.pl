% ["Creating and Helping Pedagogues","CREATE AND HELP PEDAGOGUES by Lucian Green Pedagogy Helper - Write on Breasoning - Philosophy 3 of 4.txt",0,algorithms,"    28.    *I noticed the breasoning."]

:-include('../../listprologinterpreter/la_strings.pl').
:-include('../../listprologinterpreter/la_strings_string.pl').
:-include('word_count.pl').
:- use_module(library(date)).

/**

?- add_to_breasoning_log(["file","file.txt"]).
?- add_to_detail_log(["string","word"]).
?- view_breasoning_and_detail_log.
Breasoning Log
[2021,3,21,20,8,35.75380301475525,3,words]
[2021,3,21,20,8,51.36218309402466,3,words]

Detail Log
[2021,3,21,19,32,43.984174966812134,1,words]
[2021,3,21,20,9,13.19822907447815,1,words]
[2021,3,21,20,11,5.764134883880615,1,words]
[2021,3,21,20,12,0.05728793144226074,1,words]

**/

add_to_breasoning_log([Type,Content]) :-

	get_time(TS),stamp_date_time(TS,date(Year,Month,Day,Hour1,Minute1,Seconda,_A,_TZ,_False),local),

	% add to breasoning log
	% add file
	
	word_count([Type,Content],Words),

	phrase_from_file_s(string(String1), "brlog.txt"),
	string_codes(String02b,String1),
	atom_to_term(String02b,String02a,[]),
	
	append(String02a,[[Year,Month,Day,Hour1,Minute1,Seconda,Words,words]],String02c),
	
	term_to_atom(String02c,String02a_b),
	string_atom(String02a_c,String02a_b),

	(open_s("brlog.txt",write,Stream1),
	write(Stream1,String02a_c),
	close(Stream1)),!,

	concat_list(["brlog_",Year,Month,Day,Hour1,Minute1,Seconda],File1),
	(Type="file"->
	(concat_list(["cp ",Content," brlog/",File1,".txt"],Command),
	shell1_s(Command));
	((concat_list(["brlog/",File1,".txt"],File2),
	open_s(File2,write,Stream2),
	write(Stream2,Content),
	close(Stream2)),!)).

add_to_detail_log([Type,Content]) :-

	get_time(TS),stamp_date_time(TS,date(Year,Month,Day,Hour1,Minute1,Seconda,_A,_TZ,_False),local),

	% add to detail log
	% add file
	
	word_count([Type,Content],Words),

	phrase_from_file_s(string(String1), "detlog.txt"),
	string_codes(String02b,String1),
	atom_to_term(String02b,String02a,[]),
	
	append(String02a,[[Year,Month,Day,Hour1,Minute1,Seconda,Words,words]],String02c),
	
	term_to_atom(String02c,String02a_b),
	string_atom(String02a_c,String02a_b),

	(open_s("detlog.txt",write,Stream1),
	write(Stream1,String02a_c),
	close(Stream1)),!,

	concat_list(["detlog_",Year,Month,Day,Hour1,Minute1,Seconda],File1),
	(Type="file"->
	(concat_list(["cp ",Content," detlog/",File1,".txt"],Command),
	shell1_s(Command));
	((concat_list(["detlog/",File1,".txt"],File2),
	open_s(File2,write,Stream2),
	write(Stream2,Content),
	close(Stream2)),!)).

view_breasoning_and_detail_log :-
	
	phrase_from_file_s(string(String11), "brlog.txt"),
	string_codes(String02b1,String11),
	atom_to_term(String02b1,String02a1,[]),

	writeln("Breasoning Log"),
	
	findall(_,(member(Item,String02a1),writeln(Item)),_),
	
	nl,
	
	phrase_from_file_s(string(String1), "detlog.txt"),
	string_codes(String02b,String1),
	atom_to_term(String02b,String02a,[]),

	writeln("Detail Log"),
	
	findall(_,(member(Item,String02a),writeln(Item)),_).
	
