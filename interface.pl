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
    nl,nl,nl,nl,nl,nl,nl,nl, write("NOTA: Recuerde evitar tanto tildes como puntos finales."), 
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
    (analizarDeporte(MSG_INICIAL_SPLIT) -> nl, nl, write("Genial, "), obtenerEnfermedad(DEPORTE, NOMBRE) ; errorDeporte(NOMBRE)). %si la frase tiene sentido, se pregunta por la enfermedad.
    
% predicado utilizado para obtener las posibles enfermedades del usuario
obtenerEnfermedad(DEPORTE, NOMBRE):-
    write('Tienes alguna condicion que te impida hacer '), write(DEPORTE),write(' con normalidad? (si/no)'), nl,
    read_string(user_input, "\n", "\r", _, MSG_ENFERMEDAD_CONFIRMACION), %se lee los datos del usuario
    split_string(MSG_ENFERMEDAD_CONFIRMACION, ' ', MSG_CONFIRMACION_SPLIT), %se hace split del string ingresado por espacios
    lastElement(MSG_CONFIRMACION_SPLIT, CONFIRMACION),%se obtiene la confirmacion ingresada por el usuario
    (analizarAfirmacion(MSG_CONFIRMACION_SPLIT) -> %verificando si se ingreso (si/no) correctamente
            (CONFIRMACION = "si" -> nl, write('Entiendo, dime que condicion/enfermedad tienes?'), nl, %si el usuario dice que SI tiene una condicion, pregunta cual es
                    read_string(user_input, "\n", "\r", _, MSG_ENFERMEDAD), %se lee los datos del usuario
                    split_string(MSG_ENFERMEDAD, ' ', MSG_ENFERMEDAD_SPLIT), %se hace split del string ingresado por espacios
                    lastElement(MSG_ENFERMEDAD_SPLIT, ENFERMEDAD), %se obtiene la enfermedad ingresada por el usuario
                    (analizarEnfermedad(MSG_ENFERMEDAD_SPLIT) -> nl, write('Anotado! Por otro lado, '), obtenerNivel(NOMBRE ,DEPORTE, ENFERMEDAD); errorEnfermedad(NOMBRE, DEPORTE)) %si la frase de enfermedad es coherente, pregunta el nivel
            ;nl, write('Anotado! Por otro lado, '), obtenerNivel(NOMBRE, DEPORTE, ['']))%si el usuario indicia que NO tiene enfermedad, no se pide la misma y se pide nivel
    ;errorAfirmacionEnfermedad(DEPORTE, NOMBRE)). %si el usuario no ingresa (si/no) correctamente se devuelve un error


% Predicado utlizado para obtener el nivel del usuario entrenamiendo
obtenerNivel(NOMBRE ,DEPORTE, ENFERMEDAD):-
    write('Cuentame, en que nivel te consideras al practicar el deporte que me mencionaste? (inicial/intermedio/avanzado)'),nl,
    read_string(user_input, "\n", "\r", _, MSG_NIVEL), %se lee los datos del usuario
    split_string(MSG_NIVEL, ' ', MSG_NIVEL_SPLIT),  %se hace split del string ingresado por espacios
    lastElement(MSG_NIVEL_SPLIT, NIVEL),%se obtiene el nivel ingresado por el usuario
    (analizarNivel(MSG_NIVEL_SPLIT) -> nl,write('Muy bien. Por ultimo, '),obtenerDiasLibres(NOMBRE ,DEPORTE, ENFERMEDAD, NIVEL) ; errorNivel(NOMBRE ,DEPORTE, ENFERMEDAD)). %verificando si la oracion de nivel es coherente, en dado caso pregunta dias libres

% Predicado utlizado para obtener la frecuencia de entrenamiendo
obtenerDiasLibres(NOMBRE ,DEPORTE, ENFERMEDAD, NIVEL):-
    write('Dime, cuantos dias de descanso te gustaria tener en tu semana? (2-5 dias)'),nl,
    read_string(user_input, "\n", "\r", _, END),
    split_string(END, ' ', SUBLIST_END), 
    lastElement(SUBLIST_END, LASTITEM_END).
    %(analyzeSentence(SUBLIST_END) -> addIntermediate(START,[],LASTITEM_END) ; destinyError(START))
    %FIXME: ya se agrego la regla para obener numero, utilizarla. 
    %FIXME: me falta modiificar bnf y db con la cantidad de dias y demas, ya se anadieron las posibilidades al archivo .txt 
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

errorNivel(NOMBRE, DEPORTE, ENFERMEDAD):-
    nl, write('Disculpa '), write(NOMBRE), write(', no entendi lo que quisiste decir. Por favor, vuelve a ingresar tu nivel.'),nl,
    write("Te recuerdo que con mrTrainer puedes elegir los siguientes niveles: "), nl,
    write("-> Inicial"), nl,
    write("-> Intermedio"), nl,
    write("-> Avanzado"), nl,
    obtenerNivel(NOMBRE, DEPORTE, ENFERMEDAD).

errorAfirmacionEnfermedad(DEPORTE, NOMBRE):-
    nl, write("Disculpa, no te comprendi, recuerda utilizar (si/no)."),nl,
    obtenerEnfermedad(DEPORTE, NOMBRE).

errorDiasDescanso(NOMBRE ,DEPORTE, ENFERMEDAD, NIVEL):-
    nl, write('Disculpa '), write(NOMBRE), write(', no te comprendi. Por favor, vuelve a ingresar los dias de descanso.'),nl,
    write("Te recuerdo que con mrTrainer puedes tener entre 2 y 5 dias de descanso."), nl,
    obtenerDiasLibres(NOMBRE ,DEPORTE, ENFERMEDAD, NIVEL).

errorEnfermedad(NOMBRE, DEPORTE):-
    nl, write('Lo siento '), write(NOMBRE), write(', no conozco la enfermedad que mencionas, te recomiendo utilizar otro sistema experto, o revisar que lo hayas escrito correctamente.'),nl, 
    write("Te recuerdo que mrTrainer te puede ayudar con las siguientes enfermedades: "), nl,
    write("-> Asma o problemas pulmonares"), nl,
    write("-> Problemas cardiacos"), nl,
    write("-> Problemas de rodilla"), nl,
    write("-> Problemas de columna o espalda"), nl,
    write("-> Diabetes"), nl,
    terminarConversacionEnfermedad(DEPORTE, NOMBRE).
    



