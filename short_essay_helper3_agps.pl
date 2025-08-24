%% Prolog Short Essay Helper

%% Keep 1,2,3 in aphors
%% Certain number of reasons per paragraph
%% Explains essay structure at start
%% Exposition (negative terms not allowed, asks for 5 groups from text to take optionally enough notes about, which can revise) and critique
%% Paraphrasing
%% Converts x, explains x, asks about
%% Allows citation of aphor
%% Prints citations used so far
%% Prints chapter, essay and allows changes (using text editor) at end.
%% Outputs db file and br dicts for marking later

%% *** Rewrite essay files with e.g. 1a. before aphors not 1. so not confused with aphors

%% short_essay_helper("file.txt",5,E),writeln1(E).

%%:-include('distances.pl').
:- use_module(library(date)).
%:-include('../listprologinterpreter/la_strings.pl').
%:-include('../listprologinterpreter/la_strings_string.pl').

:- dynamic critique3/1.
:- dynamic agree_disagree/1.
:- dynamic refs/1.
:- dynamic refs_long/1.

choose(List0,Item) :-
	random_member(Item10,List0),
	string_codes(Item10,List),
	split_string(List,".\n",".\n",List2),
	random_member(Item1,List2),
	string_concat(E,D,Item1),
	string_length(E,1),
	downcase_atom(E,E1),
	atom_string(E1,E2),
	string_concat(E2,D,Item2),
	string_concat(Item2,""%%"."
	,Item).
	
choose1(List0,Item) :-
	random_member(Item,List0).

delete_invisibles_etc(F,G) :-
	findall(J,(member(H,F),atom_string(H,J),not(J="."),not(J=".."),not(string_concat(".",_,J))),G).

string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).

short_essay_helper(Files,%%Filex,
	String01,
	Reasons_per_paragraph,Essay_0) :-
	retractall(critique3(_)),
	assertz(critique3([])),

	retractall(refs(_)),
	assertz(refs([])),

	retractall(refs_long(_)),
	assertz(refs_long([])),

	retractall(key_words(_)),
	assertz(key_words([])),

	findall(String02a,(member(Filex1,Files),
	%string_concat("sources/",Filex1,Filex),
		%phrase_from_file_s(string(String00a), Filex),
		%string_codes(String02b,String00a),
		atom_to_term(Filex1,String02a,[])
		%%split_string(String00, "\n\r", "\n\r", [String01a|_]),

		%%prepare_file_for_ml(String00,String02a)
		),String00),
		
		%%trace,
		%%writeln1(String00),
		%%notrace,
	
%%writeln1(String02),


	generate_file_name(File1,_File2),

	Numbers=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25],
	explain_structure(String01,Reasons_per_paragraph,File1),
	exposition(String00,String01,Reasons_per_paragraph,Numbers,String02,Exposition),

	%%concat_list(["Do you agree or disagree with ",String01," (a/d) ? "],String2ad),%%get_string(String2ad,either,one-not-ml,"","",String3ad),
	choose1(["a"%%,"d"
	],String3ad),
	
	(String3ad="a"->
	(retractall(agree_disagree(_)),
	assertz(agree_disagree(agree)));
	(retractall(agree_disagree(_)),
	assertz(agree_disagree(disagree)))),


critique(String00,String01,Reasons_per_paragraph,Numbers,String02,Critique),

agree_disagree(Pole),

	%%concat_list(["What is the future area of research from your essay about ",String01,"? "],Future_research_prompt),
	%%trace,
	%%get_string(Future_research_prompt,either,one-not-ml,"","",Future_research),
	choose_sentence_range(String00,N_page_ref,String00a1,String00a2,_String00a3,String00a4),
	choose(String00a4,String00a5),
	concat_list(["In ",String01,", automation should apply to ",String00a5," (",String00a2,", p. ",N_page_ref,")."],Future_research),
	reference(String00a1),
	
	refs(R2),refs_long(_R21),

%term_to_atom([Exposition,Critique,String3ad,Future_research,R21],File_contents),open_s(File1,write,Stream),write(Stream,File_contents),close(Stream),

%% Output essay
%%findall(_,(member(Exposition1,Exposition),Exposition1=


%%writeln1([Exposition,Critique,Future_research,R2]),

write_essay(String01,Pole,Exposition,Critique,Future_research,R2,Essay_0,_HTML)
%writeln1(Essay_0)
/**
	(open_s(File2,write,Stream1),
%%	string_codes(BrDict3),
	write(Stream1,HTML),
	close(Stream1))
	**/
	.

%% replace("a\nb","\n","<br>\n",F).
%% F="a<br>\nb<br>\n".

replace(A,Find,Replace,F) :- 	
	split_string(A,Find,Find,B),findall([C,Replace],(member(C,B)),D),maplist(append,[D],[E]),concat_list(E,F).

concat_list1(D,F) :-
	maplist(append,[D],[E]),concat_list(E,F).

write_essay(String01,Pole,Exposition,Critique,Future_research,R2,Essay,HTML) :-
	write_heading(String01,Heading),
	write_introduction(String01,Pole,Critique,Introduction),
	write_exposition(Exposition,Exposition2a),
	concat_list(["I will expose ",String01," in this half.  ",Exposition2a],Exposition2),
	%%string_concat(Exposition2,"\n",Exposition2a),
	write_critique(Critique,Critique2a),
	string_concat(Critique2a,"\n",Critique2b),
	atom_string(Pole,Pole1),
	concat_list(["I will ",Pole1," with ",String01," in this half.  ",Critique2b],Critique2),
	write_conclusion(String01,Pole,Critique,Future_research,Conclusion),
	write_references(R2,References,Refs_no_heading),
	concat_list([Heading,Introduction,Exposition2,Critique2,Conclusion,References],
	Essay),
	concat_list([Introduction,Exposition2,Critique2,Conclusion],
	Essay2),
	replace(Essay2,"\n","<br>",HTML1),
	replace(Refs_no_heading,"\n","<br>",Refs_no_heading2),
	concat_list(["<html><head><title>",String01,"</title></head><body><h1>",
	String01,"</h1>",HTML1,"<h2>Bibliography</h2>",Refs_no_heading2,"</body></html>"],HTML).
	
write_heading(String01,Heading) :-
	concat_list([String01,"\n","\n"],Heading).

write_introduction(String01,Pole1,Critique,Introduction) :-
	%% The heading should be in the form "Author's topic"
	atom_string(Pole1,Pole2),
	findall([Paragraph_topic_sentence,"  "],(member(A,Critique),A=[_,[Paragraph_topic_sentence|_]|_]),Paragraph_topic_sentences1),
	concat_list1(Paragraph_topic_sentences1,Paragraph_topic_sentences2),
	concat_list(["I will critically analyse ",String01,".  ",
	"I will ",Pole2," with ",String01,".  ",
	Paragraph_topic_sentences2,"\n\n"],Introduction).

write_conclusion(String01,Pole1,Critique,Future_research,Conclusion) :-
	atom_string(Pole1,Pole2),
	findall([Paragraph_topic_sentence,"  "],(member(A,Critique),A=[_,[Paragraph_topic_sentence|_]|_]),Paragraph_topic_sentences1),
	concat_list1(Paragraph_topic_sentences1,Paragraph_topic_sentences2),
	concat_list([
	Paragraph_topic_sentences2,
	"I have ",Pole2,"d with ",String01,".  ",
	Future_research,"\n\n"
	],Conclusion).

write_references(R2,References,Refs_no_head) :-
	findall([Reference,"\n"],member(Reference,R2),References1),
	concat_list1(References1,References2),
	concat_list([References2],Refs_no_head),
	concat_list(["Bibliography","\n\n",References2],References).

%%a1
%% write_exposition([[[1,"g1"]],[[1,1,_15410,_15416,"a1","a1 is in g1."],[1,2,_15352,_15358,"a2","g1 contains a2."]]],A),writeln1(A).
%% A = "a1  a1 is in g1.  a2  g1 contains a2.  ".

%% write_exposition([[[1,"g1"],[1,"g1"]],[[1,1,_15410,_15416,"a1","a1 is in g1."],[1,2,_15352,_15358,"a2","g1 contains a2."],[1,1,_15410,_15416,"a1","a1 is in g1."],[2,2,_15352,_15358,"a2","g1 contains a2."]]],A).
%% A = "a1  a1 is in g1.  a2  g1 contains a2.  a1  a1 is in g1.  a2  g1 contains a2.  ".

write_exposition(Exposition,Essay4b) :-
	Numbers=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25],

Exposition=[_,Exposition2],


findall([Essay4c%%,"\n"
],(member(Numbera11,Numbers),


%% not "" with findall
findall(Essay4,(
%%member(Exposition1,Exposition),
%%Exposition1=[Numbera11,_Number3a,_String3,_String3a,String5a,String3y,_String3ay,String5a1,_CNumber2aa,_CNumber3aa,CString5a1a,_CNumber2a1,_CNumber3a1,_LastCStrings,String5aaa],
	
	
%%output_exposition(Numbera11,Exposition2,"",Essay1),
	
	%%findall( Essay4,(
	member(Exposition1,Exposition2),Exposition1=[Numbera11,_Number3a,_String3,_String3a,String5a,Group_link],
	concat_list([String5a,"  ",Group_link,"  "],Essay4)
	%%delete(Exposition,Exposition1,Exposition2)
	%%output_exposition(Numbera11,Exposition2,Essay4,Essay6)
),Essay4a),
concat_list(Essay4a,Essay4c1),%%trace,
(Essay4c1=""->Essay4c="";concat_list([Essay4c1,"\n"],Essay4c))

),Essay4d),

maplist(concat_list,Essay4d,Essay4f),
concat_list(Essay4f,Essay4b)
%%concat_list([Essay4e,"\n"],Essay4b)
%%concat_list([Essay1,"  ",Essay3],Essay2),
		%%concat_list([Essay2,"\n"],Essay23))
%%,Essay3a),
	%%concat_list(Essay3a,Essay4a)
.
%% *** HTML (<br> not \n)

%%%%%
%%a

%% write_critique([[1,["heading is e12",[1,1,_25346,_25352,"e1",_25370,_25376,"e12"],[1,2,_25412,_25418,"e2",_25436,_25442,"e22",1,1,"e12",0,0,"e22","e12 is e22"]]]],A),writeln1(A).
%% A = "heading is e12  e1  e12    e2  e22  e12 is e22  \n".

write_critique(Critique,Essay4):-
	Numbers=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25],

findall(Essay23,(member(Numbera11,Numbers),

%% not "" with findall
%%findall(Essay22,(
member(Critique1,Critique),
%%Critique1=[Numbera11,_Number3a,_String3,_String3a,String5a,String3y,_String3ay,String5a1,_CNumber2aa,_CNumber3aa,CString5a1a,_CNumber2a1,_CNumber3a1,_LastCStrings,String5aaa],
	
Critique1=[Numbera11,[Para_topic_sent,[_Number2a,_Number3a,_String3,_String3a,String5a,_String3y,_String3ay,String5a1]|Critique2]],
	
concat_list([Para_topic_sent,"  ",String5a,"  ",String5a1,"  "],Essay0),output_critique(Numbera11,Critique2,String5a1,Essay0,Essay1),
	
		concat_list([Essay1,Para_topic_sent,"\n"],%%Essay22)

%%),
Essay23)),Essay3),
	concat_list(Essay3,Essay4)
.
%% *** HTML (<br> not \n)

output_critique(_Numbera11,[],_String5a1a,Essay,Essay) :- !.
output_critique(Numbera11,Critique,CString5a1a,Essay1,Essay2) :-
findall( Essay6,(member(Critique1,Critique),Critique1=[Numbera11,_Number3a,_String3,_String3a,String5a,_String3y1,_String3ay,String5a1,
_CNumber2aa,_CNumber3aa,CString5a1a,
	_CNumber2a1,_CNumber3a1,_LastCStrings,
	String5aaa],
	concat_list([String5a,"  ",String5a1,"  ",String5aaa,"  "],Essay4),
	delete(Critique,Critique1,Critique2),
	output_critique(Numbera11,Critique2,String5aaa,Essay4,Essay6)
),Essay33),
%%trace,
(Essay33=[]->concat_list([Essay1%%,"  "
],Essay2);%%(Essay33=[Essay3]->concat_list([Essay1,"  ",Essay3],Essay2);%%(Essay33=[Essay3|[E33]]-> concat_list([Essay1,"  ",Essay3,E33],Essay2);
(Essay33=[Essay3|E33], concat_list(E33,E34),concat_list([Essay1,%%"  ",
Essay3,E34],Essay2)))
%%)
%%)
.


/**critique(String00,String01,Reasons_per_paragraph,Numbers,Critique).
	**/
	
generate_file_name(File1,File2) :-
			get_time(TS),stamp_date_time(TS,date(Year,Month,Day,Hour1,Minute1,Seconda,_A,_TZ,_False),local),
	concat_list(["file",Year,Month,Day,Hour1,Minute1,Seconda,".txt"],File1),
		concat_list(["file",Year,Month,Day,Hour1,Minute1,Seconda,".html"],File2).


explain_structure(String01,Reasons_per_paragraph,_File1) :-
	concat_list(["The Short Essay Helper will automatically structure and write your essay about ",String01," with ",Reasons_per_paragraph," reasons per paragraph.","\n",
	"The Helper will help write an exposition (which summarises but doesn't critique the idea), a critique (which agrees with or disagrees with the topic), the introduction and the conclusion (which state whether you agreed or disagreed with the topic, etc.).  Citations will be automatically made.","\n","Note: Generated essays are not to be handed in, and you need to paraphrase and cite work you have referenced.  Your grade depends on whether you agree or disagree and how many breasonings you breason out.  Check the referencing style is appropriate for your class.","\n"],String1).
	%writeln(String1).

choose_sentence_range(String00,N2,B,B1,B2,C) :-
	length(String00,L),
	numbers(L,1,[],N),
	random_member(N1,N),
	get_item_n(String00,N1,A),
	A=[B,B1,B2|C],
	N2 is N1+B2-1.
	%%random_member(A,String00),
	
exposition(String00,_String01,Reasons_per_paragraph,Numbers,ML_db,Exposition1) :-
	length(List1,5), %% 5->1 paragraphs per exposition
	append(List1,_,Numbers),
	length(List2,Reasons_per_paragraph),
	append(List2,_,Numbers),

	%%string_codes(String001,String00),
	%%writeln(String001),
	findall([Number1,Exposition2],(
		%%trace,
member(Number1,List1),%%concat_list(["What is group ",Number1," of 5 in the exposition that groups ideas about ",String01,"? "],String1),%%get_string(String1,either,one-not-ml,"","",%ML_db,Exposition2)
%% ** Doesn't print this
choose_sentence_range(String00,N_page_ref,String00a1,String00a2,_String00a3,String00a4),
	choose(String00a4,String00a5),
	concat_list([String00a5," (",String00a2,", p. ",N_page_ref,") "],Exposition2),
	reference(String00a1)),Exposition3),
	

	findall([Number2,Number3,String3,String3a,String5a,String5],(
	member(Number2,List1),member(Number3,List2),get_item_n(Exposition3,Number2,[_,Item1]),
	%%trace,
	concat_list(["<Exposition Paragraph ",Number2," of 5 - ",Item1,"> <Reason ",Number3," of ",Reasons_per_paragraph,">","\n","The Helper will ask you how the quote you are about to enter relates to the paragraph topic."],String2b),%writeln(String2b),
	%%trace,
exposition2(String00,Item1,ML_db,String3,String3a,String5a,String5)
	),Exposition4),
	Exposition1=[Exposition3,Exposition4].
	
exposition2(String00,Item1,ML_db,String3,String3a,String5a,String5):-
	(%%concat_list(["What is the paragraph number of the quote about the paragraph topic ",Item1,"? "],String2),get_number(String2,String3),
	%%concat_list(["What is the sentence number of the quote about the paragraph topic ",Item1,"? "],String2a),get_number(String2a,String3a),
	%%member1a([String3,String3a,String3aa],ML_db),
	%%concat_list(["What is the paraphrased quote about the paragraph topic ",Item1,"? "],String4a),%%get_string(String4a,either,one-not-ml-ref,"",String3aa,String5a),
	choose_sentence_range(String00,N_page_ref,String00a1,String00a2,_String00a3,String00a4),
	choose(String00a4,String00a5),
	concat_list([Item1," is because ",String00a5," (",String00a2,", p. ",N_page_ref,")."],String5a),
	reference(String00a1),
	
	%%concat_list(["How does the quote you entered (",String5a,") relate to the paragraph topic ",Item1,"? "],String4),
	%%trace,
	%%SepandPad="#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\!'0123456789",%%downcase_atom(Item1,String41a),split_string(String41a, SepandPad, SepandPad, Item1a),
	
	%%get_string(String4,either,one-not-ml,Item1a,String3aa,String5)
	
		choose_sentence_range(String00,N_page_ref1,String00a11,String00a21,_String00a31,String00a41),
	choose(String00a41,String00a51),
	concat_list([Item1," is because ",String00a51," (",String00a21,", p. ",N_page_ref1,")."],String5),
	reference(String00a11)
)
	->true;exposition2(String00,Item1,ML_db,String3,String3a,String5a,String5).

%% Agree or disagree

critique(String00,String01,Reasons_per_paragraph,Numbers,ML_db,Critique1) :-
	length(List1,5), %% 5->1 paragraphs per critique
	append(List1,_,Numbers),
	length(List2,Reasons_per_paragraph),
	append(List2,_,Numbers),

	%%string_codes(String001,String00),
	%%writeln(String001),

	retractall(critique3(_)),
	assertz(critique3([])),


	findall([Number2a,Critique2],(
%% Reason 1

member(Number2a,List1),
%%List1=[Number2a|List1a],
List2=[Number3a|List2a],
%%trace,


critique_reason1(String00,String01,Number2a,Number3a,Reasons_per_paragraph,ML_db,Critique3,Topic_paragraph_link),

critique_reasons_2_to_n(String00,Number2a,List2a,Critique3,Reasons_per_paragraph,ML_db,Critique4),

	append_list2([[Topic_paragraph_link],Critique3,Critique4],Critique2)),Critique1).
	
	critique_reason1(String00,String01,Number2a,Number3a,Reasons_per_paragraph,ML_db,Critique3,Topic_paragraph_link) :-

	%%member(Number2,List1),member(Number3,List2),
	%%get_item_n(Critique3,Number2a,[_,Item1]),
	%%trace,
	concat_list(["<Critique Paragraph ",Number2a," of 5> <Reason ",Number3a," of ",Reasons_per_paragraph,">","\n","The Helper will ask you for your comment on the quote you are about to enter."],String2b),%writeln(String2b), 
	%% Later: connections

	%%trace,
critique2(String00,String01,ML_db,String3,String3a,String5a,_String3y2,String3ay,String5a1,Topic_paragraph_link),
	%%),Critique4).
	Critique3=[[Number2a,Number3a,String3,String3a,String5a,_String3y3,String3ay,String5a1]].
	
critique2(String00,String01,ML_db,String3,String3a,String5a,String3y,String3ay,String5a1,Topic_paragraph_link):-
	(%%concat_list(["What is the paragraph number of the quote to comment on? "],String2),get_number(String2,String3),
	%%concat_list(["What is the sentence number of the quote to comment on? "],String2a),get_number(String2a,String3a),
	%%member1a([String3,String3a,String3aa],ML_db),
	%%concat_list(["What is the paraphrased quote to comment on? "],String4a),%%get_string(String4a,either,one-not-ml-ref,"",String3aa,String5a),
	
			choose_sentence_range(String00,N_page_ref1,String00a11,String00a21,_String00a31,String00a41),
	choose(String00a41,String00a51),
	concat_list([String00a51," (",String00a21,", p. ",N_page_ref1,")."],String5a),
	reference(String00a11),

	%%concat_list(["Is your comment from a quote (y/n)? "],String2yn),get_string(String2yn,either,one-not-ml,"","",String3yn),
	
	%%agree_disagree(Pole),

	(%%String3yn="y"
	true->
	(%%concat_list(["What is the paragraph number of the comment? "],String2y),get_number(String2y,String3y),
	%%concat_list(["What is the sentence number of the comment? "],String2ay),get_number(String2ay,String3ay),
	%%trace,
	%%member1a([String3y,String3ay,String3aay],ML_db),
	
	%% use either original x or paraphrase
	
	%%concat_list(["What is the comment that is from the quote? "],String4ac),
	%%trace,
	%%get_string(String4ac,either,one-not-ml-ref,"",String3aay,String5a1)
	
				choose_sentence_range(String00,N_page_ref2,String00a12,String00a22,_String00a32,String00a42),
	choose(String00a42,String00a52),
	concat_list([String00a52," (",String00a22,", p. ",N_page_ref2,")."],String5a1),
	reference(String00a12)

		)
		
	;(String3y=0,String3ay=0,
	%%concat_list(["What is the comment? "],String4ac),%%get_string(String4ac,either,one-not-ml,"","",%%String5a,
%%	String5a1)

				choose_sentence_range(String00,N_page_ref3,String00a13,String00a23,_String00a33,String00a43),
	choose(String00a43,String00a53),
	concat_list([String00a53," (",String00a23,", p. ",N_page_ref3,")."],String5a1),
	reference(String00a13)

)),
	
	%%concat_list(["How does the comment ",String5a1," relate to the essay topic ",String01,"? "],Topic_paragraph_link_prompt),
	%%trace,
	
	%%downcase_and_split(String5a1,String5a1ds),
	%%downcase_and_split(String01,String01ds),
	%%get_string(Topic_paragraph_link_prompt,either,one-not-ml,String5a1ds,String01ds,Topic_paragraph_link)
	
	string_concat(String5a1_az,".",String5a1),			choose_sentence_range(String00,N_page_ref4,String00a14,String00a24,_String00a34,String00a44),
	choose(String00a44,String00a54),
	concat_list([String01," is because of ",String5a1_az," because of ",String00a54," (",String00a24,", p. ",N_page_ref4,")."],Topic_paragraph_link),
	reference(String00a14)

	/**
	%% conn - choose connected comments
	concat_list(["How does the quote you entered (",String5a,") relate to the paragraph topic ",Item1,"? "],String4),
	%%trace,
	SepandPad="#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\!'0123456789",downcase_atom(Item1,String41a),split_string(String41a, SepandPad, SepandPad, Item1a),
	
	get_string(String4,either,two,Item1a,String3aa,String5)
	**/
	)
	->true;critique2(String00,ML_db,String3,String3a,String5a,String3y,String3ay,String5a1,Topic_paragraph_link).



critique_reasons_2_to_n(String00,Number2a,List2a,Critique3,Reasons_per_paragraph,ML_db,Critique4) :-
	retractall(critique3(_)),
	assertz(critique3(Critique3)),
%%trace,
/**	critique3(Critique31),
	append(Critique31,Critique3,Critique32),
	retractall(critique3(_)),
	assertz(critique3(Critique32)),
**/
%%notrace,
findall([Number2a,Number3a,String3,String3a,String5a,String3y,String3ay,String5a1,
CNumber2aa,CNumber3aa,CString5a1a,
	CNumber2a1,CNumber3a1,LastCStrings,
	String5aaa],(
	%%member(Number2,List1a),
	member(Number3a,List2a),
	%%get_item_n(Critique3,Number2a,[_,Item1]),
	%%trace,
	concat_list(["<Critique Paragraph ",Number2a," of 5> <Reason ",Number3a," of ",Reasons_per_paragraph,">","\n","The Helper will ask you for your comment on the quote you are about to enter."],String2b),%writeln(String2b), 
	%% Later: connections

	
	%%trace,
critique3(String00,ML_db,%%Critique3,
String3,String3a,String5a,String3y,String3ay,String5a1,
CNumber2aa,CNumber3aa,CString5a1a,
	CNumber2a1,CNumber3a1,LastCStrings,
	String5aaa)
	

/**
	trace,
	critique3(Critique31),
	append(Critique31,[[String3,String3a,String5a,String3y,String3ay,String5a1]],Critique32),
	retractall(critique3(_)),
	assertz(critique3(Critique32))
**/

),
	Critique4).
	
	%%Critique3=[].
	
critique3(String00,ML_db,%%Critique3,
String3,String3a,String5a,String3y,String3ay,String5a1,
CNumber2aa,CNumber3aa,CString5a1a,
	CNumber2a1,CNumber3a1,LastCStrings,
	String5aaa):-
	(%%concat_list(["What is the paragraph number of the quote to comment on? "],String2),get_number(String2,String3),
	%%concat_list(["What is the sentence number of the quote to comment on? "],String2a),get_number(String2a,String3a),
	%%member1a([String3,String3a,String3aa],ML_db),
	%%concat_list(["What is the paraphrased quote to comment on? "],String4a),%%get_string(String4a,either,one-not-ml-ref,"",String3aa,String5a),
	%%trace,
					choose_sentence_range(String00,N_page_ref4,String00a14,String00a24,_String00a34,String00a44),
	choose(String00a44,String00a54),
	concat_list([String00a54," (",String00a24,", p. ",N_page_ref4,")."],String5a),
	reference(String00a14),

	
	%%concat_list(["Is your comment from a quote (y/n)? "],String2yn),%%get_string(String2yn,either,one-not-ml,"","",String3yn),
	
	%%agree_disagree(Pole),

	(true->%%String3yn="y"->
	(%%concat_list(["What is the paragraph number of the comment? "],String2y),get_number(String2y,String3y),
	%%concat_list(["What is the sentence number of the comment? "],String2ay),get_number(String2ay,String3ay),
	%%trace,
	%%member1a([String3y,String3ay,String3aay],ML_db),
	
	%% use either original x or paraphrase x
	%%trace,
	%%concat_list(["What is the comment that is from the quote? "],String4ac),
	%%trace,
	%%get_string(String4ac,either,one-not-ml-ref,"",String3aay,String5a1)
	
						choose_sentence_range(String00,N_page_ref5,String00a15,String00a25,_String00a35,String00a45),
	choose(String00a45,String00a55),
	concat_list([String00a55," (",String00a25,", p. ",N_page_ref5,")."],String5a1),
	reference(String00a15)

	%%,trace
		)
		
	;(String3y=0,String3ay=0,
	concat_list(["What is the comment? "],String4ac),
	
	%% This is never chosen
	get_string(String4ac,either,one-not-ml,"","",%%String5a,
	String5a1))),
	%%*** assertz recurse not findall new critique3 x


	%%trace,
	critique3(Critique31),
	append(Critique31,[[0,0,String3,String3a,String5a,String3y,String3ay,String5a1]],Critique32),
	retractall(critique3(_)),
	assertz(critique3(Critique32)),

	critique3(Critique33),


((


	%%critique3(Critique3),
	length(Critique33,LCritique3),
	%%length(List1,LCritique3),
	numbers(LCritique3,1,[],List1),
	%%append(List1,_,Numbers),
	%%Numbers=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25],
	%%trace,

findall([N," - ",CString5a1,"\n"],(member(N,List1),get_item_n(Critique33,N,[CNumber2a,CNumber3a,_CString3,_CString3a,_CString5a,_CString3y,_CString3ay,CString5a1])),CStrings1),

findall([N,CNumber2a,CNumber3a,CString5a1],(member(N,List1),get_item_n(Critique33,N,[CNumber2a,CNumber3a,_CString31,_CString3a1,_CString5a1,_CString3y1,_CString3ay1,CString5a1])),CStrings2),

%%trace,

%%CStrings=[CStrings1,CStrings2],
reverse(CStrings2,CStringsR),CStringsR=[[_,CNumber2a1,CNumber3a1,LastCStrings]|CStringsR1],
reverse(CStringsR1,CStringsRR),

reverse(CStrings1,CStringsR10),CStringsR10=[_|CStringsR11],
reverse(CStringsR11,CStringsRR1),

append_list2(CStringsRR1,CStrings11),
concat_list(CStrings11,_CStrings12),
%%concat_list(["Please select a comment to connect the comment ",LastCStrings," to:","\n",CStrings12],ConnectionNumberPrompt),
%%get_number(ConnectionNumberPrompt,ConnectionNumber),
%numbers(
choose1(List1,ConnectionNumber),
	member([ConnectionNumber,CNumber2aa,CNumber3aa,CString5a1a],CStringsRR),
	
		%%SepandPad="#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\!'0123456789",%%downcase_atom(CString5a1a,CString5a1a1),split_string(CString5a1a1, SepandPad, SepandPad, CString5a1a2),
		
		%%CNumber2a1,CNumber3a1,
		%%downcase_atom(LastCStrings,LastCStrings_a),split_string(LastCStrings_a, SepandPad, SepandPad, LastCStrings_a1),
		

	%% conn - choose connected comments, this to a previous comment
	%%trace,
	
	%%concat_list(["How does ",LastCStrings," connect to ",CString5a1a,"? "],ConnectionPrompt),

	%%get_string(ConnectionPrompt,either,one-not-ml,CString5a1a2,LastCStrings_a1,String5aaa)

	string_concat(LastCStrings_az,".",LastCStrings),
	string_concat(CString5a1a_az,".",CString5a1a),						choose_sentence_range(String00,N_page_ref6,String00a16,String00a26,_String00a36,String00a46),
	choose(String00a46,String00a56),
	concat_list([LastCStrings_az," is because of ",CString5a1a_az," because of ",String00a56," (",String00a26,", p. ",N_page_ref6,")."],String5aaa),
	reference(String00a16)

	
	)->true;(
	
	%% If the section since updating dynamic critique comments fails, prevent doubling of critique comments
	
		critique3(Critique311),
		reverse(Critique311,Critique312),
		Critique312=[_|Critique313],
		reverse(Critique313,Critique314),
	retractall(critique3(_)),
	assertz(critique3(Critique314)),fail

	))
	
/**		Critique4=[String3,String3a,String5a,String3y,String3ay,String5a1,
	CNumber2aa,CNumber3aa,CString5a1a,
	CNumber2a1,CNumber3a1,LastCStrings,
	String5aaa],
	**/
	/**
	critique3(Critique31),
	append(Critique31,[[String3,String3a,String5a,String3y,String3ay,String5a1]],Critique32),
	retractall(critique3(_)),
	assertz(critique3(Critique32))
**/

	)
	%% Retries the predicate if it fails
	->true;critique3(String00,ML_db,%%Critique3,
	String3,String3a,String5a,String3y,String3ay,String5a1,
	CNumber2aa,CNumber3aa,CString5a1a,
	CNumber2a1,CNumber3a1,LastCStrings,
	String5aaa
	).
	
	
	
	
member1a([String3,String3a,String3aa],ML_db) :-
	member([String3,String3a,String3aa],ML_db),!.

	
get_item_n(Exposition,Number1,Item) :-
	Number2 is Number1-1,
	length(List,Number2),
	append(List,[Item|_],Exposition).

get_number(Prompt1,Number) :-
	%%concat_list(Prompt1,Prompt2),
	(%%repeat,
	writeln(Prompt1),read_string(user_input, "\n", "\r", _End1, String),split_string(String, ",", " ", Value1),Value1=[Value2],number_string(Number,Value2)).
	
	
/**
get_string(Prompt1,String1) :-
	concat_list(Prompt1,Prompt2),
	(repeat,write(Prompt2),read_string(String1),not(String1="")).
**/	

equals_empty_list([]).

downcase_and_split(String1,	String2) :-
SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
	downcase_atom(String1,String3),split_string(String3, SepandPad, SepandPad, String2).

get_string(Prompt2,Flag1,Flag2,ML_db0,ML_db1,String2) :-
%%writeln1(get_string(Prompt2,Flag1,Flag2,ML_db1,String2)),
	%%concat_list(Prompt1,Prompt2),
		%%trace,
		SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
	%%(repeat,
	(Flag2=one-not-ml-ref->(concat_list(["Note: Enter in-text reference using AGPS, e.g.\n","The first work supports the second work (Surname 2000, pp. 18-9).\n","Surname (2000, pp. 18-9) states that ...\n","Remember to use words like \"also\", \"moreover\" and \"in addition\" before the sentence."],String_a1),writeln(String_a1));true),
	writeln(Prompt2),read_string(user_input, "\n", "\r", _End2, String2aa),%%not(String2aa=""),
	%%String2aa=[String2aaa],
	downcase_atom(String2aa,String3),split_string(String3, SepandPad, SepandPad, String4),
	Neg_term_list=["no","not","don","t","shouldn","wouldn","disagree","differ","dislikes","disagrees","differs","dislikes","disagreed","differed","disliked","negative","negation","non","negate","negates","negated","but","however","isn","lack"],
	(Flag1=%%non_negative
	positive->(
	
	(findall(Item11,(
	
	member(Item1,String4),
		findall(Item1,(
member(Item2,Neg_term_list),(Item1=Item2->(write("Error: Contains the negative term \""),write(Item1),writeln("\".")))),Item11)),Item12)),

maplist(equals_empty_list,Item12)

);
	((Flag1=negative->((member(Item1,String4),member(Item1,Neg_term_list))->true;(writeln("Error: Contains no negative term, one of:"),writeln(Neg_term_list),fail));true)->true;Flag1=either)),
	(Flag2=one-not-ml->String2=String2aa;
	(Flag2=one-not-ml-ref->
	(refs(R1),writeln("What is the reference? e.g. Surname, A 2000, <i>Title: Subtitle</i>, Publisher, City.\n"),writeln("Existing references (copy one or many delimited with \"\\n\"):"), findall(_,(member(R11,R1),writeln(R11)),_),read_string(user_input, "\n", "\r", _End3, String2r),not(String2r=""),%%downcase_atom(String2r,_String3r),
	String2=String2aa,split_string(String2r,"\n\r","\n\r",String2r3),
	%%trace,
	retractall(refs(_)),maplist(append,[[R1,String2r3]],[String2r21]),
	sort1(String2r21,String2r2),
	assertz(refs(String2r2))%%split_string(String3r, SepandPad, SepandPad, String4)
	);
(Flag2=one->(%%split_string(String4,SepandPad,SepandPad,String21),
	writeln("Attempt 1"),
	
	(length(String4,Length_string1),
(check_strings_container1(Length_string1,String4,[0,0,ML_db1],[[0,0,[xxx,xxx,xxx,xxx,xxx]],[0,0,ML_db1],[999,999,[]]],_,_List2)->
		writeln("Success");(writeln("Failed"),fail))
	%%(%%data_instance_k_classification1([[0,0,[xxx,xxx,xxx,xxx,xxx]],[0,0,ML_db1]%%,[999,999,[]]
	%%],[0,0,String4]%%21
	%%,1,String4a%%21
	%%),
	%%String4=String4a)
	%%)->
		%%(%%String4a=[_,_,String4a1],
		%%writeln([found,String4a,String4]),
%%writeln("Success"));
	%%(writeln("Failed"),fail)
	%%
	));
	(Flag2=%%[
	two,%%,P1,S1,P2,S2],
	%%trace,
	append([ML_db0],[ML_db1],ML_db2),
	check_strings(String4,ML_db2%%,P1,S1,P2,S2
	))))).
	
reference(String2r) :-
	refs_long(R10),
	(refs(R1),%%writeln("What is the reference? e.g. Surname, A 2000, <i>Title: Subtitle</i>, Publisher, City.\n"),writeln("Existing references (copy one or many delimited with \"\\n\"):"), 
	findall(_,(member(R11,R1)%,writeln(R11)
	),_),%%read_string(user_input, "\n", "\r", _End4, String2r),
	not(String2r=""),%%downcase_atom(String2r,_String3r),
	%%String2=String2aa,
	split_string(String2r,"\n\r","\n\r",String2r3),
	%%trace,
	retractall(refs(_)),maplist(append,[[R1,String2r3]],[String2r21]),
	retractall(refs_long(_)),maplist(append,[[R10,String2r3]],[String2r210]),
	sort1(String2r21,String2r2),
	assertz(refs(String2r2)),
	assertz(refs_long(String2r210))%%split_string(String3r, SepandPad, SepandPad, String4)
	).
	

%% Sorts by first surname then title in AGPS

sort1(List1,List2) :-
	findall([C,B],(member(B,List1),downcase_atom(B,D),atom_string(D,C)),E),sort(E,F),findall(G,member([_,G],F),List2).


prepare_file_for_ml(String000,String021) :-
	string_codes(String001,String000),
	downcase_atom(String001,String00),
	split_string(String00, "\n\r", "\n\r", String01),
	delete(String01,"",String02),
	findall(String03,(member(String02a,String02),split_string(String02a,".",".",String04),
		((String04=[String05|String06],
		number_string(Number05,String05),
		number_sentences(Number05,1,String06,[],String03))->true;
		(findall(String08,
					(SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
			member(String04a,String04),split_string(String04a,SepandPad,SepandPad,String09),
			append_list([[""],"",String09],String08)),String03)))),String0211),
		append_list2(String0211,String021).
			
number_sentences(_,_,[],String,String) :- !.						number_sentences(Number_a,Number_b1,String06,String07,String08) :-
	String06=[String00|String12],

SepandPad="&#@~%`$?-+*^,()|.:;=_/[]<>{}\n\r\s\t\\\"!'0123456789",
		split_string(String00,SepandPad,SepandPad,String09),
		append_list([[Number_a],Number_b1,String09],String10),
		append(String07,[String10],String11),
		Number_b2 is Number_b1 + 1,
		number_sentences(Number_a,Number_b2,String12,String11,String08).
			

data_instance_k_classification1(Data,I,K,C):-
    maplist(o_oclass_disClass1(I),Data,DisAndClass),
    keysort(DisAndClass,DSorted),
    
    %%writeln(DSorted),
    
    length(TopK,K),
    append(TopK,_,DSorted),
    %This is not a very good way of selecting k as you may have many values with the same distance, and the sorting just cuts these off
    %Dsorted = [1-pos,3-pos,3-pos,3-neg,3-neg]
    %Topk =[1-pos,3-pos,3-pos]
    topk_vote(TopK,C).

o_oclass_disClass1(O,[A,B,O2],D-[A,B,O2]):-
   o_o_dis(O,O2,D).

%% could be in either order
%% a([w,z,a,b,e,c,z,y],[1,1,[c]],[1,2,[a]]).

%% true
%% a([a,c,b],[1,1,[a,d]],[1,2,[b]]).
%% a([a,c,b],[1,1,[a,c]],[1,2,[b]]).
%% a([a,b],[1,1,[a]],[1,2,[b]]).

%% false
%% a([c,d],[1,1,[a]],[1,2,[b]]).
 
%% q in "q a b" sends food like e in "c d e"

/**

[debug]  ?- a([q,e,r,a,t,y,u,q,e,r,a,t,y,u,c,b,x,v,n,m],[1,1,[c,a,t,y,u]],[1,2,[c,a,t,y,u]]).    [[1,1,[c,a,t,y,u]],[r,a,t,y,u]]
[[1,2,[c,a,t,y,u]],[r,a,t,y,u]]
true.

X:
[debug]  ?- a([q,e,r,a,t,y,u,c,b,x,v,n],[1,1,[c,a,t,y,u]],[1,2,[b,x,u]]).
[[1,1,[c,a,t,y,u]],[r,a,t,y,u]]
[[1,2,[b,x,u]],[c,b,x]]
true.

[debug]  ?- a([q,e,r,a,t,y,u,c,c,c,b,x,v,n],[1,1,[c,a,t,y,u]],[1,2,[b,x,v]]).                   [[1,1,[c,a,t,y,u]],[r,a,t,y,u]]
[[1,2,[b,x,v]],[c,c,c]]
true.

**/

check_strings(String1,ML_db) :-
	%%member([P1,S1,String2],ML_db),
	%%member([P2,S2,String3],ML_db),
	ML_db=[String2a,String3a],
%%writeln(["String1,String2a,String3a",String1,String2a,String3a]),
	String2=[0,0,String2a],
	String3=[0,0,String3a],
%%a(String1,String2,String3):-
	length(String1,Length_string1),
((writeln("Attempt 1"),
check_strings_container1(Length_string1,String1,String2,[[0,0,[xxx,xxx,xxx,xxx,xxx]],String2,[999,999,[]]],_,List2),
	length(List2,Length_list2),
	%%Length_list3 is Length_list2+1,
	%%writeln(here),
	check_strings_container1(Length_list2,List2,String3,[[0,0,[xxx,xxx,xxx,xxx,xxx]],String3,[999,999,[]]],_,_List3),
	writeln("Success")
	%%,trace
	)->true;
	(writeln("Failed"),
	writeln("Attempt 2"),
	((check_strings_container1(Length_string1,String1,String3,[[0,0,[xxx,xxx,xxx,xxx,xxx]],String3,[999,999,[]]],_,List2),
	length(List2,Length_list2),
	%%Length_list3 is Length_list2+1,
	%%writeln(here),

	check_strings_container1(Length_list2,List2,String2,[[0,0,[xxx,xxx,xxx,xxx,xxx]],String2,[999,999,[]]],_,_List3))->
		writeln("Success");(writeln("Failed"),fail)))
).

check_strings_container1(Length_string1,String1,String2,Db,List2,List2b) :-
check_strings1(Length_string1,String1,String2,Db,List2,List2b),not(var(List2b)).
%%check_strings_container2(Length_string1,Length_string3,List1,String2,Db,List2,List2b) :-
%%check_strings2(Length_string1,Length_string3,List1,String2,Db,List2,List2b),not(var(List2b)).


	%% finds the length of each string - from position 1 to (length of string1) of string1
	%% starts with the shortest possible string, then increases the length
	%% repeat this for second string
	%%string1
	
	%%*** check with s2,s3 in db
check_strings1(0,_String1,_String2,_Db,List2,List2) :- !.
check_strings1(Length_string1,String1,String2,Db,List2,List2b) :-
	%% finds the first str
	%%length(List,Index),
	length(List1,Length_string1),
	append(_,List1,String1),
	Length_string2 is Length_string1-1,
	Length_string3 is Length_string1+1,
	check_strings2(0,Length_string3,List1,String2,Db,List2,List2c),
	(var(List2c)->
	check_strings1(Length_string2,String1,String2,Db,List2c,List2b);List2c=List2b),!.

check_strings2(Length_string,Length_string,_String1,_String2,_Db,List2,List2) :- !.
check_strings2(Length_string1,Length_string3,List1,String2,Db,List2,List2b) :-
	
	
	%%split_string(String4,SepandPad,SepandPad,String21),
	
	%% go through s1, removing the first word each time, until v
	%%Length_string11 is Length_string1-1,
	length(List11,Length_string1),
	append(List11,List2,List1),
	Length_string2 is Length_string1+1,
	
%%writeln([list11,List11]),

	((%%trace,
	%%(List11=[z,a,b]->trace;true),
	%%writeln([[_,_,List11],String2]),
	%%notrace,
	not(List11=[]),

%%writeln(data_instance_k_classification1(Db
%%	,List11,1,A)),
	data_instance_k_classification1(Db
	%%String2
	,List11,1,A),
		%%writeln([string2,String2,list11,List11,a,A]),
A=String2,%%[_,_,List11],
	%%trace,
		
	%%((List11=[z,a,b],A=[_,_,[z,t,b]],not(String2=[_,_,[c,z]]))->trace;notrace),
	%%trace,
%%writeln([string2=list11,String2=List11]),
%%(List11=[y]->true%%trace
%%;true),
%%member(List11,Db),
	%%**String2=[_,_,List11]
	List2b=List2,%%,notrace
	String2=[_,_,String21]
	,writeln([found,String21,List11])
	)
	->(true
	%%,writeln(List11)
	);
	check_strings2(Length_string2,Length_string3,List1,String2,Db,_List2c,List2b)),!.

numbers(N2,N1,Numbers,Numbers) :-
	N2 is N1-1,!.
numbers(N2,N1,Numbers1,Numbers2) :-
	N3 is N1+1,
	append(Numbers1,[N1],Numbers3),
	numbers(N2,N3,Numbers3,Numbers2).

%% sheet_feeder(T),writeln(T).
%% T = ["a\na", "B\nb\nb", "C\nc\nc"].

sheet_feeder(T) :-
	directory_files("raw_sources/",F),
	delete_invisibles_etc(F,G),
	findall(K1,(member(H,G),		
	string_concat("raw_sources/",H,String00b),
	phrase_from_file_s(string(String001), String00b),
	string_codes(String000,String001),
	string_concat(String000,"\n\n",String00_a),
	%%trace,
	strip_illegal_chars(String00_a,"",String00),
		split_on_substring(String00,"\n\n","",J1),
		%%maplist(append,[J2],[J1]),
		%%findall(J4,(member(J3,J2),%%trace,
		%%concat_list(J3,J4)),K1),
		delete(J1,"",K1),
		term_to_atom(K1,_K)
		/**
		string_concat("sources/",H,String00bb),
	(open_s(String00bb,write,Stream1),
	write(Stream1,K),
	close(Stream1))**/

		),T).
		%%split_on_double_newline(J,[],K)),T).

split_on_substring("",_A,E,[E]) :- !.
split_on_substring(A,B,E,C) :-
	string_concat(B,D,A),
	split_on_substring(D,B,"",C1),
	append([E],C1,C),!.
split_on_substring(A,B,E1,C) :-
	string_concat(E,D,A),
	string_length(E,1),
	string_concat(E1,E,E2),
	split_on_substring(D,B,E2,C),!.
	
strip_illegal_chars("",A,A) :- !.
strip_illegal_chars(A,B,E) :-
	string_concat(E1,D,A),
	string_length(E1,1),
	char_type(E1,quote),
	string_concat(B,"'",F),
	strip_illegal_chars(D,F,E).
strip_illegal_chars(A,B,E) :-
	string_concat(C,D,A),
	string_length(C,1),
	(char_type(C,alnum)->true;
	(char_type(C,white)->true;
	(char_type(C,digit)->true;
	(char_type(C,punct)->true;
	(char_type(C,newline)))))),
	string_concat(B,C,F),
	strip_illegal_chars(D,F,E),!.
strip_illegal_chars(A,B,E) :-
	string_concat(E1,D,A),
	string_length(E1,1),
	string_concat(B," ",F),
	strip_illegal_chars(D,F,E),!.


strip_illegal_chars1 :-
	directory_files("raw_sources/",F),
	delete_invisibles_etc(F,G),
	findall(String00,(member(H,G),		
	string_concat("raw_sources/",H,String00b),
	phrase_from_file_s(string(String001), String00b),
	string_codes(String000,String001),
	string_concat(String000,"\n\n",String00_a),
	%%trace,
	strip_illegal_chars(String00_a,"",String00),
		%%split_on_substring(String00,"\n\n","",J1),
		%%maplist(append,[J2],[J1]),
		%%findall(J4,(member(J3,J2),%%trace,
		%%concat_list(J3,J4)),K1),
		%%delete(J1,"",K1),
		term_to_atom(String00,K),
		string_concat("sources/",H,String00bb),
	(open_s(String00bb,write,Stream1),
	write(Stream1,K),
	close(Stream1))

		),_T).
		
		%% sheet_feeder and strip_illegal_chars1 are too slow.  Use BBEdit to replace \n\n with ",\n\n", insert ["*","*",1," at start, "] at end and replace \\ with nothing