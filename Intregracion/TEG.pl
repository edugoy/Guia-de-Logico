%Base de conocimiento 
/* distintos paises */
paisContinente(argentina, americaDelSur).
paisContinente(bolivia, americaDelSur).
paisContinente(brasil, americaDelSur).
paisContinente(chile, americaDelSur).
paisContinente(ecuador, americaDelSur).
paisContinente(alemania, europa).
paisContinente(espania, europa).
paisContinente(francia, europa).
paisContinente(inglaterra, europa).
paisContinente(aral, asia).
paisContinente(china, asia).
paisContinente(gobi, asia).
paisContinente(india, asia).
paisContinente(iran, asia).

/*países importantes*/
paisImportante(argentina).
paisImportante(kamchatka).
paisImportante(alemania).

/*países limítrofes*/
limitrofes(argentina,brasil).
limitrofes(bolivia,brasil).
limitrofes(bolivia,argentina).
limitrofes(argentina,chile).
limitrofes(espania,francia).
limitrofes(alemania,francia).
limitrofes(nepal,india).
limitrofes(china,india).
limitrofes(nepal,china).
limitrofes(afganistan,china).
limitrofes(iran,afganistan).

/*distribución en el tablero */
ocupa(argentina, azul, 4).
ocupa(bolivia, rojo, 1).
ocupa(brasil, verde, 4).
ocupa(chile, negro, 3).
ocupa(ecuador, rojo, 2).
ocupa(alemania, azul, 3).
ocupa(espania, azul, 1).
ocupa(francia, azul, 1).
ocupa(inglaterra, azul, 2). 
ocupa(aral, negro, 2).
ocupa(china, verde, 1).
ocupa(gobi, verde, 2).
ocupa(india, rojo, 3).
ocupa(iran, verde, 1).

/*continentes*/
continente(americaDelSur).
continente(europa).
continente(asia).

/*objetivos*/
objetivo(rojo, ocuparContinente(asia)).
objetivo(azul, ocuparPaises([argentinabolivia, francia, inglaterra, china])).
objetivo(verde, destruirJugador(rojo)).
objetivo(negro, ocuparContinente(europa)).

%1. estaEnContinente/2: Relaciona un jugador y un continente si el jugador ocupa al menos un país en el continente.
    estaEnContinente(Jugador, Continente) :-
        ocupa(Pais, Jugador, _),
        paisContinente(Pais, Continente).

%2. cantidadPaises/2: Relaciona a un jugador con la cantidad de países que ocupa.
cantidadPaises(Jugador, CantidadPaisesOcupados) :-
    ocupa(Pais, Jugador, _),
    findall(Pais, ocupa(Pais, Jugador, _), Paises),
    length(Paises, CantidadPaisesOcupados).
    
%3. ocupaContinente/2: Relaciona un jugador y un continente si el jugador ocupa totalmente al continente.
ocupaContinente(Jugador, Continente) :-
    estaEnContinente(Jugador, Continente),
    forall(paisContinente(Pais, Continente), ocupa(Pais, Jugador, _)).
    

%4. leFaltaMucho/2: Relaciona a un jugador y un continente si al jugador le falta ocupar más de 2 países de dicho continente.
leFaltaMucho(Jugador, Continente) :-
    estaEnContinente(Jugador, Continente),
    noOcupaPaisDe(Continente, Pais1, Jugador),
    noOcupaPaisDe(Continente, Pais2, Jugador),
    Pais1 \= Pais2.

noOcupaPaisDe(Continente, Pais, Jugador) :-
    paisContinente(Continente, Pais),
    not(ocupa(Pais, Jugador, _)).

%5. sonLimitrofes/2: Relaciona 2 países si son limítrofes.
sonLimitrofes(Pais1, Pais2) :-
    limitrofes(Pais1, Pais2).

sonLimitrofes(Pais1, Pais2) :-
    limitrofes(Pais2, Pais1).

%6. esGroso/1: Un jugador es groso si cumple alguna de estas condiciones:
    %a) ocupa todos los países importantes,
    %b) ocupa más de 10 países
esGroso(Jugador) :-
    forall(paisImportante(Pais), ocupa(Pais, Jugador, _)).

esGroso(Jugador) :- 
    findall(Pais, ocupa(Pais, Jugador, _), Paises),
    length(Paises, CantidadPaises),
    CantidadPaises > 10.

%7. estaEnElHorno/1: un país está en el horno si todos sus países limítrofes están ocupados por el mismo jugador que no es el mismo que ocupa ese país.
estaEnElHorno(Jugador) :-
    ocupa(Pais, Jugador, _),
    ocupa(_, OtroJugador, _),
    Jugador \= OtroJugador,
    forall(sonLimitrofes(Pais, Limitrofe), ocupa(Limitrofe, OtroJugador, _)).

%8. esCaotico/1: un continente es caótico si hay más de tres jugadores en él.
esCaotico(Continente) :-
    estaEnContinente(Jugador, Continente),
    estaEnContinente(OtroJugador, Continente),
    Jugador \= OtroJugador.

%9. capoCannoniere/1: es el jugador que tiene ocupado más países.
capoCannoniere(Jugador) :-
    cantidadPaises(Jugador, Cantidad1),
    not((cantidadPaises(OtroJugador, Cantidad2), Cantidad1 > Cantidad2)).