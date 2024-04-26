
%-------------------------------------REGLAS GRAMATICALES

    %   DETERM + LOCATION
    sintagmaNominal --> determinante, deporte.
    % nounPhrase --> ['Practico'], natacion.

    %   VERB + nounPhrase
    sintagmaVerbal --> verbo, sintagmaNominal.
    % verbPhrase --> ['Estoy', 'en'], place.


    
 %-------------------------------------ORACIONES ACEPTADAS

oracion --> deporte. %ok
oracion --> sintagmaNominal.
oracion --> sintagmaVerbal.
oracion --> determinante, sintagmaVerbal.
oracion --> verbo, sintagmaVerbal.

%-------------------------------------VERBOS

verbo --> ['Quiero']. %FIXME: minuscula
verbo --> ['Practico']. %FIXME: minuscula FIXME: incluir practicar como sin
verbo --> ['interesado']. %FIXME: interesado como sin
verbo --> ['Tengo']. %FIXME: minuscula
verbo --> ['Estoy']. 
verbo --> ['gustaria']. %OK



%-------------------------------------DETERMINANTES
determinante --> ['en'].
determinante --> ['En'].
determinante --> ['de'].
determinante --> ['De'].
determinante --> ['a'].
determinante --> ['A'].
determinante --> ['Se'].
determinante --> ['se'].
determinante --> ['Al'].
determinante --> ['al'].
determinante --> ['la'].
determinante --> ['para'].
determinante --> ['Para'].
determinante --> ['que'].
determinante --> ['Me'].
determinante --> ['el'].
determinante --> ['El'].

%-------------------------------------Pronombres
pronombres --> ['me'].
pronombres --> ['yo'].

%-------------------------------------DEPORTES

deporte --> ['natacion'].
deporte --> ['atletismo'].
deporte --> ['beisbol'].
deporte --> ['ciclismo'].
