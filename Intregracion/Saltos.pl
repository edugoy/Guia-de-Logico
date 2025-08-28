%base de conocimineto
puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[7,10,10]).

%1. Qué puntaje obtuvo un competidor en un salto,
puntajeObtenido(Competidor, NumeroDeSalto, Puntaje) :-
    puntajes(Competidor, ListaDePuntajes),
    nth1(NumeroDeSalto, ListaDePuntajes, Puntaje).

%2. Si un competidor está descalificado o no. Un competidor está descalificado si hizo más de 5 saltos. En el ejemplo, Julio está descalificado.
estaDescalificado(Competidor) :-
    puntajes(Competidor, ListaDeSaltos),
    length(ListaDeSaltos, CantidadDeSaltos),
    CantidadDeSaltos > 5.
    
%3. Si un competidor clasifica a la final. Un competidor clasifica a la final si la suma de sus puntajes es mayor o igual a 28, o si tiene dos saltos de 8 o más puntos.
calificaALaFinal(Competidor) :-
    puntajes(Competidor, ListaDePuntajes),
    (sum_list(ListaDePuntajes, PuntosTotales),
    PuntosTotales >= 28;
    dosSaltosBuenos(ListaDePuntajes)).

dosSaltosBuenos(ListaDePuntajes) :-
    findall(Salto, (member(Salto, ListaDePuntajes), Salto >= 8), SaltosBuenos),
    length(SaltosBuenos, CantidadDeSaltosBuenos),
    CantidadDeSaltosBuenos >= 2.
