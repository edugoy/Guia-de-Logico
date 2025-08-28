%base de conocimiento
linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).
combinacion([lima, avMayo]).
combinacion([once, miserere]).
combinacion([pellegrini, diagNorte, nueveJulio]).
combinacion([independenciaC, independenciaE]).
combinacion([jujuy, humberto1ro]).
combinacion([santaFe, pueyrredonD]).
combinacion([corrientes, pueyrredonB]).


%1. En qué linea está una estación, predicado estaEn/2.
estaEn(Linea, Estacion) :-
    linea(Linea, Estaciones),
    member(Estacion, Estaciones).

%2. dadas dos estaciones de la misma línea, cuántas estaciones hay entre ellas, p.ej. entre Perú y Primera Junta hay 5 estaciones. Predicado distancia/3 (relaciona las dos estaciones y la distancia).
distancia(Estacion, OtraEstacion, Distancia) :- 
    linea(_, Estaciones), 
    nth1(Inicio, Estaciones, Estacion), 
    nth1(Fin, Estaciones, OtraEstacion), 
    Distancia is abs(Fin - Inicio) - 1.    

%3. Dadas dos estaciones de distintas líneas, si están a la misma altura (o sea, las dos terceras, las dos quintas, etc.), p.ej. Independencia C y Jujuy que están las dos cuartas. Predicado mismaAltura/2.
mismaAltura(Estacion, OtraEstacion) :-
    linea(Linea, Estaciones),
    linea(OtraLinea, OtrasEstaciones),
    Linea \= OtraLinea,
    nth1(Altura, Estaciones, Estacion),
    nth1(Altura, OtrasEstaciones, OtraEstacion).


%4. Dadas dos estaciones, si puedo llegar fácil de una a la otra, esto es, si están en la misma línea, o bien puedo llegar con una sola combinación. Predicado viajeFacil/2.

viajeFacil(Estacion, OtraEstacion) :-
    mismaLinea(Estacion, OtraEstacion).

viajeFacil(Estacion, OtraEstacion) :-
    combinacionPara(Estacion, Combinacion1),
    combinacionPara(OtraEstacion, Combinacion2),
    mismaCombinacion(Combinacion1, Combinacion2).

mismaLinea(Estacion, OtraEstacion) :-
    estaEn(Linea, Estacion),
    estaEn(Linea, OtraEstacion).

combinacionPara(Estacion, Combinacion) :-
    estaEn(Linea, Estacion),
    linea(Linea, Estaciones),
    member(Combinacion, Estaciones).

mismaCombinacion(Combinacion1, Combinacion2) :-
    combinacion(Combinaciones),
    member(Combinacion1, Combinaciones),
    member(Combinacion2, Combinaciones).
