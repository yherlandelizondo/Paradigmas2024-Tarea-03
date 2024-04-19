%:- module(dijkstraPreparation, [dijkstraPreparation/3, finalAnswer/2]).
:-consult('./Data/DB.pl').

% is a clause that prepares the data and establishes the necessary context to run the Dijkstra
% algorithm on a given graph. Then, It calls a main function (dijkstraMain) to perform the
% calculations and catches any exceptions that may occur during the execution of the algorithm.
% Finally it returns the variable SOLUTION, which contains the information about the shortest.
% distances from the initial node to all the others. graph nodes.
% OUTPUT: SOLUTION
% INPUT: GRAPH, START
dijkstraPreparation(GRAPH, START, SOLUTION) :-
    setof(X, Y^D^(member(d(X,Y,D), GRAPH) ; member(d(Y,X,D), GRAPH)), XS),
    length(XS, L),
    length(VS, L),
    aggregate_all(sum(D), member(d(_, _, D), GRAPH), Infinity),
    catch((dijkstraMain(GRAPH, Infinity, XS, VS, START, SOLUTION),
           throw(sol(SOLUTION))
          ), sol(SOLUTION), true).


% It is the central part of Dijkstra algorithm and is responsible for performing the calculations
% necessary to find the shortest path from a starting node to all other nodes in a weighted graph.
% This involves the initialization of distances, neighborhood relationships and the execution of
% the main loop of the algorithm.
% OUTPUT:SOLUTION
% INPUT: GRAPH, Infinity, XS, VS, START
dijkstraMain(GRAPH, Infinity, XS, VS, START, SOLUTION) :-
    pairs_keys_values(NODEATTRIBUTESLIST, XS, VS),
    maplist(initAdjs(NODEATTRIBUTESLIST), GRAPH),
    maplist(initDist(Infinity), NODEATTRIBUTESLIST),
    memberchk(START-SV, NODEATTRIBUTESLIST),
    put_attr(SV, dist, 0),
    mainLoop(VS),
    maplist(solution(START), VS, SOLUTION).


% Calculates the shortest path from the starting node to a specific node (V) in the graph, using
% distance and relationship information from previous nodes. The result is a tuple
% (N, D, [START|P]), where N is the name of the node V, D is the distance of the shortest path,
% and [START|P] is the list representing the path from the node from the beginning to V.
% OUTPUT:START
% INPUT:V, (N, D, [START|P])
solution(START, V, (N, D, [START|P])) :-
    get_attr(V, name, N),
    get_attr(V, dist, D),
    buildPath(V, [], P).


% Recursive function used to construct the path from a node V to the starting node in a directed
% graph, using the previous attribute of the nodes to track previous nodes along the path.
% OUTPUT: PATH
% INPUT: END, START
buildPath(END, START, PATH) :-
    get_attr(END, name, N),
    (   get_attr(END, previous, Q)
    ->  buildPath(Q, [N|START], PATH)
    ;   PATH = START
    ).


% is used to initialize the attributes of a node. Sets the distance from the starting node to V
% to infinite (Infinity) and associates the node name (N)
% to the name attribute of node V.
% OUTPUT:  NODENAME-NODEATTRIBUTES modified
% INPUT: Infinity,  NODENAME-NODEATTRIBUTES
initDist(Infinity, NODENAME-NODEATTRIBUTES) :-
    put_attr(NODEATTRIBUTES, name, NODENAME),
    put_attr(NODEATTRIBUTES, dist, Infinity).



% It is responsible for initializing attributes related to adjacent nodes in a directed graph.
% OUTPUT:  NODEATTRIBUTESLIST modified
% INPUT: NODEATTRIBUTESLIST, d(X, Y, D)
initAdjs(NODEATTRIBUTESLIST, d(X, Y, D)) :-
    memberchk(X-XV, NODEATTRIBUTESLIST),
    memberchk(Y-YV,NODEATTRIBUTESLIST),
    adjAdd(XV, YV, D).



% traces directed edges from a node X to adjacent nodes in a directed graph.
% OUTPUT: Y and D
% INPUT: X,Y and D
adjAdd(X, Y, D) :-
    (   get_attr(X, adjs, L)
    ->  put_attr(X, adjs, [Y-D|L])
    ;   put_attr(X, adjs, [Y-D])
    ).



% Implements a main loop. The loop continually selects the node with the smallest distance,
% marks it as processed, and updates the distances of its adjacent nodes before continuing to
% the next node in the list of nodes to process.
% OUTPUT: true or false
% INPUT: NODELIST
mainLoop([]).
mainLoop([Q|QS]) :-
    smallestDistance(QS, Q, U, NODELIST),
    put_attr(U, assigned, true),
    get_attr(U, adjs, AS),
    updateNeighbours(AS, U),
    mainLoop(NODELIST).



% selects the next node to process, choosing the node with the smallest cumulative distance among
% the available nodes in the list.
% OUTPUT: M and NODELIST
% INPUT: QS and N
smallestDistance([A|QS], C, M, [T|NODELIST]) :-
    get_attr(A, dist, AV),
    get_attr(C, dist, CV),
    (   AV < CV
    ->  (N,T) = (A,C)
    ;   (N,T) = (C,A)
    ),
    !, smallestDistance(QS, N, M, NODELIST).
smallestDistance([], U, U, []).



% is used to update the cumulative distances of nodes adjacent to a current node (U) if a shortest
% path to those nodes through U is found in a shortest path search algorithm. The previous node is
% also traced along the shortest path to each adjacent node.
% OUTPUT:VS modified
% INPUT:U
updateNeighbours([V-DUV|VS], U) :-
    (   get_attr(V, assigned, true)
    ->  true
    ;   get_attr(U, dist, DU),
        get_attr(V, dist, DV),
        ALT is DU + DUV,
        (   ALT < DV
        ->  put_attr(V, dist, ALT),
        put_attr(V, previous, U)
        ;   true
        )
    ),
    updateNeighbours(VS, U).
updateNeighbours([], _).



% is used to extract all the facts from the knowledge base that follow the pattern d(X, Y, Z) and
% store them in a list called GRAPH
% OUTPUT:GRAPH
% INPUT: d(X,Y,Z)
allDistances(GRAPH):- findall(FACT,(d(X,Y,Z),FACT = d(X,Y,Z)), GRAPH).



% uses Dijkstra algorithm to find the shortest path from START to END in a graph represented by
% GRAPH and stores the path and time in ROUTE and TIME
% INPUT: X, Y
% OUTPUT: true or false
routeAux(X, [X|_]).
routeAux(X, [_|Y]):- routeAux(X, Y).

% OUTPUT: TIME, ROUTE
% INPUT:START, END
route(START,END,TIME,ROUTE):-
    allDistances(GRAPH),
   dijkstraPreparation(GRAPH,START,X),
   routeAux((END,TIME,ROUTE), X).


% uses the result of route/4 to display a message on the console indicating the fastest route found
% and its duration in minutes.
% INPUT: START, END
% OUTPUT: ROUTE and TIME
finalAnswer(START,END):-
    route(START,END,TIME,ROUTE),
    write('La ruta mas rapida es '),write(ROUTE), write(' con una duracion de '), write(TIME),write(' minutos'),nl.

% Rule to remove the first element from a list.
removeFirstOne([_ | Rest], Rest).

% Predicate to calculate the total duration and total path between a list of places.
calculate_total_duration_and_route([], 0, []).  % Base case: list is empty, duration and path are both empty.
calculate_total_duration_and_route([_], 0, []).  % Base case: There is only one place left in the list, duration and path are both empty.
calculate_total_duration_and_route([Start, End | Rest], TotalDuration, TotalRoute) :-
    route(Start, End, Duration, Route),  % Calculate the duration and route between Start and End.
    calculate_total_duration_and_route([End | Rest], RestDuration, RestRoute),  % Recursive call with the rest of the list.
    TotalDuration is Duration + RestDuration,  % Add the current duration to the accumulated duration.
    removeFirstOne(Route,RouteMinusFirst),
    append(RouteMinusFirst, RestRoute, TotalRoute).  % Concatenates the current route with the accumulated route.
%?-calculate_total_duration_and_route(["Paraiso", "Cervantes", "JuanVinas"], TDuration, TRoute).

