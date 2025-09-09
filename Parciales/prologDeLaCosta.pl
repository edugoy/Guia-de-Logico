%1) modelado
puestoDeComida(hamburguesa, 2000).
puestoDeComida(panchitoConPapas, 1500).
puestoDeComida(lomitoCompleto, 2500).
puestoDeComida(caramelos, 0).
%visitante(Nombre, Dinero, edad).
%grupoFamiliar(Nombre, Familia).
%estadoVisitante(Nombre, Hambre, Aburrimiento).
visitante(eusebio, 3000, 80).
grupoFamiliar(eusebio, viejitos).
estadoVisitante(eusebio, 50, 0).

visitante(carmela, 0, 80).
grupoFamiliar(carmela, viejitos).
estadoVisitante(carmela, 0, 25).

visitante(jose, 10000, 30).
estadoVisitante(jose, 10, 0).

visitante(martina, 0, 15).
estadoVisitante(martina, 60, 50).

esChico(Visitante) :-
    visitante(Visitante, _, Edad),
    Edad < 13.
esAdulto(Visitante) :-
    visitante(Visitante, _, Edad),
    Edad >= 13.

%atracciones(Nombre, Categoria).
atracciones(autitosChocadores, tranquila(todos)).
atracciones(casaEmbrujada, tranquila(todos)).
atracciones(laberinto, tranquila(todos)).
atracciones(tobogan, tranquila(chicos)).
atracciones(calesita, tranquila(chicos)).

atracciones(barcoPirata, intensa(14)).
atracciones(tazasChinas, intensa(6)).
atracciones(simulador3D, intensa(2)).

atracciones(abismoMortalRecargada, montaniaRusa(3, 134)).
atracciones(paseoPorElBosque, montaniaRusa(0, 45)).

atracciones(elTorpedoSalpicon, acuatica).
atracciones(esperoQueHayasTraidoUnaMudaDeRopa, acuatica).

%2)
estadoDeBienestar(felicidadPlena, Visitante) :-
    visitante(Visitante, _, _),
    not(vieneSolo(Visitante)),
    estadoVisitante(Visitante, 0, 0).
estadoDeBienestar(podriaEstarMejor, Visitante) :-
    visitante(Visitante, _, _),
    estadoVisitante(Visitante, Hambre, Aburrimiento),
    Suma is Hambre + Aburrimiento,
    estaEntre(Suma, 1, 50).
estadoDeBienestar(podriaEstarMejor, Visitante) :-
    visitante(Visitante, _, _),
    vieneSolo(Visitante),
    estadoVisitante(Visitante, 0, 0).
estadoDeBienestar(necesitaEntretenerse, Visitante) :-
    visitante(Visitante, _, _),
    estadoVisitante(Visitante, Hambre, Aburrimiento),
    Suma is Hambre + Aburrimiento,
    estaEntre(Suma, 51, 99).
estadoDeBienestar(quiereIrACasa, Visitante) :-
    visitante(Visitante, _, _),
    estadoVisitante(Visitante, Hambre, Aburrimiento),
    Suma is Hambre + Aburrimiento,
    Suma >= 100.
estaEntre(Parametro, Numero1, Numero2) :-
    Parametro >= Numero1,
    Parametro =< Numero2.
vieneSolo(Visitante) :-
    not(grupoFamiliar(Visitante, _)).
%3)
puedeSatisfacerHambre(Familia, Comida) :-
    grupoFamiliar(_, Familia),
    forall(grupoFamiliar(Integrante, Familia), (satisfaceIntegrante(Integrante, Comida), tieneDineroSuficiente(Integrante, Comida))).
    
satisfaceIntegrante(Visitante, hamburguesa) :-
    visitante(Visitante, _, _),
    estadoVisitante(Visitante, Hambre, _),
    Hambre < 50.
satisfaceIntegrante(Visitante, panchitoConPapas) :-
    esChico(Visitante).
satisfaceIntegrante(Visitante, caramelos) :-
    visitante(Visitante, _, _),
    forall(comidaPaga(Comida), not(tieneDineroSuficiente(Visitante, Comida))).
satisfaceIntegrante(Visitante, lomitoCompleto).

comidaPaga(hamburguesa).
comidaPaga(panchitoConPapas).
comidaPaga(lomitoCompleto).

tieneDineroSuficiente(Visitante, Comida) :-
    visitante(Visitante, Dinero, _),
    puestoDeComida(Comida, Precio),
    Dinero >= Precio.
%4)
lluviaDeHamburguesas(Visitante, Atraccion) :-
    visitante(Visitante, _, _),
    tieneDineroSuficiente(Visitante, hamburguesa),
    atracciones(Atraccion, intensa(Coeficiente)),
    Coeficiente > 10.
lluviaDeHamburguesas(Visitante, Atraccion) :-
    visitante(Visitante, _, _),
    tieneDineroSuficiente(Visitante, hamburguesa),
    esMontaniaRusaPeligrosa(Visitante, Atraccion).
lluviaDeHamburguesas(Visitante, tobogan) :-
    visitante(Visitante, _, _),
    tieneDineroSuficiente(Visitante, hamburguesa).

esMontaniaRusaPeligrosa(Visitante, Atraccion) :-
    esAdulto(Visitante),
    not(estadoDeBienestar(necesitaEntretenerse, Visitante)),
    atracciones(Atraccion, montaniaRusa(Giros, _)),
    forall(atracciones(OtrAtraccion, montaniaRusa(OtrosGiros, _)), OtrosGiros =< Giros).
esMontaniaRusaPeligrosa(Visitante, Atraccion) :-
    esChico(Visitante),
    atracciones(Atraccion, montaniaRusa(_, Duracion)),
    Duracion > 60. 
%5)
