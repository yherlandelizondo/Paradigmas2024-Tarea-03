:-consult('BNF.pl').

%-------------------------------------MAIN PARSER
% Main parser used to evaluate users common sentences.
% INPUT: User text 
% OUTPUT: True or False
% STRUCTURE: phrase(GrammarRule, InputList)
analizarDeporte(Input) :- phrase(oracionDeporte, Input).
analizarEnfermedad(Input) :- phrase(oracionEnfermedad, Input).
analizarAfirmacion(Input) :- phrase(oracionAfirmacion, Input).

