%Una agencia de viajes lleva un registro con todos los vuelos que maneja de la siguiente manera:
%vuelo(Codigo de vuelo, capacidad en toneladas, [lista de destinos]).
%escala(ciudad, tiempo de espera)
%tramo(tiempo en vuelo)
%base de conocimiento 
vuelo(ARG845, 30, [escala(rosario,0), tramo(2), escala(buenosAires,0)]).

vuelo(MH101, 95, [escala(kualaLumpur,0), tramo(9), escala(capeTown,2),
tramo(15), escala(buenosAires,0)]).

vuelo(DLH470, 60, [escala(berlin,0), tramo(9), escala(washington,2), tramo(2), escala(nuevaYork,0)]).

vuelo(AAL1803, 250, [escala(nuevaYork,0), tramo(1), escala(washington,2),
tramo(3), escala(ottawa,3), tramo(15), escala(londres,4), tramo(1),
escala(paris,0)]).

vuelo(BLE849, 175, [escala(paris,0), tramo(2), escala(berlin,1), tramo(3),
escala(kiev,2), tramo(2), escala(moscu,4), tramo(5), escala(seul,2), tramo(3), escala(tokyo,0)]).

vuelo(NPO556, 150, [escala(kiev,0), tramo(1), escala(moscu,3), tramo(5),
escala(nuevaDelhi,6), tramo(2), escala(hongKong,4), tramo(2), escala(shanghai,5), tramo(3), escala(tokyo,0)]).

vuelo(DSM3450, 75, [escala(santiagoDeChile,0), tramo(1), escala(buenosAires,2), tramo(7), escala(washington,4), tramo(15), escala(berlin,3), tramo(15), escala(tokyo,0)]).

%1. tiempoTotalVuelo/2 : Relaciona un vuelo con el tiempo que lleva en total, contando las esperas en las escalas (y eventualmente en el origen y/o destino) más el tiempo de vuelo.
tiempoTotalVuelo(Vuelo, Tiempo) :-
    vuelo(Vuelo, _,DatosDelVuelo),
    horasDeVuelo(DatosDelVuelo, TiempoVuelo),
    horasDeEscala(DatosDelVuelo, TiempoEscala),
    Tiempo is TiempoVuelo + TiempoEscala.

horasDeVuelo(DatosDelVuelo, Tiempo) :-
    findall(Hora, member(tramo(Hora), DatosDelVuelo), Horas),
    sum_list(Horas, Tiempo).

horasDeEscala(DatosDelVuelo, Tiempo) :-
    findall(Hora, member(escala(_, Hora), DatosDelVuelo), Horas),
    sum_list(Horas, Tiempo).

%2. escalaAburrida/2 : Relaciona un vuelo con cada una de sus escalas aburridas; una escala es aburrida si hay que esperar mas de 3 horas.
escalaAburrida(Vuelo, Ciudad) :-
    vuelo(Vuelo, _, DatosDelVuelo),
    member(escala(Ciudad, Tiempo), DatosDelVuelo),
    Tiempo > 3.

%3. ciudadesAburridas/2 : Relaciona un vuelo con la lista de ciudades de sus escalas aburridas.
ciudadesAburridas(Vuelo, CiudadesAburridas) :-
    vuelo(Vuelo, _, DatosDelVuelo),
    findall(Ciudad, escalaAburrida(Vuelo, Ciudad), CiudadesAburridas).

%4. vueloLargo/1: Si un vuelo pasa 10 o más horas en el aire, entonces es un vuelo largo. OJO que dice "en el aire", en este punto no hay que contar las esperas en tierra. conectados/2: Relaciona 2 vuelos si tienen al menos una ciudad en común.
vueloLargo(Vuelo) :-
    vuelo(Vuelo, _, DatosDelVuelo),
    horasDeVuelo(DatosDelVuelo, HorasDeVuelo),
    HorasDeVuelo >= 10.

conectados(Vuelo, OtroVuelo) :-
    vuelo(Vuelo, _, DatosVuelo),
    vuelo(OtroVuelo, _, DatosOtroVuelo),
    Vuelo \= OtroVuelo,
    member(escala(Ciudad, _), DatosVuelo),
    member(escala(Ciudad, _), DatosOtroVuelo).

%5. bandaDeTres/3: Relaciona 3 vuelos si están conectados, el primero con el segundo, y el segundo con el tercero.
bandaDeTres(Vuelo1, Vuelo2, Vuelo3) :-
    conectados(Vuelo1, Vuelo2),
    conectados(Vuelo2, Vuelo3).

%6. distanciaEnEscalas/3: Relaciona dos ciudades que son escalas del mismo vuelo y la cantidad de escalas entre las mismas; si no hay escalas intermedias la distancia es 1. P.ej. París y Berlín están a distancia 1 (por el vuelo BLE849), Berlín y Seúl están a distancia 3 (por el mismo vuelo). No importa de qué vuelo, lo que tiene que pasar es que haya algún vuelo que tenga como escalas a ambas ciudades. Consejo: usar nth1.
distanciaEnEscalas(Ciudad, OtraCiudad, Distancia) :-
    vuelo(_, _, DatosDelVuelo),
    nth1(Inicio, DatosDelVuelo, escala(Ciudad,_)),
    nth1(Fin, DatosDelVuelo, escala(OtraCiudad, _)),
    Tramo is abs(Fin - Inicio),
    Distancia is max(1, Tramo).
    
%7. vueloLento/1: Un vuelo es lento si no es largo, y además cada escala es aburrida.
vueloLento(Vuelo) :-
    not(vueloLargo(Vuelo)),
    vuelo(Vuelo, _, DatosDelVuelo),
    forall(member(escala(Ciudad,_), DatosDelVuelo), escalaAburrida(Vuelo, Ciudad)).
    