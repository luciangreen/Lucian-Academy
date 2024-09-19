:-include('../listprologinterpreter/listprolog.pl').
:-include('short_essay_helper3_agps.pl').
%:-include('combophil/combophil_grammar_logic_to_alg.pl').
%:-include('algwriter/grammar_logic_to_alg.pl').
%:-include('meditationnoreplace.pl').
%:-include('folders.pl').
%:-include('sectest_p.pl').
%:-include('../listprologinterpreter/la_maths.pl').
%:-include('../Text-to-Breasonings/truncate_words_conserving_formatting.pl').

:-include('../Text-to-Breasonings/text_to_breasonings1.pl').
%:-include('../Text-to-Breasonings/texttobrall2_reading3.pl').
:-include('../Text-to-Breasonings/meditatorsanddoctors.pl').
%:-include('../Text-to-Breasonings/truncate.pl').

%:-include('../Text-to-Breasonings/meditationnoreplace.pl').
:-include('../Algorithm-Writer-with-Lists/grammar_logic_to_alg1.pl').
:-include('breasoning_and_detail_log.pl').

:- use_module(library(date)).

la_com1:-

get_curr_students(Curr_students),
writeln("New students"),
	
	(true%toss_coin 
	-> (new_student_number(First,Last,Student_number), 
										get_time(TS_of_enrollment),stamp_date_time(TS_of_enrollment,date(Year_of_enrollment,Month_of_enrollment,Day_of_enrollment,_Hour2,_Minute2,_Seconda,_A,_TZ,_False),local),

	directory_files("Books/",Courses1a),
	delete_invisibles_etc(Courses1a,Courses1),

%folders(Courses1),
random_member(Course,Courses1),

random_member([Course_type,Years_to_complete,Essays_left,As],[["short_course",1,5,1],["diploma",4,10,1],["honours",2,10,30],["master",5,20,100],["phd",10,30,400]]),
	
Year_of_completion is Year_of_enrollment+Years_to_complete,date_time_stamp(date(Year_of_completion,Month_of_enrollment,28,0,0,0,0,-,-),TS_of_completion),
	
	writeln([First,Last,Student_number,TS_of_enrollment,Year_of_enrollment,Month_of_enrollment,Day_of_enrollment,TS_of_completion,Year_of_completion,Month_of_enrollment,28,Course,Course_type,Years_to_complete,Essays_left,As]),
	
	append(Curr_students,[[First,Last,Student_number,TS_of_enrollment,Year_of_enrollment,Month_of_enrollment,Day_of_enrollment,TS_of_completion,Year_of_completion,Month_of_enrollment,28,Course,Course_type,Years_to_complete,Essays_left,As]],Curr_students2),
											
	term_to_atom(Curr_students2,String02a_b),
	string_atom(String02a_c,String02a_b),

	(open_s("student_numbers.txt",write,Stream1),
	write(Stream1,String02a_c),
	close(Stream1)),!

	
	);(true
	)),

	
			writeln("New work"),

	get_curr_students(Curr_students2a),
	get_grad_students(Grad_students2a),

	retractall(todays_students(_)),
	
	new_work(Curr_students2a,[],Curr_students_aa2,Grad_students2a,Grad_students_aa2),

	term_to_atom(Curr_students_aa2,String02a_b1),
	string_atom(String02a_c1,String02a_b1),

	(open_s("student_numbers.txt",write,Stream10),
	write(Stream10,String02a_c1),
	close(Stream10)),!,

			writeln("Graduates"),
			findall(_,(member(Grad_students_aa3,Grad_students_aa2),
			writeln(Grad_students_aa3)),_),

	term_to_atom(Grad_students_aa2,String02a_b11),
	string_atom(String02a_c11,String02a_b11),

	(open_s("grad_student_numbers.txt",write,Stream2),
	write(Stream2,String02a_c11),
	close(Stream2)),!,
	
	findall(Tally,todays_students(Tally),Tally2),
	sum(Tally2,Tally31),
	
	Tally32 is Tally31+1000+1000, % politics, university
	
	length(Curr_students2a,LCS),
	
	% n, high_distinctions
	Tally3=[LCS,Tally32],
	
	term_to_atom(Tally3,Tally4),

	save_file_s("a_tally.txt",Tally4),!.

	
/**
	get_curr_students(Curr_students_a),
	length(Curr_students_a,P1),P2=0,
	get_grad_students(String02a),length(String02a,_P3)
	.**/

new_work([],Curr_students_aa,Curr_students_aa,Grad_students_aa,Grad_students_aa) :- !.

new_work(Curr_students1a,Curr_students_aa1,Curr_students_aa2,Grad_students_aa1,Grad_students_aa2) :-

Curr_students1a=[[A,B,Student_number,TS_of_enrollment,Year_of_enrollment,Month_of_enrollment,Day_of_enrollment,TS_of_completion,Year_of_completion,Month_of_completion,Day_of_completion,Course,Course_type,Years_to_complete,Essays_left,As]|Curr_students1b],
	

	(Essays_left is 0 ->
	((
Curr_students_aa1=Curr_students_aa3,

										get_time(TS),stamp_date_time(TS,date(Year_of_graduation,Month_of_graduation,Day_of_graduation,_Hour2,_Minute2,_Seconda,_A,_TZ,_False),local),
	

append(Grad_students_aa1,[[A,B,Student_number,TS_of_enrollment,Year_of_enrollment,Month_of_enrollment,Day_of_enrollment,TS,Year_of_graduation,Month_of_graduation,Day_of_graduation,Course,Course_type,Years_to_complete,Essays_left,As]],Grad_students_aa3)



	));
	
	
	((get_texts(Course,Texts),
	
%trace,
	catch(short_essay_helper(Texts,Course,3,Essay_0),_,false),
	%writeln([essay_0,Essay_0]),
	W is 50*4,%texttobr2(u,u,Essay_0,u,false,false,false,false,false,false,W,[auto,on]),
	
	texttobr2(u,u,Essay_0,u,[auto,on]),


	texttobr(u,u,Essay_0,u),
	
	working_directory(_, '../Lucian-Academy/'),

	add_to_breasoning_log(["string",Essay_0]),
	
	/**
	term_to_atom(Essay_0,Essay_01),
	string_atom(Essay_02,Essay_01),

	
	(open_s("essay_tmp1.txt",write,Stream1),
	write(Stream1,Essay_02),
	close(Stream1)),!,

	truncate("essay_tmp1.txt",14000,"file.txt"),

	**/
	
	working_directory(_, '../Algorithm-Writer-with-Lists/'),
		
	Br is As*80,
	grammar_logic_to_alg1(Essay_0,As,GL_out1),

	working_directory(_, '../Lucian-Academy/'),

	add_to_detail_log(["string",GL_out1]),

	term_to_atom(GL_out1,GL_out2),
	string_atom(GL_out,GL_out2),

	working_directory(_, '../Lucian-Academy/'),

	%texttobr2(u,u,GL_out,Br,false,false,false,false,false,false,W),
	
    texttobr2(u,u,GL_out,Br,[auto,on]),

	texttobr(u,u,GL_out,u),

		
	Essays_left2 is Essays_left-1,

writeln([A,B,Student_number,TS_of_enrollment,Year_of_enrollment,Month_of_enrollment,Day_of_enrollment,TS_of_completion,Year_of_completion,Month_of_completion,Day_of_completion,Course,Course_type,Years_to_complete,Essays_left2,As]),
	
	assertz(todays_students(As)),
	
append(Curr_students_aa1,[[A,B,Student_number,TS_of_enrollment,Year_of_enrollment,Month_of_enrollment,Day_of_enrollment,TS_of_completion,Year_of_completion,Month_of_completion,Day_of_completion,Course,Course_type,Years_to_complete,Essays_left2,As]],Curr_students_aa3),
	
	Grad_students_aa1=Grad_students_aa3
	

	)->true;(
	
	Curr_students_aa1=Curr_students_aa3,
	Grad_students_aa1=Grad_students_aa3

	))),
	
	new_work(Curr_students1b,Curr_students_aa3,Curr_students_aa2,Grad_students_aa3,Grad_students_aa2).


new_student_number(First,Last,N) :-
	meditators(M1),
	meditators2(M2),
	append(M1,M2,M3),
	length(M3,L),
	random(X),N is ceiling(L*X),
	get_item_n(M3,N,[First,Last|_]),!.



get_curr_students(String02a) :-
		phrase_from_file_s(string(String00a), "student_numbers.txt"),
		string_codes(String02b,String00a),
		atom_to_term(String02b,String02a,[]).

get_grad_students(String02a) :-
		phrase_from_file_s(string(String00a), "grad_student_numbers.txt"),
		string_codes(String02b,String00a),
		atom_to_term(String02b,String02a,[]).

get_texts(Courses1a,Texts) :-
%trace,
	foldr(string_concat,["Books/",Courses1a],Dept),
	%directory_files(Courses1e,Courses1b),
	%delete_invisibles_etc(Courses1b,Dept),
	%findall(Courses1c,(member(Courses1d,Courses1a),
	%foldr(string_concat,["Books/",Courses1d],Courses1c)),
	%Dept),

	string_concat(Dept,"/",Dept1),
	directory_files(Dept1,F),
	delete_invisibles_etc(F,G),
	findall(String02b,(member(Filex1,G),

	string_concat(A,_,Filex1),string_length(A,4),
	not(A="dot-"),!,

	string_concat(Dept1,Filex1,Filex),
		phrase_from_file_s(string(String00a), Filex),
		string_codes(String02b,String00a)),Texts1),
		choose_texts(Texts1,Texts2,Text_a),
		(choose_texts(Texts2,Texts3,Text_b)->
		(choose_texts(Texts3,_Texts4,Text_c)->true;
		Text_c="");
		(Text_b="",Text_c="")),
		%trace,
		findall(Text1,(member(Text1,[Text_a,Text_b,Text_c]),
		not(Text1="")),Texts3),
		%foldr(append,[
		Texts=Texts3.%[Text_a,Text_b,Text_c]],Texts).
		
choose_texts(Texts1,Texts2,Text) :-
	random_member(Text,Texts1),
	
	delete(Texts1,Text,Texts2).

toss_coin :-
	random(X),X1 is ceiling(2*X), X1 is 2,!.

	
