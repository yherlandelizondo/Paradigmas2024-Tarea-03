%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Tecnológico de Costa Rica
%
%                       Yherland Elizondo
%                       Gabriela Quesada
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           ok: don't change the logic of that line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-consult('Logic/splitter.pl').
:-consult('ExpertSystem/parser.pl').
:-consult('Logic/listManager.pl').

% First predicate, used to start the interaction
mrTrainer :-
    nl, write("NOTA: Recuerde usar MAYUSCULAS donde es debido y evitar tanto tildes como puntos finales."), 
    nl, write("NOTA: MrTrainer actualmente te puede ayudar con los siguientes deportes: atletismo, ciclismo, natacion, beisbol."),nl,
    nl, write('Hola usuario, dime, Que deporte quieres practicar?'), 
    nl, getSport.
 
%-------------------------------------MRTRAINER EXPERT SYSTEM INTERFACE-------------------------------------

% Predicate used to obtain the sport
getSport:-
    read_string(user_input, "\n",  "\r", _, START),
    split_string(START, ' ', SUBLIST_START), %ok
    lastElement(SUBLIST_START, LASTITEM_START), %ok
    (analyzeSentence(SUBLIST_START) -> getPathology(LASTITEM_START) ; sportError).
    

% Predicate used to obtain the possible pathology of the user   
getPathology(START):-
    nl,write('Genial, tienes alguna patologia que te impida hacer ejercicio con normalidad?'), nl,
    read_string(user_input, "\n", "\r", _, END),
    split_string(END, ' ', SUBLIST_END), 
    lastElement(SUBLIST_END, LASTITEM_END), 
    getSchedule(LASTITEM_END)
    %(analyzeSentence(SUBLIST_END) -> addIntermediate(START,[],LASTITEM_END) ; destinyError(START)).


% Predicate used to obtain the possible pathology of the user
getSchedule(START):-
    nl,write('Comprendo, ahora, has pensado con que frecuencia te gustaría practicar?'),write(START),write('?'),nl,
    read_string(user_input, "\n", "\r", _, END),
    split_string(END, ' ', SUBLIST_END), 
    lastElement(SUBLIST_END, LASTITEM_END), 
    (analyzeSentence(SUBLIST_END) -> addIntermediate(START,[],LASTITEM_END) ; destinyError(START)).

% Predicate used to obtain the intermediate nodes
addIntermediate(START,INTERMEDIATE_LIST,END):-
    nl,write('Okay. Ingresa un punto intermedio o escribe "ya" para terminar.'), nl,
    read_string(user_input, "\n", "\r", _, INTERMEDIATE),
    split_string(INTERMEDIATE, ' ', SUBLIST_INTER), 
        (INTERMEDIATE = "ya" -> answer(START,INTERMEDIATE_LIST,END)
        ; 
            (analyzeSentence(SUBLIST_INTER) -> 
                lastElement(SUBLIST_INTER, LASTITEM), 
                % write(LASTITEM),write('m'),nl,
                % write(START),write('m'),write(LASTITEM),write('m'), % OK
                % write(TIME),nl,
                nl,write('SUGERENCIA: Puedes tomar en cuenta esta ruta alternativa hacia '), 
                write(LASTITEM),write(':'),nl,
                write(RUTE),nl,
                addValueToElements([LASTITEM], TIME, ITEMNUM),
                % write([LASTITEM]),write('m'),write(TIME),write('m'),write(ITEMNUM),write('m'),nl,
                append(INTERMEDIATE_LIST, ITEMNUM, NEW_INTERMEDIATE_LIST), 
                addIntermediate(START,NEW_INTERMEDIATE_LIST,END))
            ; 
            (analyzeAuxiliarSentence(SUBLIST_INTER) -> interDirectioner(START,INTERMEDIATE_LIST,END))   
      
            ; % If not, call an error.
            intermediateError(START,INTERMEDIATE_LIST,END)).


% Predicate used to connect with the auxiliar parser
interDirectioner(START,INTERMEDIATE_LIST,END) :-
    nl,write('Cual?'), nl,
    read_string(user_input, "\n", "\r", _, SITUATION), 
    nl, write('Indicame donde queda '),
    write(SITUATION), 
    write('?'), nl,
    read_string(user_input, "\n", "\r", _, SITUATION_INTERMEDIATE),
    split_string(SITUATION_INTERMEDIATE, ' ', SUBLIST_SITUATION), 

    (analyzeSentence(SUBLIST_SITUATION) -> 
        lastElement(SUBLIST_SITUATION, LASTITEM), 

        route(START,LASTITEM,TIME,RUTE),

        nl,write('SUGERENCIA: Puedes tomar en cuenta esta ruta alternativa hacia '), 
        write(LASTITEM),write(':'),nl,
        write(RUTE),nl,

        % write(START),write('m'),write(LASTITEM),write('m'), % OK
        addValueToElements([LASTITEM], TIME, ITEMNUM),
        % write(ITEMNUM),write('m'),nl,

        append(INTERMEDIATE_LIST, ITEMNUM, NEW_INTERMEDIATE_LIST),
        addIntermediate(START,NEW_INTERMEDIATE_LIST, END)
        
    ;
    intermediateError(START,NEW_INTERMEDIATE_LIST, END)).





% Predicate used to end the conversation   
endConversation(START,SORTEDLIST,END):-
    nl,write('Deseas terminar la conversacion? (si/no)'), nl, 
    read_string(user_input, "\n", "\r", _, TERMINATE),
    nl,(TERMINATE = "si" -> write('Gracias por usar el programa. Conversacion terminada.'), nl, nl ; addIntermediate(START,SORTEDLIST,END)). 

%-------------------------------------ERROR MANAGER
sportError:-
    nl, write("Lo siento, no tengo informacion sobre el deporte que mencionaste, te recomiendo utilizar otro entrenador."),nl,
    getSport.

destinyError(START):-
    nl, write("El destino ingresado no se encuentra en mi base de datos o no comprendo tu entrada, favor ingresa una distinta."),nl,
    getDestination(START).

intermediateError(START,INTERMEDIATE_LIST,END):-
    nl, write("El destino ingresado no se encuentra en mi base de datos o no comprendo tu entrada, favor ingresa una distinta."),nl, 
    addIntermediate(START,INTERMEDIATE_LIST,END).
    



