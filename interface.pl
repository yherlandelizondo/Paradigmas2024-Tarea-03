%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Tecnológico de Costa Rica
%
%                       Yherland Elizondo
%                       Gabriela Quesada
%                         Jafet Dixon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           ok: don't change the logic of that line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-consult('Logic/splitter.pl').
:-consult('ExpertSystem/parser.pl').
:-consult('Logic/listManager.pl').

% First predicate, used to start the interaction
mrTrainer :-
    nl, write("NOTA: Recuerde usar MAYUSCULAS donde es debido y evitar tanto tildes como puntos finales."), 
    nl, write("NOTA: MrTrainer actualmente te puede ayudar con los siguientes deportes: atletismo, ciclismo, natacion."),nl,
    nl, write('Hola usuario, bienvenido a mrTrainer, dime, Que deporte quieres practicar?'), 
    nl, getSport.
 
%-------------------------------------MRTRAINER EXPERT SYSTEM INTERFACE-------------------------------------

% Predicate used to obtain the sport
getSport:-
    read_string(user_input, "\n",  "\r", _, START),
    split_string(START, ' ', SUBLIST_START), %ok
    lastElement(SUBLIST_START, LASTITEM_START), %ok
    (analizarOracion(SUBLIST_START) -> getPathology(LASTITEM_START) ; sportError).
    getPathology(LASTITEM_START).
    

% Predicate used to obtain the possible pathology of the user   
getPathology(START):-
    nl,write('Genial, tienes alguna condicion que te impida hacer ejercicio con normalidad?'), nl,
    read_string(user_input, "\n", "\r", _, END),
    split_string(END, ' ', SUBLIST_END), 
    lastElement(SUBLIST_END, LASTITEM_END), 
    getSchedule(LASTITEM_END).
    %(analyzeSentence(SUBLIST_END) -> addIntermediate(START,[],LASTITEM_END) ; destinyError(START)).


% Predicate used to obtain the possible pathology of the user
getSchedule(START):-
    nl,write('Comprendo, ahora, has pensado con que frecuencia te gustaria practicar?'),write(START),write('?'),nl,
    read_string(user_input, "\n", "\r", _, END),
    split_string(END, ' ', SUBLIST_END), 
    lastElement(SUBLIST_END, LASTITEM_END),
    endConversation. 
    %(analyzeSentence(SUBLIST_END) -> addIntermediate(START,[],LASTITEM_END) ; destinyError(START))
    



% Predicate used to end the conversation   
endConversation:-
    nl,write('Deseas terminar la conversacion? (si/no)'), nl, 
    read_string(user_input, "\n", "\r", _, TERMINATE),
    nl,(TERMINATE = "si" -> write('Gracias por usar el programa. Conversacion terminada.')).
    % nl, nl ; addIntermediate(START,SORTEDLIST,END)). 

%-------------------------------------ERROR MANAGER
sportError:-
    nl, write("Lo siento, no tengo informacion sobre el deporte que mencionaste, te recomiendo utilizar otro entrenador."),nl,
    getSport.

%destinyError(START):-
    %nl, write("El destino ingresado no se encuentra en mi base de datos o no comprendo tu entrada, favor ingresa una distinta."),nl,
    %getDestination(START).

%intermediateError(START,INTERMEDIATE_LIST,END):-
    %nl, write("El destino ingresado no se encuentra en mi base de datos o no comprendo tu entrada, favor ingresa una distinta."),nl, 
    %addIntermediate(START,INTERMEDIATE_LIST,END).
    



