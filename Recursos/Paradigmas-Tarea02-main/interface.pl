:-consult('Logic/dijkstra.pl').
:-consult('Logic/splitter.pl').
:-consult('ExpertSystem/parser.pl').
:-consult('Logic/listManager.pl').
:-consult('Logic/quicksort.pl').

% Predicate used to initiate the conversation.
heywazelog :-
    nl, write('Hola usuario, bienvenido.'), 
    nl, write("NOTA: Recuerde usar MAYUSCULAS donde es debido y evitar tanto tildes como puntos finales."), 
    nl, getOrigin.
 
%-------------------------------------WAZELOG EXPERT SYSTEM-------------------------------------

% Predicate used to obtain the origin
getOrigin:-
    nl,write('Donde se encuentra ubicado actualmente?.'), nl,
    read_string(user_input, "\n",  "\r", _, START),
    split_string(START, ' ', SUBLIST_START), 
    lastElement(SUBLIST_START, LASTITEM_START), 
    (analyzeSentence(SUBLIST_START) -> getDestination(LASTITEM_START) ; originError).
    

% Predicate used to obtain the destination   
getDestination(START):-
    nl,write('Favor ingresa tu destino.'), nl,
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
                route(START,LASTITEM,TIME,RUTE),
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


% Predicate used to provide the response to the user.
answer(START,INTERMEDIATE_LIST,END) :-
    quicksort(INTERMEDIATE_LIST, SORTEDLIST),
    firstExtractor(SORTEDLIST,FINALINTER_LIST),

    addToBeginning(START, FINALINTER_LIST, START_INTER),
    addToEnd(END, START_INTER, START_INTER_END),

    calculate_total_duration_and_route(START_INTER_END, TDURATION, TROUTE),
    addToBeginning(START, TROUTE, FINAL_ROUTE),

    nl,write('Tu ruta a seguir es la siguiente:'), nl,
    nl,write(FINAL_ROUTE),nl,
    nl,write('Con un tiempo estimado de: '),nl,nl, 
    write(TDURATION),
    write(" minutos en horario normal."),nl,
    multiplyByNum(TDURATION,TDURATION_DAM),
    write(TDURATION_DAM),
    write(" minutos en hora pico."),nl,


    (endConversation(START,SORTEDLIST,END)).


% Predicate used to end the conversation   
endConversation(START,SORTEDLIST,END):-
    nl,write('Deseas terminar la conversacion? (si/no)'), nl, 
    read_string(user_input, "\n", "\r", _, TERMINATE),
    nl,(TERMINATE = "si" -> write('Gracias por usar el programa. Conversacion terminada.'), nl, nl ; addIntermediate(START,SORTEDLIST,END)). 

%-------------------------------------ERROR MANAGER
originError:-
    nl, write("El origen ingresado no se encuentra en mi base de datos o no comprendo tu entrada, favor ingresa una distinta."),nl,
    getOrigin.

destinyError(START):-
    nl, write("El destino ingresado no se encuentra en mi base de datos o no comprendo tu entrada, favor ingresa una distinta."),nl,
    getDestination(START).

intermediateError(START,INTERMEDIATE_LIST,END):-
    nl, write("El destino ingresado no se encuentra en mi base de datos o no comprendo tu entrada, favor ingresa una distinta."),nl, 
    addIntermediate(START,INTERMEDIATE_LIST,END).
    



