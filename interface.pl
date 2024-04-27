%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Tecnológico de Costa Rica
%
%                       Yherland Elizondo
%                       Gabriela Quesada
%                         Jafet Dixon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:-consult('Logic/splitter.pl').
:-consult('ExpertSystem/parser.pl').
:-consult('Logic/listManager.pl').

% Primer predicado, utilizado para inicial la interacción con el usuario
mrTrainer :-
    nl, write("NOTA: Recuerde evitar tanto tildes como puntos finales."), 
    nl, write("NOTA: MrTrainer actualmente te puede ayudar con los siguientes deportes: "), nl, write("-> Atletismo"), 
    nl, write("-> Ciclismo"), nl, write("-> Natacion"), nl,
    nl, write('Hola usuario, bienvenido a mrTrainer, dime, cual es tu nombre?'),nl, 
    read_string(user_input, "\n",  "\r", _, NOMBRE),nl,nl, %se lee los datos del usuario
    write('Un gusto '),write(NOMBRE),write('!'),
    obtenerDeporte(NOMBRE). %se pregunta por el deporte
 
%-------------------------------------interfaz del sistema experto-------------------------------------

% Predicado utilizado para obtener el deporte
obtenerDeporte(NOMBRE):-
     write(' Cuentame, Que deporte quieres practicar?'), nl,
    read_string(user_input, "\n",  "\r", _, MSG_INICIAL), %se lee los datos del usuario
    split_string(MSG_INICIAL, ' ', MSG_INICIAL_SPLIT), %se hace split del string ingresado por espacios
    lastElement(MSG_INICIAL_SPLIT, DEPORTE), %se obtiene el deporte ingresado por el usuario
    (analizarDeporte(MSG_INICIAL_SPLIT) -> obtenerEnfermedad(DEPORTE, NOMBRE) ; errorDeporte(NOMBRE)). %si la frase tiene sentido, se pregunta por la enfermedad.
    
% predicado utilizado para obtener las posibles enfermedades del usuario
obtenerEnfermedad(DEPORTE, NOMBRE):- %FIXME: ALGUIEN PODRIA NO TENER ENFERMEDADES
    nl,write('Genial, tienes alguna condicion que te impida hacer '), write(DEPORTE),write(' con normalidad? (si/no)'), nl,
    read_string(user_input, "\n", "\r", _, ENFERMEDAD_CONFIRMACION), %se lee los datos del usuario
    (ENFERMEDAD_CONFIRMACION = "si" -> nl, write('Entiendo, dime que condicion/enfermedad tienes?'), nl, %si el usuario dice que SI tiene una condicion, pregunta cual es
        read_string(user_input, "\n", "\r", _, MSG_ENFERMEDAD), %se lee los datos del usuario
        split_string(MSG_ENFERMEDAD, ' ', MSG_ENFERMEDAD_SPLIT), %se hace split del string ingresado por espacios
        lastElement(MSG_ENFERMEDAD_SPLIT, ENFERMEDAD), %se obtiene la enfermedad ingresada por el usuario
        (analizarEnfermedad(MSG_ENFERMEDAD_SPLIT) -> obtenerFrecuencia(NOMBRE ,DEPORTE, ENFERMEDAD); errorEnfermedad(NOMBRE, DEPORTE))) %si la frase de enfermedad es coherente, pregunta por la frecuencia
    ;obtenerFrecuencia(NOMBRE, DEPORTE, ['']). %si el usuario indicia que NO tiene enfermedad, no se pide la misma y se pide frecuencia


% Predicado utlizado para obtener la frecuencia de entrenamiendo
obtenerFrecuencia(NOMBRE ,DEPORTE, ENFERMEDAD):-
    nl,write('Comprendo, ahora, has pensado con que frecuencia te gustaria practicar '),write(DEPORTE),write('?'),nl,
    read_string(user_input, "\n", "\r", _, END),
    split_string(END, ' ', SUBLIST_END), 
    lastElement(SUBLIST_END, LASTITEM_END).
    %(analyzeSentence(SUBLIST_END) -> addIntermediate(START,[],LASTITEM_END) ; destinyError(START))
    
% Predicado utlizado para obtener la frecuencia de entrenamiendo
obtenerDiasLibres(START):-
    nl,write('Perfecto!. Y dime, cuantos días de descanso te gustaría tener en tu semana'),write(START),write('?'),nl,
    read_string(user_input, "\n", "\r", _, END),
    split_string(END, ' ', SUBLIST_END), 
    lastElement(SUBLIST_END, LASTITEM_END).
    %(analyzeSentence(SUBLIST_END) -> addIntermediate(START,[],LASTITEM_END) ; destinyError(START))

%-------------------------------------Predicados para finalizar conversaciones-------------------------------------

% Predicado utilizado para terminar la conversación 
terminarConversacionDeporte(NOMBRE):-
    nl,write('Deseas terminar la conversacion? (si/no)'), nl, 
    read_string(user_input, "\n", "\r", _, TERMINATE),
    nl,(TERMINATE = "si" -> write('Gracias por usar mrTrainer. Conversacion terminada.')),!; obtenerDeporte(NOMBRE). 

% Predicado utilizado para terminar la conversación 
terminarConversacionEnfermedad(NOMBRE, DEPORTE):-
    nl,write('Deseas terminar la conversacion? (si/no)'), nl, 
    read_string(user_input, "\n", "\r", _, TERMINATE),
    nl,(TERMINATE = "si" -> write('Gracias por usar mrTrainer. Conversacion terminada.')),!; obtenerEnfermedad(NOMBRE, DEPORTE). 

%-------------------------------------Predicados para errores-------------------------------------
errorDeporte(NOMBRE):-
    nl, write('Lo siento '), write(NOMBRE), write(' no tengo informacion sobre el deporte que mencionaste, te recomiendo utilizar otro entrenador.'),nl,
    terminarConversacionDeporte(NOMBRE).

errorFrecuencia(START):-
    nl, write("Disculpa, no te comprendi. Por favor, vuelve a ingresar la frecuencia con la que quieres entrenar."),nl,
    obtenerFrecuencia(START).

errorEnfermedad(NOMBRE, DEPORTE):-
    nl, write('Lo siento '), write(NOMBRE), write(' no conozco la enfermedad que mencionas, te recomiendo utilizar otro sistema experto, o revisar que lo hayas escrito correctamente.'),nl, 
    terminarConversacionEnfermedad(START, DEPORTE).
    



