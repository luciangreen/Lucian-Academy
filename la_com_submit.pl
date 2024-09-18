%% la_com.pl
%% Lucian Academy Web Site

%% Starts server


:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).

% we need this module from the HTTP client library for http_read_data
:- use_module(library(http/http_client)).
:- http_handler('/', web_form, []).

%:- use_module(library(date)).

:-include('../listprologinterpreter/la_strings.pl'). %% Move la_strings and the contents of the repository into the root folder
:-include('la_com_marks.pl').

la_com_start_server(Port) :-
        http_server(http_dispatch, [port(Port)]).

	/*
	browse http://127.0.0.1:8000/
	This demonstrates handling POST requests
	   */

	   web_form(_Request) :-
	   	reply_html_page(
			    title('Lucian Academy'),
			    	    [
				    	     form([action='/landing', method='POST'], [
					     		p([], [
									  label([for=name],'Name:'),
									  %% If you enter strings without double quotes and there is an internal server error please contact luciangreen@lucianacademy.com
									  		  input([name=name, type=textarea])
											  		      ]),
					     		p([], [
									  label([for=student_number],'Student Number:'),
									  		  input([name=student_number, type=textarea])
											  		      ]),
				     	p([], [
									  label([for=course],'Course:'),
									  		  input([name=course, type=textarea])
											  		      ]),
													      		p([], [
																	  label([for=essay_topic],'Essay Topic:'),
																	  		  input([name=essay_topic, type=textarea])
																			  		      ]),

													      		p([], [
																	  label([for=essay],'File contents from short_essay_helper.pl:'),
																	  		  input([name=essay, type=textarea])
																			  		      ]),
																			  		      
																				      		p([], input([name=submit, type=submit, value='Submit'], []))
																								      ])]).

																								      :- http_handler('/landing', landing_pad, []).

																				      landing_pad(Request) :-
																								              member(method(post), Request), !,
																									              http_read_data(Request, Data, []),
																										              format('Content-type: text/html~n~n', []),
																											      	format('<p>', []),
%%writeln1(Data)

%%lp(Data):-

Data=[name=Name1,student_number=Student_number1,course=Course1,essay_topic=Essay_topic1,essay=Essay1
,submit=_],

((string_atom(Name2,Name1),string_atom(Student_number2,Student_number1),
string_atom(Course2,Course1),string_atom(Essay_topic2,Essay_topic1),

(course_and_essay_topic1(Course2,Essay_topic2)->
true;
(course_and_essay_topic3(Courses_and_essay_topics1),term_to_atom(Courses_and_essay_topics1,Courses_and_essay_topics2),concat_list(["Course and Essay topic must be one of ",Courses_and_essay_topics2],Notification1),
writeln1(Notification1),fail)),

((string(Name2),string(Student_number2),string(Course2),string(Essay_topic2),term_to_atom(D2,Essay1),D2=[Exposition,Critique,Agree_or_disagree,Future_research,_Refs],Exposition=[Exposition1,Exposition2],findall(A,(member(A,Exposition1),A=[B,C],number(B),string(C)),_D3),%length(D3,F),
findall(A,(member(A,Exposition2),A=[B1,B2,B3,B4,C1,C2],number(B1),number(B2),number(B3),number(B4),string(C1),string(C2)),_D4),%length(D4,F),
findall(A,(member(A,Critique),A=[B,[C|D]],number(B),string(C),
	D=[D1|D2],D1=[D11,D12,D13,D14,D15,D16,D17,D18],
	number(D11),number(D12),number(D13),number(D14),
	string(D15),number(D16),number(D17),string(D18),
	findall(A1,(member(A1,D2),A1=[D21,D22,D23,D24,D25,D26,D27,D28,
	D29,D30,D31,D32,D33,D34,D35],
	number(D21),number(D22),number(D23),number(D24),
	string(D25),number(D26),number(D27),string(D28),
	number(D29),number(D30),string(D31),
	number(D32),number(D33),string(D34),string(D35)
	),_A11)%length(A11,F1),F is F1+1
	),_),string(Agree_or_disagree),string(Future_research))->
	true;
	(writeln1("Essay not in correct format.  Please manually submit with all form fields given, in email using form at https://www.lucianacademy.com/contact.html "),fail)))->
(
/**
%%writeln1([User1,Repository1]),
string_atom(User2,User1),
%%writeln(User2),
string_atom(Repository2,Repository1),
string_atom(Description2,Description1),
%%string_atom(Dependencies2,Dependencies1),
%%lppm_get_manifest(User2,Repository2,Description,Dependencies),

lppm_get_registry(LPPM_registry_term1),

strip(User2,User3),
strip(Repository2,Repository3),

delete(LPPM_registry_term1,[User3,Repository3,_,_],LPPM_registry_term2),

(LPPM_registry_term2=[]->LPPM_registry_term3=[[User2,Repository2,Description2,Dependencies2]];(
term_to_atom(LPPM_registry_term2,LPPM_registry_term4),

strip(LPPM_registry_term4,LPPM_registry_term4a),
LPPM_registry_term5=[LPPM_registry_term4a],

append(LPPM_registry_term5,[[User2,Repository2,Description2,Dependencies2]],LPPM_registry_term3))),
**/

%%portray_clause(LPPM_registry_term3),



	%(open_s("lppm_registry.txt",write,Stream),
	%write(Stream,LPPM_registry_term3),
	%close(Stream)))
	%;((writeln1("Error: One of strings was not in double quotes.")))),
%%),																				        %%portray_clause(Data),
																														format('</p><p>========~n', []),
																															%%portray_clause(Request),
																																format('</p>'),
																																

		phrase_from_file_s(string(String00a), "student_marks1.txt"),
		string_codes(String02b,String00a),
		atom_to_term(String02b,String02a,[]),
																																
(member([_Name3,Student_number2,Course2,Essay_topic2,Mark3,Year2,Month2,Day2,Hour2,Minute2],String02a)->
	(concat_list([Name2,", your mark, ",Mark3,", was earned for the topic ",Essay_topic2," in the course ",Course2," on ",Day2,"/",Month2,"/",Year2," at ",Hour2,":",Minute2,"."],String_a),
	writeln(String_a))
	;
	(
	
									get_time(TS),stamp_date_time(TS,date(Year2,Month2,Day2,Hour2,Minute2,_Seconda,_A,_TZ,_False),local),
																											%% mark is 65-69 if agree and < 80 br																															%% 70-74 if disagree and < 80 br	 																													%% mark is 75-79 if disagree and >= 80 br																															%% 80 if agree and >= 80 br
																																
sectest(Agree_or_disagree,Mark1),


	append(String02a,[[Name2,Student_number2,Course2,Essay_topic2,Mark1,Year2,Month2,Day2,Hour2,Minute2]],String02a_a),
	
	term_to_atom(String02a_a,String02a_b),
	string_atom(String02a_c,String02a_b),

	(open_s("student_marks1.txt",write,Stream1),
	write(Stream1,String02a_c),
	close(Stream1)),!,

	concat_list([Name2,", you have earned the mark, ",Mark1," for the topic ",Essay_topic2," in the course ",Course2," on ",Day2,"/",Month2,"/",Year2," at ",Hour2,":",Minute2,"."],String_a),
	writeln(String_a)))
																																	
					)
; (true)
						)																										
																																%%
																																.
																																
																																
																																:- http_handler('/generate_student_number', generate_student_number, []).

																				      generate_student_number(_Request) :-
																									              	   	reply_html_page(
			    title('Lucian Academy'),
			    	    [
				    	     form([action='/landing2', method='POST'], [
					     		p([], [
									  label([for=name],'Name:'),
									  %% If you enter strings without double quotes and there is an internal server error please contact luciangreen@lucianacademy.com
									  		  input([name=name, type=textarea])
											  		      ]),
					     		p([], [
									  label([for=email],'E-mail:'),
									  		  input([name=email, type=textarea])
											  		      ]),
																			  		      
																				      		p([], input([name=submit, type=submit, value='Submit'], []))
																								      ])]).
																								      
																								      																								      string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).


:- http_handler('/landing2', landing_pad2, []).

																				      landing_pad2(Request) :-
																								              member(method(post), Request), !,
																									              http_read_data(Request, Data, []),
																										              format('Content-type: text/html~n~n', []),
																											      	format('<p>', []),
%%writeln1(Data)

%%lp(Data):-

Data=[name=Name1,email=Email1
,submit=_],

string_atom(Name2,Name1),
string_atom(Email2,Email1),

		phrase_from_file_s(string(String00a), "student_numbers1.txt"),
		string_codes(String02b,String00a),
		atom_to_term(String02b,String02a,[]),

(member([Name3,Email2,Student_number3],String02a)->
	(concat_list(["The email address \"",Email2,"\" for \"",Name3,"\" has the student number \"",Student_number3,"\"."],String_a),
	writeln(String_a))
	;
	(length(String02a,Length),
	Student_number3 is Length+1,
	append(String02a,[[Name2,Email2,Student_number3]],String02a_a),
	
	term_to_atom(String02a_a,String02a_b),
	string_atom(String02a_c,String02a_b),

	(open_s("student_numbers1.txt",write,Stream1),
%%	string_codes(BrDict3),
	write(Stream1,String02a_c),
	close(Stream1)),!,

	concat_list(["The email address \"",Email2,"\" for \"",Name2,"\" has the student number \"",Student_number3,"\"."],String_a),
	writeln(String_a))).


course_and_essay_topic1(Course,Essay_topic) :-
	course_and_essay_topic2([Courses,Essay_topics]),
	member(Course,Courses),
	member(Essay_topic,Essay_topics).
	
course_and_essay_topic2(
[["Computational English"],
["Computational English Argument",
"Computational English is like a Calculator",
"Intertextuality",
"Finite Data will be a Solution in Conglish",
"Radical Difference",
"Order in Conglish",
"Dereconstruction",
"Kolmogorov Hermeneutics",
"Derivability",
"The Science of Crossing Over",
"A New Logic Reflecting Language or Natural Logic" ,
"Philosophical Computational English",
"Lenses",
"Analysing characteristics of arguments",
"Conglish Reflection",
"Narratology Diagram",
"How can the program cope with real variation?" ,
"Subject Mix",
"Perspectives",
"Ratios",
"Exploring opposites in Hamlet",
"Drawing connections",
"Symbols"]]).
course_and_essay_topic2(
[["Creating and Helping Pedagogues"],
["Accreditation",
"Protectedness",
"Areas of Study to Create a Pedagogue",
"Create a pedagogy helper for the student",
"Finding out about the student as a Pedagogy Helper",
"Daily Professional Requirement of the Pedagogy Helper",
"Preparing the student to write each breasoning",
"Pedagogy Helper - Write on Breasoning - Politics",
"Pedagogy Helper - Write on Breasoning - Philosophy",
"Pedagogy Helper - Write on Breasoning - Computer Science",
"Unification to Become Pedagogy Helper",
"Practicum",
"Breason out Arguments Twice When in Large Class",
"Instructions for using Recordings and Lecturer in Computer Science Recordings",
"Lecturer",
"Daily Regimen",
"Delegate Workloads"]]).
course_and_essay_topic2(
[["Fundamentals of Meditation and Meditation Indicators"],
["Children/H1/Earning Jobs/Protection in Jobs Heads of State",
"Lucian Mantra (Pure Form)",
"Lucian Mantra (Sun Safety)",
"Maharishi Sutra",
"Meditation Teacher Sutra Moving Appearances Purusha",
"Upasana Sutra",
"Yellow God",
"Green Sutra",
"Blue Nature",
"Appearances",
"Pranayama",
"Soma",
"Hours Prayer",
"50 Breasonings Per Utterance",
"Lower Risk of Cancer and Other Diseases In Workers and Broadcasters",
"Decreased Stress",
"Increased Blood Flow",
"Increased Brain Potential"]]).
course_and_essay_topic2(

[["Fundamentals of Pedagogy and Pedagogy Indicators"],
["Two Uses",
"X",
"Y",
"Breathsonings",
"Rebreathsonings",
"Room",
"Part of Room",
"Direction",
"Time to Prepare",
"Time to Do",
"Time to Finish",
"Professor Algorithm",
"God Algorithm",
"Marking Scheme - Humanities and Science Marking Scheme - Creative Arts",
"Higher Grades",
"Fewer Stillbirths",
"A Greater Number Of Successful Job Applications"]]).
course_and_essay_topic2(
[["Medicine"],
["Doctor Sutra",
"Meditation",
"Protector from Headache in Meditation Currant Bun",
"Meditation",
"Panic attack prevented by deep breathing and sutra",
"Family Medicine",
"Help ensure successful conception and prevent miscarriage",
"Pedagogy",
"Lucianic Pedagogical Medicine",
"Pedagogy Grades/Failure",
"Pedagogy Course Plan",
"Get in Touch with God about Breasonings Details to see High Quality Imagery and Earn H1 250 Breasonings",
"Preventing Sales from Being Dangerous",
"Perpetual University Short Courses",
"Apple Meditation for Successful Relationship",
"Miscellaneous",
"4 Glasses of Water and Exercise 45 Minutes Before Breakfast",
"Go to Bed at 9:30 PM",
"Yoga",
"Yoga Surya Namaskara and Yoga Asanas",
"Prevent Headaches on Train and a Bent Spine",
"Brain",
"Brain",
"Brain II",
"Maintain Dry Eyes",
"Avoid Diseased People",
"Fewer Mental Breakdowns (Schizophrenia)",
"Less Depression",
"Honey Pot Prayer for No Headaches in Cars, Trains and Walks",
"Quantum Box/Prayer",
"Nut and Bolt",
"Head of State Head Ache Prevention",
"Daily Regimen",
"Laughter for Depression",
"Heart",
"Contagious Diseases",
"Berocca Prevents Colds and Flu",
"Food",
"Grains/Nuts/Fruits/Vegetables",
"Sit Properly at Table During Meals"]]).

course_and_essay_topic3(Courses_and_essay_topics) :-
	findall(A,(course_and_essay_topic2(A)),Courses_and_essay_topics).