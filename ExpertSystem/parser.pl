:-consult('BNF.pl').

%-------------------------------------MAIN PARSER
% Main parser used to evaluate users common sentences.
% INPUT: User text 
% OUTPUT: True or False
% STRUCTURE: phrase(GrammarRule, InputList)
analizarOracion(Input) :- phrase(oracion, Input).


