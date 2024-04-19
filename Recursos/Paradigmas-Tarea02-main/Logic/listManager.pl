% Predicate to add a given value to each element in the list.
addValueToEach([], _, []).
addValueToEach([ELEMENT|REST_ELEMENTS], VALUE, [[ELEMENT, VALUE]|REST_RESULT]) :-
    addValueToEach(REST_ELEMENTS, VALUE, REST_RESULT).


% Main predicate to add a given value to each element in the list.
% example
% ?- addValueToElements([1, 2, 3, 4], 5, Resultado).
addValueToElements(SLIST, VALUE, RESULT) :-
    addValueToEach(SLIST, VALUE, RESULT).


% Rule to obtain the last element of the list.
% Input: List, Variable that represent the last item.
% Return: The last element of the input list. 
lastElement([LAST], LAST).
lastElement([_|Tail], LAST) :- lastElement(Tail, LAST).


% Rule to get the first elemento of a list
firstElement([FIRSTELEMENT|_], FIRSTELEMENT).


% Extract the first element of each sublist
% example
%?- firstExtractor([[TresRios, 8], [MusgoVerde, 10]], PRIMEROS).
firstExtractor(ELEMLIST, FIRSTELEMENTS) :-
    maplist(firstElement, ELEMLIST, FIRSTELEMENTS).



% Rule to add an element to the beginning of a list.
% example
% ?- addToBeginning(lugar1, [Paris, Osaka, Denver], NuevaLista).
addToBeginning(ELEMENT, LISTORIGINAL, NEWLIST) :-
    NEWLIST = [ELEMENT | LISTORIGINAL].


% Rule to add an element to the end of a list.
% example
% ?- addToEnd(lugar4, [Paris, Osaka, Denver], NuevaLista).
addToEnd(ELEMENT, [], [ELEMENT]).
addToEnd(ELEMENT, [HEAD|TAIL], [HEAD|NEWLIST]) :-
    addToEnd(ELEMENT, TAIL, NEWLIST).

