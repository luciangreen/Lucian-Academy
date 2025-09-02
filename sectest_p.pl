%% mind read test

%% Make files different for different tests

%% *** Important: initialise program before running for the first time:
%% N is 1*2*3*5,texttobr2(N). %% 100 As for 1 (turned on)*2 (to and from computer)*3 (rb, itself (already done), graciously give or blame, radio button for graciously give or blame)*5 (5 objects)
%% N is 1*2*3*5,texttobr2(N). %% 100 As for 1 (turned off)*2 (to and from computer)*3 (rb, itself (already done), graciously give or blame, radio button for graciously give or blame)*5 (5 objects)
%% also breason out and dot on objects before line above and breason out and dot on when recognising and saying object (with all objects having different breasonings)


%%use_module(library(pio)).

:- use_module(library(date)).
:-include('../Text-to-Breasonings/text_to_breasonings.pl').
:-include('../mindreader/mindreadtestshared').
:-include('../listprologinterpreter/la_strings_string.pl'). %**** change path on server
:-include('../listprologinterpreter/la_maths.pl'). %**** change path on server

sectest_p:-
		phrase_from_file_s(string([N,_]), "a_tally.txt"),
		%string_codes(String02b,String00a),
		%atom_to_term(String00a,[N,_],[]),

numbers(N,1,[],Ns),
findall(_,(member(N1,Ns),

	find_time1(H,M,S),
	politeness(0,Threats1),
	politeness(0,Threats2),
	politeness(0,Threats3),
	politeness(0,Threats4),
	% no_death(0,Threats2), % medits for life
	writeln([N1,H,M,S,Threats1,politeness]),
	writeln([N1,H,M,S,Threats2,humour]),
	writeln([N1,H,M,S,Threats3,connections]),
	writeln([N1,H,M,S,Threats4,appearances])


	
	
	),_).%,Threats2,no_death]).
	
find_time1(H,M,S) :-
	find_time(H,M,S),!.

politeness(Threats1,Threats2):-
	%% "Given that we are interested in friendliness in primary school, secondary school and university, is there anything else?"
	trialy2_6("Yes",R1),
	trialy2_6("No",R2),
		R=[R1,R2/**,R3,R4,R5,R6,R7,R8,R9,R10**,R11,R12,R13,R14,R15,R16,R17,R18,R19,R20,R21,R22,R23,R24,R25,R26,R27**/
		],
	sort(R,RA),
	reverse(RA,RB),
	RB=[[_,Answer]|_Rest],
	
	(Answer="No"->Threats2=Threats1;(Threats3 is Threats1+1,politeness(Threats3,Threats2))),!.
