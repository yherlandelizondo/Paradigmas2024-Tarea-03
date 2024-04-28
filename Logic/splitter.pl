% libreria para tratamiento de strings
:- use_module(library(strings)).

% Hacer split utilizando un separados 
% INPUT: String de entrada, Separador
% OUTPUT: string separado
split_string(CHAIN, SPLITTER, SUBSTRING_LIST) :-
    split_string(CHAIN, SPLITTER, "", SUBSTRINGS), % Obtén las subcadenas sin comillas

    % Envuelve cada subcadena en comillas y agrégala a la nueva lista
    maplist(wrapInQuotes, SUBSTRINGS, SUBSTRING_LIST).


% Predicado auxiliar para encerrar un substring en comillas. 
% INPUT: substring
% OUTPUT: substring con comillas
wrapInQuotes(SUBSTRING, SUBSTRING_MARK) :-
    string_concat('', SUBSTRING, TEMP), % Agrega comillas al principio
    string_concat(TEMP, '', SUBSTRING_MARK). % Agrega comillas al final


% Hacer split del string de entrada y devuelve una lista de todos los caracteres
% INPUT: String de entrada
% OUTPUT: Lista de caracteres
split_string_to_chars(CHAIN, CHAR_LIST) :-
    string_chars(CHAIN, CHAR_LIST). %regla que realiza toda la separacion en caracteres

