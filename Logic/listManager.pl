
% Regla para obtener el primer elemento de una lista
% Input: Lista, variable que representa el ultimo elemento.
% Return: El ultimo elemento de una lista. 
lastElement([LAST], LAST).
lastElement([_|Tail], LAST) :- lastElement(Tail, LAST).

% regla para obtener el primer elemento de una lista
firstElement([FIRSTELEMENT|_], FIRSTELEMENT).

% Regla para obtener el número de la lista
% Ejemplo:
% ?- get_number([prefiero, tener, 2, dias, de, descanso], X).
get_number(Lista, Numero) :-
    member(Elemento, Lista),
    atom_number(Elemento, Numero), % Convierte el átomo a un número, no es posible comparar atomo-numero
    number(Numero). % Verifica que el resultado sea un número


%Regla para saber si un objeto es miembro de una lista
% Ejemplo:
% ?- member(c,[a,b,c,d]).
member(X,[X|_]). % caso base
member(X,[_|R]):-member(X,R). % recursividad