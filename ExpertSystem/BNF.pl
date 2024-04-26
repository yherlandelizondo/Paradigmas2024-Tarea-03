:-consult('../Data/db.pl').

%-------------------------------------REGLAS GRAMATICALES

%   DETERM + LOCATION
sintagmaNominal --> determinante, deporte.
% nounPhrase --> ["Practico"], natacion.

%   VERB + nounPhrase
sintagmaVerbal --> verbo, sintagmaNominal.
% verbPhrase --> ["Estoy", "en"], place.


    
%-------------------------------------ORACIONES ACEPTADAS

oracion --> verbo. %ok -> "R/ ciclismo"
oracion --> deporte. %ok -> "R/ ciclismo"
oracion --> sintagmaNominal. %creo que no
oracion --> sintagmaVerbal.
oracion --> determinante, sintagmaVerbal.
oracion --> verbo, sintagmaVerbal.

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
% linea la cual verifica si el verbo ingresado conincide con un sinonimo 
% previamente definido
verbo --> [Sinonimo], {sinonimo(Verbo, Sinonimo), Verbo \= Sinonimo}.

%-------------------------------------DETERMINANTES
determinante --> ["en"].
determinante --> ["En"].
determinante --> ["de"].
determinante --> ["De"].
determinante --> ["a"]. %ok
determinante --> ["Se"].
determinante --> ["se"].
determinante --> ["Al"].
determinante --> ["al"].
determinante --> ["la"].
determinante --> ["para"].
determinante --> ["Para"].
determinante --> ["que"]. %ok
determinante --> ["Me"].
determinante --> ["el"].
determinante --> ["El"].

%-------------------------------------Pronombres
pronombres --> ["Me"].
pronombres --> ["yo"].

%-------------------------------------DEPORTES

deporte --> ["natacion"].
deporte --> ["atletismo"].
deporte --> ["beisbol"].
deporte --> ["ciclismo"].
