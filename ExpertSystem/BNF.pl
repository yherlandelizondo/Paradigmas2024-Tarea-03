
%-------------------------------------GRAMMATICAL RULES

    %   DETERM + LOCATION
    nounPhrase --> determ, place.
    % nounPhrase --> ["En"], Cartago.

    %   VERB + nounPhrase
    verbPhrase --> verb, nounPhrase.
    % verbPhrase --> ["Estoy", "en"], place.


    
 %-------------------------------------SENTENCES

    sentence --> sport. %ok
    sentence --> nounPhrase.
    sentence --> verbPhrase.
    sentence --> determ, verbPhrase.
    sentence --> verb, verbPhrase.


%-------------------------------------VERBS

    verb --> ["Estoy"].
    verb --> ["Soy"].
    verb --> ["Voy"].
    verb --> ["Parare"].
    verb --> ["Dirijo"].
    verb --> ["encuentro"].
    verb --> ["Tengo"].
    verb --> ["tengo"].
    verb --> ["pasar"].
    verb --> ["gustaria"].
    verb --> ["ubico"].
    verb --> ["ubica"].
    verb --> ["ubicado"].
    verb --> ["dirijo"].
    verb --> ["esta"].
    verb --> ["Esta"].
    verb --> ["Queda"].

%-------------------------------------DETERMINANTS
    determ -->["en"].
    determ -->["En"].
    determ -->["de"].
    determ -->["De"].
    determ -->["a"].
    determ -->["A"].
    determ -->["Se"].
    determ -->["se"].
    determ -->["Al"].
    determ -->["al"].
    determ -->["la"].
    determ -->["para"].
    determ -->["Para"].
    determ -->["que"].
    determ -->["Me"].
    determ -->["el"].
    determ -->["El"].

%-------------------------------------PLACES

    sport --> ["natacion"].
    sport --> ["atletismo"].
    sport --> ["beisbol"].
    sport --> ["ciclismo"].

%-------------------------------------AUXILIAR PLACES

    auxPlace --> ["supermercado"].
    auxPlace --> ["cine"].
    auxPlace --> ["gimnasio"].
    auxPlace --> ["escuela"].
    auxPlace --> ["universidad"].
    auxPlace --> ["cancha"].