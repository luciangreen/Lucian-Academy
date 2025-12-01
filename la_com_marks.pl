:- use_module(library(date)).

:-include('../Text-to-Breasonings/texttobr2qb').
:-include('../mindreader/mindreadtestshared').

daysbspeoplearmy:-
	daysbspeoplearmy(2), %% 3 days, 3 people, a b bb, seen as version, hq version, army go, army return
	daysbspeoplearmy(2). %% Give to people with graciously give or blame, radio button for graciously give or blame

daysbspeoplearmy(0):-!.
daysbspeoplearmy(N1):-
	texttobr2,N2 is N1-1,daysbspeoplearmy(N2).

sectest(Agree_or_disagree,Marks_d):-
	daysbspeoplearmy, %% dot me on
	daysbspeoplearmy, %% dot them on
	%find_time(H,M,S),
	% for last 6 months, marks for this assignment
	daysbspeoplearmy, %% dot question on
	marks(0,Marks1), %% 1
	marks(0,Marks2), %% 2
	marks(0,Marks3), %% 3
	marks(0,Marks4), %% 4
	marks(0,Marks5), %% 5
	marks(0,Marks6), %% 6
	marks(0,Marks7), %% 7
	marks(0,Marks8), %% 8
	marks(0,Marks9), %% 9
	marks(0,Marks10), %% 10
	marks(0,Marks11), %% 11
	marks(0,Marks12), %% 12
	marks(0,Marks13), %% 13
	marks(0,Marks14), %% 14
	marks(0,Marks15), %% 15
	marks(0,Marks16), %% 16
	daysbspeoplearmy, %% dot answer on
	foldr(plus,[Marks1,Marks2,Marks3,Marks4,Marks5,Marks6,Marks7,Marks8,Marks9,Marks10,Marks11,Marks12,Marks13,Marks14,Marks15,Marks16],0,Marks_a),
	(Marks_a > 30 -> Marks_b = 80 ; (Marks_f is Marks_a/30,Marks_b is Marks_f*79)),
	(((Agree_or_disagree="a",Marks_b<80)->(Marks_e is Marks_b/80,Marks_g is Marks_e*4,Marks_c is 65+Marks_g))->true;
	(((Agree_or_disagree="d",Marks_b<80)->(Marks_e is Marks_b/80,Marks_g is Marks_e*4,Marks_c is 70+Marks_g))->true;
	(((Agree_or_disagree="d",Marks_b>=80)->(Marks_e is Marks_b/80,Marks_g is Marks_e*4,Marks_c is 75+Marks_g))->true;
	(((Agree_or_disagree="a",Marks_b>=80)->Marks_c is 80))))),
	floor(Marks_c,Marks_d),!.
	%writeln([Person,H,M,S,Marks_b,marks]).
	
marks(Threats1,Threats2):-
	%% "Given that they are not likely to have meant it and that there is nothing wrong, is there anything else that is wrong?"
	trialy2_6("Yes",R1),
	trialy2_6("No",R2),
		R=[R1,R2/**,R3,R4,R5,R6,R7,R8,R9,R10**,R11,R12,R13,R14,R15,R16,R17,R18,R19,R20,R21,R22,R23,R24,R25,R26,R27**/
		],
	sort(R,RA),
	reverse(RA,RB),
	RB=[[_Prev,Answer]|_Rest],
	
	(Answer="No"->Threats2=Threats1;(Threats3 is Threats1+1,marks(Threats3,Threats2))).

trialy1(R1) :-
	trial0(A1), %% Control
	trial0(A2), %% Test 1
	(A1>A2->R1=true;R1=fail).

trial0(Av) :- N is 10, %trial1(N,0,S),
catch(
	trial1(N,0,S),
   _,
	(trial0(Av)%,writeln(S3)
	)
	),
	Av is S/N.

trial1(0,A,A) :- !.
trial1(N,A,B) :- mindreadtest(S), A1 is A+S,
	N1 is N-1,trial1(N1,A1,B).
	
mindreadtest(Sec) :-
	%% 250 br for characters to be br out with 10 br each from person to me - do when initial 250 br test done and doing 10 br test
	%%comment(fiftyastest),
	%%random(X),X1 is 10*X, X2 is floor(X1), (X2=<2 -> (
	%%texttobr,writeln(['true test']), %%); %% use breasonings breasoned out by computer for not by me, for job medicine for "me", at last time point
	%%true), %% leave last time point blank
	(texttobr2(2)),%% make an A to detect reaction to gracious giving or blame of in following
	get_time(TimeStamp1),
	%%phrase_from_file(string(_String), 'file.txt'),
	(daysbspeoplearmy(2)), %% test breasonings breasoned out by computer for not by me, for job medicine for "me", at last time point
	%% is gracious giving or blame
	get_time(TimeStamp2),
	%%comment(turnoffas),
   Sec is TimeStamp2 - TimeStamp1.

/**string(String) --> list(String).

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).

comment(fiftyastest).
comment(turnoffas).
**/