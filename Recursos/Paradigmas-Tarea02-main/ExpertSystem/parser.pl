:-consult('BNF.pl').

%-------------------------------------MAIN PARSER
% Main parser used to evaluate users common sentences.
% INPUT: User text 
% OUTPUT: True or False
analyzeSentence(Input) :- phrase(sentence, Input).


%-------------------------------------AUXLIAR PARSER
% Auxiliary parser used to evaluate user input when dealing with auxiliary locations.
% INPUT: User text 
% OUTPUT: True or False
analyzeAuxiliarSentence(Input) :- phrase(auxiliarSentence, Input).