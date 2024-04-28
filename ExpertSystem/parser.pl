:-consult('BNF.pl').

%-------------------------------------MAIN PARSER
% Parser's utilizados para analizar las oraciones del usuario en distintos contextos
% INPUT: Entrada del usuario
% OUTPUT: True o False
% ESTRUCTURA: phrase(GrammarRule, InputList)
analizarDeporte(Input) :- phrase(oracionDeporte, Input).
analizarEnfermedad(Input) :- phrase(oracionEnfermedad, Input).
analizarAfirmacion(Input) :- phrase(oracionAfirmacion, Input).
analizarNivel(Input) :- phrase(oracionNivel, Input).
analizarDiasLibres(Input) :- phrase(oracionDiasLibre, Input).
analizarPregunta(Input) :- phrase(oracionPregunta, Input).
