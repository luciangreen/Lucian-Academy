/*
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).

% we need this module from the HTTP client library for http_read_data
:- use_module(library(http/http_client)).
:- http_handler('/', web_form, []).

:-include('../listprologinterpreter/la_strings.pl').

server(Port) :-
        http_server(http_dispatch, [port(Port)]).

	
	browse http:localhost:8000
	This demonstrates handling POST requests
	   
	   web_form(_Request) :-

																										              format('Content-type: text/html~n~n', []),

*/
progress_bar(Ratio) :-
%Ratio=1,
Percentage1 is 100*Ratio,
Percentage2 is 100-Percentage1,

(Percentage1=0->

concat_list(["Progress: ",Percentage1,"%<br>
<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\" width=\"200px\">
    <tr>
      <td bgcolor='white' width=\"",Percentage2,"%\">&nbsp;</td>
    </tr>
</table>"],String);

(Percentage1=100->

concat_list(["Progress: ",Percentage1,"%<br>
<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\" width=\"200px\">
    <tr>
      <td bgcolor='green' width=\"",Percentage1,"%\">&nbsp;</td>
    </tr>
</table>"],String);

concat_list(["Progress: ",Percentage1,"%<br>
<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\" width=\"200px\">
    <tr>
      <td bgcolor='green' width=\"",Percentage1,"%\">&nbsp;</td>
      <td bgcolor='white' width=\"",Percentage2,"%\">&nbsp;</td>
    </tr>
</table>"],String)
)),

format(String,[]).