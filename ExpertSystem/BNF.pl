:-consult('../Data/db.pl').

%-------------------------------------REGLAS GRAMATICALES

%   DETERMINANTE + DEPORTE
sintagmaNominal --> determinante, deporte.
sintagmaNominal --> deporte.
sintagmaNominal --> enfermedad.

%   VERBO + SINGTAGMANOMINAL
sintagmaVerbal --> verbo, sintagmaNominal.
    
%-------------------------------------ORACIONES ACEPTADAS DEPORTE

oracionDeporte --> sintagmaNominal. 
% oracion --> El ciclismo
% oracion --> atletismo

oracionDeporte --> sintagmaVerbal.
% oracion --> Practico el ciclismo

oracionDeporte --> verbo, sintagmaVerbal.
% oracion --> Quiero Practicar ciclismo

oracionDeporte --> determinante, sintagmaVerbal.
% oracion --> me interesa el ciclismo

oracionDeporte --> determinante, verbo, sintagmaVerbal.
% oracion --> me interesa practicar ciclismo

oracionDeporte --> verbo, determinante, sintagmaVerbal.
% oracion --> voy a practicar ciclismo
% oracion --> tengo que practicar ciclismo

oracionDeporte --> verbo, verbo , determinante, sintagmaVerbal.
% oracion --> Estoy interesado en practicar ciclismo

%-------------------------------------ORACIONES ACEPTADAS DEPORTE

oracionEnfermedad --> sintagmaNominal.

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
determinante --> ["Que"].
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

%-------------------------------------AFIRMACION / NEGACION

afirmacion --> ["Si"].
afirmacion --> ["No"].

%-------------------------------------VALIDACION DE SINONIMOS

afirmacion --> [Sinonimo], {sinonimo(Afirmacion, Sinonimo), Afirmacion \= Sinonimo}.

%-------------------------------------ENFERMEDAD

enfermedad --> ["Gripe"].