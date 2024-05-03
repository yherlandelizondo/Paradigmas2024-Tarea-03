
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

%Devuelve el tamano de una lista
size([],0).
size([_|Y], N):-size(Y, N1), N is N1+1.

%Toma un elemento de la lista por indice
getInd([X], 0, X).
getInd([H|_], 0, H).
getInd([_|T], I, E) :- NewIndex is I-1, getInd(T, NewIndex, E).

%Imprime una Matriz Cualquiera
printMatriz([]).
printMatriz(Matriz):-firstElem(Lista,Matriz),restList(Resto,Matriz),printLista(Lista),nl,printMatriz(Resto).

%concatena 2 listas
concatenar([],L,L).
concatenar([X|L1],L2,[X|L3]):-concatenar(L1,L2,L3).
agregar(A,L,[A|L]).

%imprime una Lista cualquiera
printLista([]):-write(" ").
printLista(Lista):-firstElem(X,Lista),restList(R,Lista),write(X),printLista(R).
lista("lista",[]).

%Retorna el primer elemento de una Lista
firstElem(X,[X|_]).
restList(R,[_|R]).

% Resta los dias de descanso a los dias de la semana para retornar  los dias de trabajo
resta(N,R):- R is 7-N.