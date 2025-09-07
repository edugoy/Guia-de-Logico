%base de conocimiento 
%recorrido(Numero, localidad, CallePorLaQuePasa)
% Recorridos en GBA:
recorrido(17, gba(sur), mitre).
recorrido(24, gba(sur), belgrano).
recorrido(247, gba(sur), onsari).
recorrido(60, gba(norte), maipu).
recorrido(152, gba(norte), olivos).

% Recorridos en CABA:
recorrido(17, caba, santaFe).
recorrido(152, caba, santaFe).
recorrido(10, caba, santaFe).
recorrido(160, caba, medrano).
recorrido(24, caba, corrientes).

puedenCombinarse(Linea, OtraLinea) :-
    recorrido(Linea, Zona, Calle),
    recorrido(OtraLinea, Zona, Calle),
    Linea \= OtraLinea.

pasaPorCaba(Linea) :-
    recorrido(Linea, caba, _).

pasaPorGba(Linea) :-
    recorrido(Linea, gba(_), _).

cruzaLaGralPaz(Linea) :-
    pasaPorCaba(Linea),
    pasaPorGba(Linea).

jurisdiccionDeUnaLinea(Linea, nacional) :-
    cruzaLaGralPaz(Linea).

jurisdiccionDeUnaLinea(Linea, provincial(buenosAires)) :-
    pasaPorGba(Linea),
    not(cruzaLaGralPaz(Linea)).

jurisdiccionDeUnaLinea(Linea, provincial(caba)) :-
    pasaPorCaba(Linea),
    not(cruzaLaGralPaz(Linea)).

calleMasTransitada(Zona, Calle) :-
    lineasQuePasan(Zona, Calle, Cantidad),
    not((lineasQuePasan(Zona, OtraCalle, OtraCantidad), OtraCalle \=  Calle, OtraCantidad > Cantidad)).

lineasQuePasan(Zona, Calle, Cantidad) :-
    recorrido(_, Zona, Calle),
    findall(Linea, recorrido(Linea, Zona, Calle), Lineas),
    length(Lineas, Cantidad).

callesDeTransbordo(Zona, Calle) :-
    lineasQuePasan(Zona, Calle, Cantidad),
    Cantidad >= 3,
    forall(recorrido(Linea, Zona, Calle), jurisdiccionDeUnaLinea(Linea, nacional)).

beneficiario(pepito, personalDeCasasParticulares(gba(oeste))).
beneficiario(juanita, estudiantil).
beneficiario(marta, jubilado).
beneficiario(marta, personalDeCasasParticulares(caba)).
beneficiario(marta, personalDeCasasParticulares(gba(sur))).

beneficio(estudiantil, _, 50).
beneficio(personalDeCasasParticulares(Zona), Linea, 0) :-
    recorrido(Linea, Zona, _).

beneficio(jubilado, _, ValorConBerneficio) :- 
    valorNormal(Linea, ValorSinBeneficio),
    ValorConBerneficio is ValorSinBeneficio / 2 .

valorNormal(Linea, 500) :-
    jurisdiccionDeUnaLinea(Linea, nacional).

valorNormal(Linea, 350) :-
    jurisdiccionDeUnaLinea(Linea, provincial(caba)).

valorNormal(Linea, Valor) :-
    jurisdiccionDeUnaLinea(Linea, provincial(buenosAires)),
    findall(Calle, recorrido(Linea, _, Calle), Calles),
    length(Calles, cantidadDeCalles),
    plus(Linea, Plus),
    Valor is (25 * cantidadDeCalles) + Plus.

plus(Linea, 50) :-
    pasaPorZonasDiferentes(Linea).

plus(Linea, 0) :-
    not(pasaPorZonasDiferentes(Linea)).

pasaPorZonasDiferentes(Linea) :-
    recorrido(Linea, gba(Zona), _),
    recorrido(Linea, gba(OtraZona), _),
    Zona \= OtraZona.

posiblesBeneficios(Persona, Linea, ValorConBeneficio):-
    beneficiario(Persona, Beneficio),
    beneficio(Beneficio, Linea, ValorConBeneficio).

costo(Persona, Linea, CostoFinal):-
    beneficiario(Persona, _),
    recorrido(Linea, _, _),
    posiblesBeneficios(Persona, Linea, CostoFinal),
    forall((posiblesBeneficios(Persona, Linea, OtroValorBeneficiado), OtroValorBeneficiado \= CostoFinal), CostoFinal < OtroValorBeneficiado).

costo(Persona, Linea, ValorNormal):-
   persona(Persona),
   valorNormal(Linea, ValorNormal),
   not(beneficiario(Persona, _)).
   
persona(pepito).
persona(juanita).
persona(tito).
persona(marta).
