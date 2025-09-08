%base de conocimiento (pto 1)
%jockey(Nombre, Altura, Peso).
jockey(valdivieso, 155, 52).
jockey(leguisamon, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).

%caballoe(Nombre).
caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

%stud(Nombre, Club).
stud(valdivieso, elTute).
stud(falero, elTute).
stud(lezcano, lasHormigas).
stud(baratucci, elCharabon).
stud(leguisamon, elCharabon).

%gano(Caballo, Premio).
gano(botafogo, granPremioNacionl).
gano(botafogo, granPremioRepublica).
gano(oldMan, granPremioRepublica).
gano(oldMan, campeonatoDeOro).
gano(matBoy, granPremioCriadores).

%preferencia de caballo
%prefiere(caballo, condicion).
prefiere(botafogo, Nombre) :-
    jockey(Nombre, _, Peso),
    Peso < 52.
prefiere(botafogo, baratucci).
prefiere(oldMan, Nombre) :-
    jockey(Nombre, _, _),
    atom_length(Nombre, CantidadLetras),
    CantidadLetras > 7.
prefiere(energica, Nombre) :-
    jockey(Nombre, _, _),
    not(prefiere(botafogo, Nombre)).
prefiere(matBoy, Nombre) :-
    jockey(Nombre, Altura, _),
    Altura > 170.

%pto 2
prefierenMasDeUno(Nombre) :-
    caballo(Nombre),
    prefiere(Nombre, Jockey),
    prefiere(Nombre, OtroJockey),
    Jockey \= OtroJockey.
%pto 3
aborrece(Caballo, Stud) :-
    caballo(Caballo),
    stud(_, Stud),
    forall(stud(Jockey, Stud), not(prefiere(Caballo, Jockey))).