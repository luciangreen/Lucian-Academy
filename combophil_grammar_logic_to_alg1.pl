/**

grammar_logic_to_alg.pl


e.g. I liked God with you
[liked,God],[God,you] with extra data
- connect liked to you with member, return words on path

POS

goes backwards x forwards
- I v n by v n x ignore

n,v
- single type

adjective
- ignored x (ignore names in alg)
- like v,n

joining words - ignore, just pairs v, n
- on
- joins v to n
- separates vns

negative terms
- switch to positive or ignore

disappearing words
- my
- no list of these, because they are ignored

vv is v1, v2 x v1
nn is n1

*

later: can randomly generate details like given sentence

**/

:-include('../listprologinterpreter/la_strings').
:-include('../Text-to-Breasonings/texttobrall2').
:-include('../Text-to-Breasonings/texttobr2qb').

:- dynamic brdict/1.

truncate(List1,M,String0) :-
	((number(M),length(String0,M),
	append(String0,_,List1))->true;
	String0=List1),!.

combophil_grammar_logic_to_alg1(P,String000) :-%%(String000) :-
	phrase_from_file_s(string(Text1), "luciansphilosophy.txt"),
	combophil_grammar_logic_to_alg2(String000,Text1).
	
combophil_grammar_logic_to_alg1(File) :-%%(String000) :-
	phrase_from_file_s(string(Text1), "file.txt"),
	string_codes(Text11,Text1),
	downcase_atom(%%B1
	Text11,B11),atom_string(B11,B12),
	SepandPad1=".\n",
	split_string(B12,SepandPad1,SepandPad1,A0),
	findall(_,(member(A00,A0),
	combophil_grammar_logic_to_alg2(String000,A00),
	%%String000="a b c",
	time((N = u, M = u,texttobr2(N,u,String000,M),texttobr(N,u,String000,M))),
%% Give the meditators, etc. the As.
	texttobr2(3)),_).

combophil_grammar_logic_to_alg2(String000,Text1) :-
	phrase_from_file_s(string(BrDict0), "../Text-to-Breasonings/brdict1.txt"),
	splitfurther(BrDict0,BrDict01),
	sort(BrDict01,BrDict012),
	retractall(brdict(_)),
	assertz(brdict(BrDict012)),

	%%SepandPad=".\n",
	%%split_string(Text1,SepandPad,SepandPad,Text2a),
	%%delete(Text2a,"",Text2),
	

	%%findall(B2,(member(B1,Text2),
	string_codes(Text11,Text1),
	downcase_atom(%%B1
	Text11,B11),atom_string(B11,B12),
	SepandPad1=" .\n",
	split_string(B12,SepandPad1,SepandPad1,A01),
	append(["go"],A01,A0),
	truncate(A0,20,A),

	findall(D,(member(C3,A),
		member([C3,"right"],BrDict012),member(C1,A),
		not(member([C1,"right"],BrDict012)),
		concat_list([C3," ",C1],C2),grammar_logic_to_alg(C2,D)),C),
	%%writeln(C),trace,
	
	%%grammar_logic_to_alg(D,B2)),C),
	length(C,CLength),
	writeln([CLength,sentences]),
	
	C=[[[_,Sentence1,a_alg(List_a),_,bb_alg(List_bb)]|Cs1]|Cs2],
		%%get_time(TS),stamp_date_time(TS,date(Year,Month,Day,Hour1,Minute1,Seconda,_A,_TZ,_False),local),
	concat_list(["gla_del"],%%[Year,Month,Day,Hour1,Minute1,Seconda],
	File1),
	concat_list(["\"",File1,".txt\""],File2),

	term_to_atom(List_a,List_a2),
	string_atom(List_a3,List_a2),
	
	concat_list(["swipl -G100g -T20g -L2g\n['../listprolog'].\nleash(-all),visible(+all),protocol(",File2,"),trace,interpret(off,[[n,function],[",List_a3,"]],[[[n,function],[[v,a]],\":-\",[[[n,length],[[v,a],0,1]]]],[[n,function],[[v,a]],\":-\",[[[n,head],[[v,a],[v,d]]],[[n,equals1],[[v,d],[[v,e],[v,f]]]],[[n,reverse],[[v,a],[],[v,a1]]],[[n,head],[[v,a1],[v,d1]]],[[n,equals1],[[v,d1],[[v,e1],[v,f1]]]],[[n,function2],[[v,a],[v,f],[v,f1]]]]],[[n,reverse],[[],[v,l],[v,l]]],[[n,reverse],[[v,l],[v,m],[v,n]],\":-\",[[[n,head],[[v,l],[v,h]]],[[n,tail],[[v,l],[v,t]]],[[n,wrap],[[v,h],[v,h1]]],[[n,append],[[v,h1],[v,m],[v,o]]],[[n,reverse],[[v,t],[v,o],[v,n]]]]],[[n,function2],[[v,a],[v,b],[v,f]],\":-\",[[[n,member2],[[v,a],[v,d]]],[[n,equals1],[[v,d],[[v,b],[v,f]]]]]],[[n,function2],[[v,a],[v,b],[v,c]],\":-\",[[[n,member2],[[v,a],[v,d]]],[[n,equals1],[[v,d],[[v,b],[v,f]]]],[[n,function2],[[v,d],[v,f],[v,c]]]]],[[n,length],[[],[v,l],[v,l]]],[[n,length],[[v,l],[v,m1],[v,n]],\":-\",[[[n,not],[[[n,=],[[v,l],[]]]]],[[n,tail],[[v,l],[v,t]]],[[n,+],[[v,m1],1,[v,m2]]],[[n,length],[[v,t],[v,m2],[v,n]]]]]],[[]]),notrace,noprotocol.\nhalt.\nswipl -G100g -T20g -L2g\n['../meditationnoreplace'].\ntime((N is 3,\nM is 16000,\ntexttobr2(N,",File2,",u,M),texttobr(N,",File2,",u,M))).\n['../texttobr2qb'].\ntexttobr2(3).\nhalt."],List_a1),
	writeln1([*,Sentence1,a_alg(List_a)]),
	writeln(List_a1),

	concat_list(["\n\nswipl -G100g -T20g -L2g\n['../listprolog'].\nleash(-all),visible(+all),protocol(",File2,"),trace,interpret(off,[[n,function],[",List_a3,",[v,b]]],[[[n,function],[[v,a],[v,b]],\":-\",[[[n,tail],[[v,a],[v,b]]]]]],_),notrace,noprotocol.\nhalt.\nswipl -G100g -T20g -L2g\n['../meditationnoreplace'].\ntime((N is 3,\nM is 16000,\ntexttobr2(N,",File2,",u,M),texttobr(N,",File2,",u,M))).\n['../texttobr2qb'].\ntexttobr2(3).\nhalt."],List_b1),
	writeln1([*,Sentence1,b_alg(List_a)]),
	writeln(List_b1),

	term_to_atom(List_bb,List_bb2),
	string_atom(List_bb3,List_bb2),

	concat_list(["swipl -G100g -T20g -L2g\n['../listprolog'].\nleash(-all),visible(+all),protocol(",File2,"),trace,interpret(off,[[n,function],[",List_bb3,"]],[[[n,function],[[v,a]],\":-\",[[[n,length],[[v,a],0,1]]]],[[n,function],[[v,a]],\":-\",[[[n,head],[[v,a],[v,d]]],[[n,equals1],[[v,d],[[v,e],[v,f]]]],[[n,reverse],[[v,a],[],[v,a1]]],[[n,head],[[v,a1],[v,d1]]],[[n,equals1],[[v,d1],[[v,e1],[v,f1]]]],[[n,function2],[[v,a],[v,f],[v,f1]]]]],[[n,reverse],[[],[v,l],[v,l]]],[[n,reverse],[[v,l],[v,m],[v,n]],\":-\",[[[n,head],[[v,l],[v,h]]],[[n,tail],[[v,l],[v,t]]],[[n,wrap],[[v,h],[v,h1]]],[[n,append],[[v,h1],[v,m],[v,o]]],[[n,reverse],[[v,t],[v,o],[v,n]]]]],[[n,function2],[[v,a],[v,b],[v,f]],\":-\",[[[n,member2],[[v,a],[v,d]]],[[n,equals1],[[v,d],[[v,b],[v,f]]]]]],[[n,function2],[[v,a],[v,b],[v,c]],\":-\",[[[n,member2],[[v,a],[v,d]]],[[n,equals1],[[v,d],[[v,b],[v,f]]]],[[n,function2],[[v,d],[v,f],[v,c]]]]],[[n,length],[[],[v,l],[v,l]]],[[n,length],[[v,l],[v,m1],[v,n]],\":-\",[[[n,not],[[[n,=],[[v,l],[]]]]],[[n,tail],[[v,l],[v,t]]],[[n,+],[[v,m1],1,[v,m2]]],[[n,length],[[v,t],[v,m2],[v,n]]]]]],[[]]),notrace,noprotocol.\nhalt.\nswipl -G100g -T20g -L2g\n['../meditationnoreplace'].\ntime((N is 3,\nM is 16000,\ntexttobr2(N,",File2,",u,M),texttobr(N,",File2,",u,M))).\n['../texttobr2qb'].\ntexttobr2(3).\nhalt."],List_bb1),
	writeln1([*,Sentence1,bb_alg(List_bb)]),
	writeln(List_bb1),

	writeln1(Cs1),
	writeln1(Cs2),
	
	term_to_atom([[CLength,sentences],[*,Sentence1,a_alg(List_a)],List_a1,[*,Sentence1,b_alg(List_a)],List_b1,[*,Sentence1,bb_alg(List_bb)],List_bb1,Cs1,Cs2],String0001),
atom_string(String0001,String000)

	%%a(P,String000):-	
	
		
		%%CLength=a,Sentence1=a,List_a=a,List_a1=a,List_b1=a,List_bb=a,List_bb1=a,Cs1=a,Cs2=a,

.

grammar_logic_to_alg(Sentence1,B) :- %% Not by multi-sentence algorithms, just by sentence
	atom_string(Sentence0,Sentence1),
	downcase_atom(Sentence0,Sentence01),
	atom_string(Sentence01,Sentence02),
	SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
	Connectors=
		["the","a","i","on","with","of","an","for","to",
		"was","were","and","in","my","from","out","by"],
	split_string(Sentence02,SepandPad,SepandPad,Sentence2),
	subtract(Sentence2,Connectors,Sentence3),
	%%length(Sentence3,Length),
	
	%% () add generated data
	%%write_commands(Length,[],Commands), %% sentence alg
	
	generate_sentences(Sentence3,[],Sentence_a,30), %% detail 	sentences
	append(Sentence3,Sentence_a,Sentence4),
	findall([*,Sentence1,a_alg(Sentence5),b_alg(Sentence5,a),bb_alg(Sentence6)],(member(Sentence4a,Sentence4),make_lists(Sentence4a,[],Sentence5),Sentence5=[_|Sentence6]),B),!.
	  %% detail algs
	
generate_sentences(_Sentence3,Sentence_a,Sentence_a,0) :- !.
generate_sentences(Sentence3,Sentence_a1,Sentence_a2,N1) :-
	random_member(Item,Sentence3),
	generate_sentence(Item,Sentence_a3),
	append(Sentence_a1,[Sentence_a3],Sentence_a4),
	N2 is N1-1,
	generate_sentences(Sentence3,Sentence_a4,Sentence_a2,N2).

%%write_commands(0,Commands,Commands) :- !.
%%write_commands(Length1,Commands1,Commands2) :-
%%	Length2 is Length1-1.
%%	append(Commands1,[[[n,member2],[[v,Length1],[v,Length2]]]).
	%%[[n,equals1],[[v,Length2],[[v,a***],[v,b]]]]].

%%[a,b]
%%[c,d]

generate_sentence(Item,Sentence) :-
	random_member(Grammar1,[[n,v,n],[n,v,a,n],[v,n],[v,a,n]]),
	brdict(BrDict012),
	find_pos(Item,POS,BrDict012),
	substitute1(Item,POS,Grammar1,[],Grammar2),
	substitute2(Grammar2,BrDict012,[],Sentence).

find_pos(Item,POS2,BrDict012) :-
	member([Item,POS1],BrDict012),
	POS1="right",
	POS2=v,!.
find_pos(Item,POS2,BrDict012) :-
	member([Item,POS1],BrDict012),
	POS1="plus",
	POS2=a,!.
find_pos(_Item,POS2,_BrDict012) :-
	POS2=n.

substitute1(_Item,_POS,[],Grammar,Grammar) :- !.
substitute1(Item,POS,Grammar1,Grammar2,Grammar3) :-
	Grammar1=[Grammar4|Grammar5],
	Grammar4=POS,
	append_list([Grammar2,Item],Grammar6),
	append(Grammar6,Grammar5,Grammar3),!.
substitute1(Item,POS,Grammar1,Grammar2,Grammar3) :-
	Grammar1=[Grammar4|Grammar5],
	not(Grammar4=POS),
	append_list([Grammar2,Grammar4],Grammar6),
	substitute1(Item,POS,Grammar5,Grammar6,Grammar3),!.

substitute2([],_BrDict012,Sentence,Sentence) :- !.
substitute2(Grammar1,BrDict012,Sentence1,Sentence2) :-
	Grammar1=[Grammar2|Grammar3],
	Grammar2=n,
	findall(A,(member([A,"box"],BrDict012)),B),
	random_member(Word,B),
	append(Sentence1,[Word],Sentence3),
	substitute2(Grammar3,BrDict012,Sentence3,Sentence2).
substitute2(Grammar1,BrDict012,Sentence1,Sentence2) :-
	Grammar1=[Grammar2|Grammar3],
	Grammar2=v,
	findall(A,(member([A,"right"],BrDict012)),B),
	random_member(Word,B),
	append(Sentence1,[Word],Sentence3),
	substitute2(Grammar3,BrDict012,Sentence3,Sentence2).
substitute2(Grammar1,BrDict012,Sentence1,Sentence2) :-
	Grammar1=[Grammar2|Grammar3],
	Grammar2=a,
	findall(A,(member([A,"plus"],BrDict012)),B),
	random_member(Word,B),
	append(Sentence1,[Word],Sentence3),
	substitute2(Grammar3,BrDict012,Sentence3,Sentence2).
substitute2(Grammar1,BrDict012,Sentence1,Sentence2) :-
	Grammar1=[Grammar2|Grammar3],
	append(Sentence1,[Grammar2],Sentence3),
	substitute2(Grammar3,BrDict012,Sentence3,Sentence2).

make_lists(Sentence1,Sentence,Sentence) :-
	Sentence1=[_Sentence2],
	!.	
make_lists(Sentence1,Sentence2,Sentence3) :-
	Sentence1=[Sentence4|Sentence5],
	Sentence5=[Sentence6|_Sentence7],
	append(Sentence2,[[Sentence4,Sentence6]],Sentence8),
	make_lists(Sentence5,Sentence8,Sentence3).
	
	