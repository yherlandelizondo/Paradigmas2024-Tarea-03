:-consult('../Data/db.pl').

%-------------------------------------REGLAS GRAMATICALES

%   DETERMINANTE + DEPORTE/ENFERMEDAD/NIVEL/DIASLIBRES/INTERROGANTES
%   DEPORTE/ENFERMEDAD/NIVEL/DIASLIBRES/INTERROGANTES
sintagmaNominal --> deporte.
sintagmaNominal --> enfermedad.
sintagmaNominal --> nivel.
sintagmaNominal --> diasLibres.
sintagmaNominal --> interrogante.
sintagmaNominal --> determinante, deporte.
sintagmaNominal --> determinante, enfermedad.
sintagmaNominal --> determinante, nivel.
sintagmaNominal --> determinante, diasLibres.
sintagmaNominal --> determinante, interrogante.

%   VERBO + SINGTAGMANOMINAL
sintagmaVerbal --> verbo, sintagmaNominal.

% DOBLE VERBO
dobleVerbo --> verbo, verbo.

% DOBLE DETERMINANTE
dobleDeterminante --> determinante, determinante.

% TRIPLE VERBO
tripleVerbo --> verbo, verbo, verbo.

% TRIPLE DETERMINANTE
tripleDeterminante --> determinante, determinante, determinante.
    
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

oracionDeporte --> dobleVerbo, determinante, sintagmaVerbal.
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

oracionEnfermedad --> verbo, dobleDeterminante, sintagmaNominal.
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

%-------------------------------------ORACIONES ACEPTADAS NIVEL

oracionDiasLibre --> sintagmaNominal.
%oracionDiasLibre --> 4.

oracionDiasLibre --> sintagmaVerbal, determinante.
%oracionDiasLibre --> tener 4 dias.

oracionDiasLibre --> determinante, dobleVerbo, diasLibres, tripleDeterminante.
%oracionDiasLibre --> me gustaria tener 2 dias de descanso.

oracionDiasLibre --> determinante, dobleVerbo, diasLibres, dobleDeterminante.
%oracionDiasLibre --> me gustaria tener 6 dias libres

oracionDiasLibre --> dobleVerbo, diasLibres, tripleDeterminante.
%oracionDiasLibre --> prefiero tener 2 dias de descanso.

oracionDiasLibre --> dobleVerbo, diasLibres, dobleDeterminante.
%oracionDiasLibre --> prefiero tener 2 dias libres.

oracionDiasLibre --> diasLibres, determinante, verbo, determinante.
%oracionDiasLibre --> 2 dias estarian bien.

oracionDiasLibre --> diasLibres, determinante, verbo, determinante.
%oracionDiasLibre --> 2 dias estarian bien.

oracionDiasLibre --> verbo, diasLibres, determinante.
%oracionDiasLibre --> serian 3 dias .

oracionDiasLibre --> verbo, determinante, sintagmaNominal, determinante.
%oracionDiasLibre --> esta bien con dos dias.

oracionDiasLibre --> diasLibres, determinante.
%oracionDiasLibre --> 2 dias

oracionDiasLibre --> verbo, diasLibres, tripleDeterminante.
%oracionDiasLibre --> quiero 4 dias de descanso

%-------------------------------------ORACIONES ACEPTADAS PREGUNTA RUTINA

oracionPregunta --> sintagmaNominal.
%oracionPregunta --> rutina?
%oracionPregunta --> mi rutina?

oracionPregunta --> dobleDeterminante, sintagmaNominal.
%oracionPregunta --> que rutina me recomiendas?

oracionPregunta --> determinante, verbo, sintagmaNominal.
%oracionPregunta --> cual seria mi rutina?

oracionPregunta --> verbo, determinante, tripleDeterminante, sintagmaNominal.
%oracionPregunta --> dime cual es mi plan de entrenamiento?

oracionPregunta --> dobleVerbo, sintagmaNominal.
%oracionPregunta --> podrias mostrarme mi rutina?
%oracionPregunta --> podrias mostrar mi rutina?

oracionPregunta --> dobleVerbo, dobleDeterminante, sintagmaNominal.
%oracionPregunta --> podrias decirme cual es mi rutina?

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
verbo --> ["Preferir"].
verbo --> ["Recomendar"].
verbo --> ["Decir"].
verbo --> ["Poder"].
verbo --> ["Mostrar"].
verbo --> ["Entrenar"].

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
determinante --> ["Descanso"]. %Por simplicidad se incluye esta palabra como determinante.
determinante --> ["Bien"]. %Por simplicidad se incluye esta palabra como determinante.
determinante --> ["Plan"]. %Por simplicidad se incluye esta palabra como determinante.
determinante --> ["Rutina"]. %Por simplicidad se incluye esta palabra como determinante.
determinante --> ["Con"].
determinante --> ["Cual"].
determinante --> ["Mi"].
determinante --> ["Es"].

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

%-------------------------------------CANTIDAD DE DIAS LIBRES

diasLibres --> ["2"].
diasLibres --> ["3"].
diasLibres --> ["4"].
diasLibres --> ["5"].
diasLibres --> ["6"].

%-------------------------------------INTERROGANTES

interrogante --> ["recomiendas?"].
interrogante --> ["rutina?"].
interrogante --> ["entrenamiento?"].

%-------------------------------------VALIDACION DE SINONIMO

interrogante --> [Sinonimo], {sinonimo(Interrogante, Sinonimo), Interrogante \= Sinonimo}.