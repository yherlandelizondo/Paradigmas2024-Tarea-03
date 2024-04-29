%

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
deporte("Natacion").
deporte("Atletismo").
deporte("Ciclismo").

enfermedad("Asma").
enfermedad("Cardiacos").
enfermedad("Columna").
enfermedad("Rodilla").
enfermedad("Diabetes").



dificultad("Inicial").
dificultad("Intermedio").
dificultad("Avanzado").

distancia(dificultad("Inicial"),"1").
distancia(dificultad("Intermedio"),"3").
distancia(dificultad("Avanzado"),"5").

unidad(deporte("Natacion"),"00m").
unidad(deporte("Atletismo"),"KM").
unidad(deporte("Ciclismo"),"0KM").

actividad(deporte("Natacion"),ENFERMEDAD,"nadar "):-not(enfermedad(ENFERMEDAD)).
actividad(deporte("Natacion"),ENFERMEDAD,"flotar "):-not(enfermedad(ENFERMEDAD)).
actividad(deporte("Natacion"),ENFERMEDAD,"sumergirse "):-not(ENFERMEDAD="Asma").

actividad(deporte("Atletismo"),ENFERMEDAD,"caminar "):-not(enfermedad(ENFERMEDAD)).
actividad(deporte("Atletismo"),ENFERMEDAD,"trotar "):-not(enfermedad(ENFERMEDAD)).
actividad(deporte("Atletismo"),ENFERMEDAD,"correr "):-not(ENFERMEDAD="Asma").


actividad(deporte("Ciclismo"),ENFERMEDAD,"cletear plano "):-not(enfermedad(ENFERMEDAD)).
actividad(deporte("Ciclismo"),ENFERMEDAD,"cletear terreno "):-not(enfermedad(ENFERMEDAD)).
actividad(deporte("Ciclismo"),ENFERMEDAD,"cletear cuastas "):-not(ENFERMEDAD="Asma").






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


rutinaLista(DEP,ENF,DIF,FRE,L,P):-actividad(deporte(DEP),ENF,AC),distancia(dificultad(DIF),DIS),unidad(deporte(DEP),UNI),diaEntreno(DIA,FRE),concatenar([DIA,AC,DIS,UNI],L,P);true.
firstElem(X,[X|_]).
restList(R,[_|R]).
allRoutines(DEP,ENF,DIF,FRE,Lista):-findall(Sub,rutinaLista(DEP,ENF,DIF,FRE,[],Sub),Lista).


rutinas(DEP,ENF,DIF):-actividad(deporte(DEP),ENF,AC),distancia(dificultad(DIF),DIS),unidad(deporte(DEP),UNI),write(AC),write(DIS),write(UNI),nl,fail;true.
