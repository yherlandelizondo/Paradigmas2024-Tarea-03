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
    nl, write("NOTA: Recuerde usar MAYUSCULAS donde es debido y evitar tanto tildes como puntos finales."), 
    nl, write("NOTA: MrTrainer actualmente te puede ayudar con los siguientes deportes: atletismo, ciclismo, natacion."),nl,
    nl, write('Hola usuario, bienvenido a mrTrainer, dime, cual es tu nombre?'),nl, 
    read_string(user_input, "\n",  "\r", _, NOMBRE),nl,nl,
    write('Un gusto '),write(NOMBRE),write('!'),
    obtenerDeporte(NOMBRE).
 
%-------------------------------------interfaz del sistema experto-------------------------------------

% Predicado utilizado para obtener el deporte
obtenerDeporte(NOMBRE):-
     write(' Cuentame, Que deporte quieres practicar?'), nl,
    read_string(user_input, "\n",  "\r", _, MSG_INICIAL),
    split_string(MSG_INICIAL, ' ', MSG_INICIAL_SPLIT), %ok
    lastElement(MSG_INICIAL_SPLIT, DEPORTE), %ok
    (analizarOracion(MSG_INICIAL_SPLIT) -> obtenerEnfermedad(DEPORTE) ; errorDeporte(NOMBRE)).
    

% predicado utilizado para obtener las posibles enfermedades del usuario
obtenerEnfermedad(DEPORTE):-
    nl,write('Genial, tienes alguna condicion que te impida hacer '), write(DEPORTE),write(' con normalidad?'), nl,
    read_string(user_input, "\n", "\r", _, END),
    split_string(END, ' ', SUBLIST_END), 
    lastElement(SUBLIST_END, LASTITEM_END), 
    obtenerFrecuencia(LASTITEM_END).
    %(analyzeSentence(SUBLIST_END) -> addIntermediate(START,[],LASTITEM_END) ; destinyError(START)).


% Predicado utlizado para obtener la frecuencia de entrenamiendo
obtenerFrecuencia(START):-
    nl,write('Comprendo, ahora, has pensado con que frecuencia te gustaria practicar'),write(START),write('?'),nl,
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


% Predicado utilizado para terminar la conversación 
terminarConversacionDeporte(NOMBRE):-
    nl,write('Deseas terminar la conversacion? (si/no)'), nl, 
    read_string(user_input, "\n", "\r", _, TERMINATE),
    nl,(TERMINATE = "si" -> write('Gracias por usar mrTrainer. Conversacion terminada.')),!; obtenerDeporte(NOMBRE). 

%-------------------------------------Predicados para errores-------------------------------------
errorDeporte(NOMBRE):-
    nl, write('Lo siento '),write(NOMBRE),write(' no tengo informacion sobre el deporte que mencionaste, te recomiendo utilizar otro entrenador.'),nl,
    terminarConversacionDeporte(NOMBRE).

errorFrecuencia(START):-
    nl, write("Disculpa, no te comprendi. Por favor, vuelve a ingresar la frecuencia con la que quieres entrenar."),nl,
    obtenerFrecuencia(START).

errorEnfermedad(START):-
    nl, write('Lo siento, no conozco la enfermedad que mencionas, te recomiendo utilizar otro sistema experto, o revisar que lo hayas escrito correctamente.'),nl, 
    obtenerEnfermedad(START).
    



