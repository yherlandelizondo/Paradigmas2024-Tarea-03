% Load the required library
:- use_module(library(strings)).

% Split the string using a splitter  
% INPUT: User string, Separator
% OUTPUT: Separated string
split_string(CHAIN, SPLITTER, SUBSTRING_LIST) :-
    split_string(CHAIN, SPLITTER, "", SUBSTRINGS), % Obtén las subcadenas sin comillas

    % Envuelve cada subcadena en comillas y agrégala a la nueva lista
    maplist(wrapInQuotes, SUBSTRINGS, SUBSTRING_LIST).


% Auxiliary predicate to enclose a substring in quotes.
% INPUT: substring
% OUTPUT: substring with quotes
wrapInQuotes(SUBSTRING, SUBSTRING_MARK) :-
    string_concat('', SUBSTRING, TEMP), % Agrega comillas al principio
    string_concat(TEMP, '', SUBSTRING_MARK). % Agrega comillas al final


% Predicate to multiply the value of a variable by 2
% INPUT: value
% OUTPUT: value multiplied by 2
multiplyByNum(X, Result) :-
    Result is X * 2.


