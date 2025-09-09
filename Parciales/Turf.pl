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
ganoPremioImportante(botafogo, granPremioNacional).
ganoPremioImportante(botafogo, granPremioRepublica).
ganoPremioImportante(oldMan, granPremioRepublica).
ganoPremioComun(oldMan, campeonatoDeOro).
ganoPremioComun(matBoy, granPremioCriadores).

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
%pto 4
piolin(Jockey) :-
    jockey(Jockey, _, _),
    ganoPremioImportante(_, _),
    forall(ganoPremioImportante(Caballo, _), prefiere(Caballo, Jockey)).
%pto 5
resultado([botafogo, oldMan, energica]).
primerosDos(resultado([Primero, Segundo | _]), Primero, Segundo).

gana(ganador(Caballo), Carrera) :-
    primerosDos(Carrera, Caballo, _).

gana(segundo(Caballo), Carrera) :-
    primerosDos(Carrera, Caballo, _).
gana(segundo(Caballo), Carrera) :-
    primerosDos(Carrera, _, Caballo).

gana(exacta(Caballo1, Caballo2), Carrera) :-
    primerosDos(Carrera, Caballo1, Caballo2).

gana(imperfecta(Caballo1, Caballo2), Carrera) :-
    primerosDos(Carrera, Caballo1, Caballo2).
gana(imperfecta(Caballo1, Caballo2), Carrera) :-
    primerosDos(Carrera, Caballo2, Caballo1).

%pto 6
colorCrin(botafogo, negro).
colorCrin(oldMan, marron).
colorCrin(energica, gris).
colorCrin(energica, negro).
colorCrin(matBoy, marron).
colorCrin(matBoy, blanco).
colorCrin(yatasto, blanco).
colorCrin(yatasto, marron).

puedeComprar(Color, CualesPuedeComprar) :-
    colorCrin(_, Color),
    findall(Caballo, colorCrin(Caballo, Color), CualesPuedeComprar).