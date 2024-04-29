:-consult('../Data/db.pl').


%deporte --> ["Natacion"].
%deporte --> ["Atletismo"].
%deporte --> ["beisbol"].
%deporte --> ["Ciclismo"].

concatenar([],L,L).
concatenar([X|L1],L2,[X|L3]):-concatenar(L1,L2,L3).
agregar(A,L,[A|L]).


%----------------------------------------------------------
printLista([]):-write(" ").
printLista(Lista):-firstElem(X,Lista),restList(R,Lista),write(X),write(" "),printLista(R).
% ------------------------------------------------------------------------


%allRoutines(Rutinas)
lista("lista",[]).
%------------------------------


enfermedad("Asma").
enfermedad("Cardiacos").
enfermedad("Columna").
enfermedad("Rodilla").
enfermedad("Diabetes").

distancia(DIFICULTAD,"1") :- sinonimo("Inicial", DIFICULTAD).
distancia(DIFICULTAD,"3") :- sinonimo("Intermedio", DIFICULTAD).
distancia(DIFICULTAD,"5") :- sinonimo("Avanzado", DIFICULTAD).

unidad(DEPORTE,"00 m") :- sinonimo("Natacion", DEPORTE).
unidad(DEPORTE," KM") :- sinonimo("Atletismo", DEPORTE).
unidad(DEPORTE,"0 KM") :- sinonimo("Ciclismo", DEPORTE).

actividad(DEPORTE,ENFERMEDAD,"nadar "):-not(enfermedad(ENFERMEDAD)), sinonimo("Natacion", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"flotar "):-not(enfermedad(ENFERMEDAD)), sinonimo("Natacion", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"sumergirse "):-not(ENFERMEDAD="Asma"), sinonimo("Natacion", DEPORTE).

actividad(DEPORTE,ENFERMEDAD,"caminar "):-not(enfermedad(ENFERMEDAD)), sinonimo("Atletismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"trotar "):-not(enfermedad(ENFERMEDAD)), sinonimo("Atletismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"correr "):-not(ENFERMEDAD="Asma"), sinonimo("Atletismo", DEPORTE).

actividad(DEPORTE,ENFERMEDAD,"cletear plano "):-not(enfermedad(ENFERMEDAD)), sinonimo("Ciclismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"cletear terreno "):-not(enfermedad(ENFERMEDAD)), sinonimo("Ciclismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"cletear cuastas "):-not(ENFERMEDAD="Asma"), sinonimo("Ciclismo", DEPORTE).


diaEntreno("Lunes",N):-N=2;N=3;N=4;N=5;N=6.
diaEntreno("Martes",N):-N=4;N=5;N=6.
diaEntreno("Miercoles",N):-N=3;N=5;N=6.
diaEntreno("Jueves",N):-N=4;N=5;N=6.
diaEntreno("Viernes",N):-N=3;N=4;N=5;N=6.
diaEntreno("Sabado",N):-N=2;N=6.

resta(N,R):- R is 7-N.

printAllRoutines(DEP,ENF,DIF,FRE):-resta(FRE,WORK),allRoutines(DEP,ENF,DIF,WORK,Routines),printRoutines(Routines).


printRoutines([]).
printRoutines(Rutinas):-firstElem(SubRutina,Rutinas),restList(Otras,Rutinas),printLista(SubRutina),nl,printRoutines(Otras).


rutinaLista(DEP,ENF,DIF,FRE,L,P):-actividad(DEP,ENF,AC),distancia(DIF,DIS),unidad(DEP,UNI),diaEntreno(DIA,FRE),concatenar([DIA,AC,DIS,UNI],L,P);true.
firstElem(X,[X|_]).
restList(R,[_|R]).
allRoutines(DEP,ENF,DIF,FRE,Lista):-findall(Sub,rutinaLista(DEP,ENF,DIF,FRE,[],Sub),Lista).