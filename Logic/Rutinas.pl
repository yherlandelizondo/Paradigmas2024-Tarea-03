:-consult('./listManager.pl').
:-consult('../Data/db.pl').
:-consult('../ExpertSystem/BNF.pl').
:-consult('../ExpertSystem/parser.pl').
:-use_module(library(random)).



% Devuelve la cantidad de distancia que debe recorrer depende de la dificultad
distancia(DIFICULTAD,"1") :- sinonimo("Inicial", DIFICULTAD).
distancia(DIFICULTAD,"3") :- sinonimo("Intermedio", DIFICULTAD).
distancia(DIFICULTAD,"5") :- sinonimo("Avanzado", DIFICULTAD).

% Devuelve la unidad de la distancia a recorrer dependiendo del deporte
unidad(DEPORTE,"00 m") :- sinonimo("Natacion", DEPORTE).
unidad(DEPORTE," KM") :- sinonimo("Atletismo", DEPORTE).
unidad(DEPORTE,"0 KM") :- sinonimo("Ciclismo", DEPORTE).

%Entrenamientos a realizar en caso de Natacion dependiendo de la enfermedad 
actividad(DEPORTE,ENFERMEDAD,"nadar tradicional "):-not(sinonimo("Columna",ENFERMEDAD)), sinonimo("Natacion", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"nadar mariposa "):-not(phrase(enfermedad,[ENFERMEDAD])),sinonimo("Natacion", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"flotar "):-not(phrase(enfermedad,[ENFERMEDAD])),sinonimo("Natacion", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"sumergirte "):-not(sinonimo("Asma",ENFERMEDAD)), sinonimo("Natacion", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"nadar de perrito "):-not(phrase(enfermedad,[ENFERMEDAD])),sinonimo("Natacion", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"nadar en un rio o mar "):-not(phrase(enfermedad,[ENFERMEDAD])),sinonimo("Natacion", DEPORTE).


%Entrenamientos a realizar en caso de Atletismo dependiendo de la enfermedad 
actividad(DEPORTE,ENFERMEDAD,"caminar en zona urbana "):-not(phrase(enfermedad,[ENFERMEDAD])),sinonimo("Atletismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"caminar en zona rural "):-not(sinonimo("Diabetes",ENFERMEDAD)), sinonimo("Atletismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"trotar "):-not(phrase(enfermedad,[ENFERMEDAD])),sinonimo("Atletismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"correr libre "):-not(sinonimo("Rodilla",ENFERMEDAD)),not(sinonimo("Asma",ENFERMEDAD)),sinonimo("Atletismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"correr con obstaculos "):-not(sinonimo("Cardiacos",ENFERMEDAD)),sinonimo("Atletismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"trotar con tu mascota "):-not(phrase(enfermedad,[ENFERMEDAD])),sinonimo("Atletismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"trotar en maquina caminadora "):-not(phrase(enfermedad,[ENFERMEDAD])),sinonimo("Atletismo", DEPORTE).

%Entrenamientos a realizar en caso de Ciclismo dependiendo de la enfermedad 
actividad(DEPORTE,ENFERMEDAD,"cletear en terreno plano "):-not(phrase(enfermedad,[ENFERMEDAD])),sinonimo("Ciclismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"cletear en terreno montanoso "):-not(sinonimo("Rodilla",ENFERMEDAD)),not(sinonimo("Diabetes",ENFERMEDAD)),sinonimo("Ciclismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"cletear en terreno empinado "):-not(sinonimo("Cardiacos",ENFERMEDAD)),sinonimo("Ciclismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"cletear en rampas "):-not(sinonimo("Columna",ENFERMEDAD)),sinonimo("Ciclismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"cletear en pista de ciclismo "):-not(phrase(enfermedad,[ENFERMEDAD])),sinonimo("Ciclismo", DEPORTE).
actividad(DEPORTE,ENFERMEDAD,"cletear en rodillos moviles "):-not(phrase(enfermedad,[ENFERMEDAD])),sinonimo("Ciclismo", DEPORTE).


%Calentamientos a realizar dependiendo del deporte
calentamiento(DEPORTE,"usar la bicicleta estacionaria "):-sinonimo("Ciclismo", DEPORTE).
calentamiento(DEPORTE,"hacer fondos 4 min "):-sinonimo("Atletismo", DEPORTE).
calentamiento(DEPORTE,"hacer estiramiento de extremidades "):-sinonimo("Natacion", DEPORTE).
calentamiento(_,"hacer ejercicios de baja intensidad ").


%Decansos a realizar dependiendo del deporte
descanso(ENFERMEDAD,"empaca el respirador,alejate del polvo  "):-sinonimo("Asma",ENFERMEDAD).
descanso(ENFERMEDAD,"comer comidas bajas en azucar  "):-sinonimo("Diabetes",ENFERMEDAD).
descanso(ENFERMEDAD,"masajes en la zona afectada "):-sinonimo("Rodilla",ENFERMEDAD),sinonimo("Columna",ENFERMEDAD).
descanso(ENFERMEDAD,"Tomarse el pulso y la presion "):-sinonimo("Cardiacos",ENFERMEDAD).
descanso(_,"dormir bien y descanzar ").
descanso(_,"alejarse del estres ").
descanso(_,"pasar tiempo con la Family ").

%Devuelve si el dia es de descanso o entreno dependiendo de los dias Libres habiles.
diaEntreno("Lunes: ",Type,N):-((N>1,N<7)->Type="Entreno";Type="Libre").
diaEntreno("Martes: ",Type,N):-((N>3,N<7)->Type="Entreno";Type="Libre").
diaEntreno("Miercoles: ",Type,N):-((N>2,N<7,not(N=4))->Type="Entreno";Type="Libre").
diaEntreno("Jueves: ",Type,N):-((N>3,N<7)->Type="Entreno";Type="Libre").
diaEntreno("Viernes: ",Type,N):-((N>2,N<7)->Type="Entreno";Type="Libre").
diaEntreno("Sabado: ",Type,N):-((N<3,N>5)->Type="Entreno";Type="Libre").

%Hechos para iterar las opciones.
opciones("Opcion 1: ").
opciones("Opcion 2: ").
opciones("Opcion 3: ").

%Construye las rutinas de entrenamiento con su respectivo calentamineto dependiendo del deporte y la enfermeda 
getRoutine(DEP,ENF,DIF,L,P):-calentamiento(DEP,CALEN),actividad(DEP,ENF,AC),distancia(DIF,DIS),unidad(DEP,UNI),concatenar(["para calentar puedes ",CALEN,"y como entrenamiento puedes ",AC,DIS,UNI],L,P).
getAllRoutines(DEP,ENF,DIF,Lista):-findall(Routine,getRoutine(DEP,ENF,DIF,[],Routine),Lista).%Devuelve una Lista con todas las rutinas posibles


%Construye el descanso dependiendo de la enfermeda 
getFreeDay(ENF,L,P):-descanso(ENF,Descanso),concatenar([Descanso],L,P).
getAllFreeDays(ENF,Lista):-findall(FreeDay,getFreeDay(ENF,[],FreeDay),Lista).%Devuelve una lista con todos los descansos.


%Deside si devolver una rutina o un descanso dependiendo del dia
getAllDesition(FRE,ListaRoutines,ListaFree,Semana):-findall(ListaRes,getDesition(FRE,ListaRoutines,ListaFree,ListaRes),Semana).
getDesition(FRE,ListaRoutines,ListaFree,ListaRes):-size(ListaRoutines,SizeR),size(ListaFree,SizeF),diaEntreno(DIA,Type,FRE),((Type="Entreno")->random(0,SizeR,I),getInd(ListaRoutines,I,Routine),concatenar([DIA],Routine,ListaRes);random(0,SizeF,I),getInd(ListaFree,I,Free),concatenar([DIA],Free,ListaRes)).

%Retorna una Matris con un esquema semanal con todo el itinerario
getRoutineMatriz(DEP,ENF,DIF,FRE,Semana):-resta(FRE,WORK),getAllRoutines(DEP,ENF,DIF,ListaRoutines),getAllFreeDays(ENF,ListaFree),getAllDesition(WORK,ListaRoutines,ListaFree,Semana).

%Imprime la Matriz con 3 esquemas con Rutinas Variadas.
printAllRoutines(DEP,ENF,DIF,FRE):-write("Estas son algunos Esquemas que podrias probar: "),nl,nl,findall(_,printRoutine(DEP,ENF,DIF,FRE),_),write("Ir a Misa Todos los Domingos es Dia del Senor").
printRoutine(DEP,ENF,DIF,FRE):-opciones(Text),getRoutineMatriz(DEP,ENF,DIF,FRE,Semana),write(Text),nl,printMatriz(Semana),nl.


