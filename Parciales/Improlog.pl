integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(jazzmin, santi, bateria).

nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

tieneUnaBuenaBase(Grupo) :-
    integrante(Grupo, Integrante, Instrumento),
    integrante(Grupo, OtroIntegrante, OtroInstrumento),
    tocaInstrumentoRitmico(Instrumento),
    tocaInstrumentoArmonico(OtroInstrumento),
    Integrante \= OtroIntegrante.

tocaInstrumentoRitmico(Instrumento) :-
    instrumento(Instrumento, ritmico).

tocaInstrumentoArmonico(Instrumento) :-
    instrumento(Instrumento, armonico).

seDestaca(Grupo, Integrante) :-
    integrante(Grupo, Integrante, Instrumento),
    nivelQueTiene(Integrante, Instrumento, Nivel),
    forall((integrante(Grupo, OtroIntegrante, OtroInstrumento),
        Integrante \= OtroIntegrante, 
        nivelQueTiene(OtroIntegrante, OtroInstrumento, OtroNivel)), 
        Nivel - OtroNivel >= 2).

grupo(vientosDelEste, bigBand).
grupo(sophieTrio, formacionParticular([contrabajo, guitarra, violin])).
grupo(jazzmin, formacionParticular([bateria, bajo, trompeta, piano, guitarra])).

hayCupo(Grupo, Instrumento) :-
    grupo(Grupo, bigBand),
    instrumento(Instrumento, melodico(viento)).

hayCupo(Grupo, Instrumento) :-
    grupo(Grupo, formacionParticular(ListaInstrumentos)),
    member(Instrumento, ListaInstrumentos),
    not(integrante(Grupo, _, Instrumento)).

sirveBigBand(bateria).
sirveBigBand(bajo).
sirveBigBand(piano).

hayCupo(Grupo, Instrumento) :-
    grupo(Grupo, bigBand),
    sirveBigBand(Instrumento),
    not(integrante(Grupo, _, Instrumento)).

puedeIncorporarse(Grupo, Integrante, Instrumento) :-
    integrante(_, Integrante, Instrumento),
    not(integrante(Grupo, Integrante, _)),
    hayCupo(Grupo, Instrumento),
    nivelQueTiene(Integrante, Instrumento, Nivel),
    requerimiento(Grupo, Nmin),
    Nivel >= Min.

requerimiento(Grupo, Min) :-
    grupo(Grupo, bigBand),
    Min is 1.

requerimiento(Grupo, Min) :-
    grupo(Grupo, formacionParticular(ListaInstrumentos)),
    length(ListaInstrumentos, CantidadInstrumentos),
    Min is 7 - CantidadInstrumentos.

seQuedoEnBanda(Integrante) :-
    not(integrante(_, Integrante, _)),
    not(puedeIncorporarse(_, Integrante, _)).

puedeTocar(Grupo) :-
    grupo(Grupo, bigBand),
    tieneUnaBuenaBase(Grupo),
    findall(Integrante, tocaTipoViento(Grupo, Integrante), Integrantes),
    length(Integrantes, Cantidad),
    Cantidad >= 5.

tocaTipoViento(Grupo, Integrante) :-
    integrante(Grupo, Integrante, Instrumento),
    instrumento(Instrumento, melodico(viento)).

puedeTocar(Grupo) :-
    grupo(Grupo, formacionParticular(ListaInstrumentos)),
    forall(member(Instrumento, ListaInstrumentos), integrante(Grupo, _, Instrumento)).

grupo(studio1, ensamble(3)).

requerimiento(Grupo, Min) :-
    grupo(Grupo, ensamble(Min)).

sirveParaGrupo(Grupo, _) :-
    grupo(Grupo, ensamble(_)).

puedeTocar(Grupo) :-
    grupo(Grupo, ensamble(_)),
    tieneUnaBuenaBase(Grupo),
    integrante(Grupo, _, Instrumento),
    instrumento(Inst, melodico(_)).