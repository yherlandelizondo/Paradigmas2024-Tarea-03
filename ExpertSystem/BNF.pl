:-consult('../Data/db.pl').

%-------------------------------------REGLAS GRAMATICALES

%   DETERMINANTE + DEPORTE
sintagmaNominal --> determinante, deporte.
sintagmaNominal --> deporte.

%   VERBO + SINGTAGMANOMINAL
sintagmaVerbal --> verbo, sintagmaNominal.
    
%-------------------------------------ORACIONES ACEPTADAS

oracion --> sintagmaNominal. 
% oracion --> El ciclismo
% oracion --> atletismo

oracion --> sintagmaVerbal.
% oracion --> Practico el ciclismo

oracion --> verbo, sintagmaVerbal.
% oracion --> Quiero Practicar ciclismo

oracion --> determinante, sintagmaVerbal.
% oracion --> me interesa el ciclismo

oracion --> determinante, verbo, sintagmaVerbal.
% oracion --> me interesa practicar ciclismo

oracion --> verbo, determinante, sintagmaVerbal.
% oracion --> voy a practicar ciclismo
% oracion --> tengo que practicar ciclismo

oracion --> verbo, verbo , determinante, sintagmaVerbal.
% oracion --> Estoy interesado en practicar ciclismo


%-------------------------------------VERBOS

verbo --> ["Querer"].
verbo --> ["Practicar"].
verbo --> ["Interesar"].
verbo --> ["Tener"].
verbo --> ["Estar"].
verbo --> ["Gustar"].
verbo --> ["Ir"].
verbo --> ["Hacer"].
verbo --> ["Desear"].

%-------------------------------------VALIDACION DE SINONIMOS

verbo --> [Sinonimo], {sinonimo(Verbo, Sinonimo), Verbo \= Sinonimo}.

%-------------------------------------DETERMINANTES
determinante --> ["En"].
determinante --> ["El"].
determinante --> ["De"].
determinante --> ["A"].
determinante --> ["Se"].
determinante --> ["Al"].
determinante --> ["La"].
determinante --> ["Para"].
determinante --> ["Que"]. %ok
determinante --> ["Me"].
determinante --> ["El"].
determinante --> ["Yo"].

%-------------------------------------VALIDACION DE SINONIMOS

determinante --> [Sinonimo], {sinonimo(Determinante, Sinonimo), Determinante \= Sinonimo}.

%-------------------------------------DEPORTES

deporte --> ["Atletismo"].
deporte --> ["Natacion"].
deporte --> ["Ciclismo"].

%-------------------------------------VALIDACION DE SINONIMOS

deporte --> [Sinonimo], {sinonimo(Deporte, Sinonimo), Deporte \= Sinonimo}.