:-consult('../Data/db.pl').

%-------------------------------------REGLAS GRAMATICALES

%   DETERMINANTE + DEPORTE
sintagmaNominal --> deporte.
sintagmaNominal --> enfermedad.
sintagmaNominal --> nivel.
sintagmaNominal --> determinante, deporte.
sintagmaNominal --> determinante, enfermedad.
sintagmaNominal --> determinante, nivel.

%   VERBO + SINGTAGMANOMINAL
sintagmaVerbal --> verbo, sintagmaNominal.
    
%-------------------------------------ORACIONES ACEPTADAS DEPORTE

oracionDeporte --> sintagmaNominal. 
% oracionDeporte --> El ciclismo
% oracionDeporte --> atletismo

oracionDeporte --> sintagmaVerbal.
% oracionDeporte --> Practico el ciclismo

oracionDeporte --> verbo, sintagmaVerbal.
% oracionDeporte --> Quiero Practicar ciclismo

oracionDeporte --> determinante, sintagmaVerbal.
% oracionDeporte --> me interesa el ciclismo

oracionDeporte --> determinante, verbo, sintagmaVerbal.
% oracionDeporte --> me interesa practicar ciclismo

oracionDeporte --> verbo, determinante, sintagmaVerbal.
% oracionDeporte --> voy a practicar ciclismo
% oracionDeporte --> tengo que practicar ciclismo

oracionDeporte --> verbo, verbo , determinante, sintagmaVerbal.
% oracionDeporte --> Estoy interesado en practicar ciclismo

%-------------------------------------ORACIONES ACEPTADAS DEPORTE

oracionEnfermedad --> sintagmaNominal.
% oracionEnfermedad --> asma
% oracionEnfermedad --> el asma
% oracionEnfermedad --> de asma

oracionEnfermedad --> sintagmaVerbal.
% oracionEnfermedad --> Tengo asma.
% oracionEnfermedad --> Sufro de diabetes.
% oracionEnfermedad --> tengo problemas cardiacos.

oracionEnfermedad --> verbo, determinante, sintagmaNominal.
% oracionEnfermedad --> Tengo problemas de rodilla.

oracionEnfermedad --> verbo, determinante, determinante, sintagmaNominal.
% oracionEnfermedad --> Tengo problemas en la espalda.

%-------------------------------------ORACIONES ACEPTADAS AFIRMACION

oracionAfirmacion --> afirmacion.
%oracionAfirmacion --> si.


%-------------------------------------ORACIONES ACEPTADAS NIVEL

oracionNivel --> sintagmaNominal.
%oracionNivel --> intermedio.

oracionNivel --> sintagmaVerbal.
%oracionNivel --> tengo nivel inicial.
%oracionNivel --> soy inicial.

oracionNivel --> determinante, verbo, determinante, sintagmaNominal.
%oracionNivel --> Me considero en nivel inicial.

oracionNivel --> verbo, determinante, verbo, sintagmaNominal.
%oracionNivel --> diria que soy nivel inicial.

oracionNivel --> verbo, determinante, sintagmaNominal.
%oracionNivel --> Tengo un nivel medio.

oracionNivel --> verbo, determinante, verbo, determinante, sintagmaNominal.
%oracionNivel --> considero que estoy en nivel medio.


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
verbo --> ["Tener"].
verbo --> ["Sufrir"].
verbo --> ["Padecer"].
verbo --> ["Considerar"].
verbo --> ["Ser"].
verbo --> ["Creer"].

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
determinante --> ["Que"].
determinante --> ["Un"].
determinante --> ["El"].
determinante --> ["Yo"].
determinante --> ["Una"].
determinante --> ["Problema"]. %Por simplicidad se incluye esta palabra como determinante.
determinante --> ["Nivel"]. %Por simplicidad se incluye esta palabra como determinante.

%-------------------------------------VALIDACION DE SINONIMOS

determinante --> [Sinonimo], {sinonimo(Determinante, Sinonimo), Determinante \= Sinonimo}.

%-------------------------------------DEPORTES

deporte --> ["Atletismo"].
deporte --> ["Natacion"].
deporte --> ["Ciclismo"].

%-------------------------------------VALIDACION DE SINONIMOS

deporte --> [Sinonimo], {sinonimo(Deporte, Sinonimo), Deporte \= Sinonimo}.

%-------------------------------------ENFERMEDADES

enfermedad --> ["Asma"].
enfermedad --> ["Cardiacos"].
enfermedad --> ["Columna"].
enfermedad --> ["Rodilla"].
enfermedad --> ["Diabetes"].

%-------------------------------------VALIDACION DE SINONIMOS

enfermedad --> [Sinonimo], {sinonimo(Enfermedad, Sinonimo), Enfermedad \= Sinonimo}.

%-------------------------------------AFIRMACIONES

afirmacion --> ["si"].
afirmacion --> ["no"].

%-------------------------------------NIVELES

nivel --> ["Inicial"].
nivel --> ["Intermedio"].
nivel --> ["Avanzado"].

%-------------------------------------VALIDACION DE SINONIMO

nivel --> [Sinonimo], {sinonimo(Nivel, Sinonimo), Nivel \= Sinonimo}.

