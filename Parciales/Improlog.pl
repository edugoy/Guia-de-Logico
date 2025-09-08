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