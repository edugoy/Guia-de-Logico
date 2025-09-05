%Registro
% ejemplo de modelado
% persona(Nombre, Edad, Genero).
% leInteresa(Nombre, Genero).
% rangoBuscado(Nombre, Min, Max).
% leGusta(Nombre, Gusto).
% LeDisgusta(Nombre, Disgusto).

persona(maria, 27, femenino).
persona(eduardo, 21, masculino).
persona(facundo, 20, masculino).
persona(leila, 20, femenino).
persona(valentina, 20, femenino).
persona(nicolas, 20, masculno).
persona(jesus, 20, masculino).

leInteresa(maria, masculino).
leInteresa(eduardo, femenino).
leInteresa(facundo, femenino).
leInteresa(leila, masculino).
leInteresa(valentina, masculino).
leInteresa(nicolas, femenino).
leInteresa(jesus, femenino).
leInteresa(jesus, masculino).

rangoBuscado(maria, 20, 30).
rangoBuscado(eduardo, 18, 30).
rangoBuscado(facundo, 15, 25).
rangoBuscado(leila, 18, 60).
rangoBuscado(valentina, 20, 40).
rangoBuscado(nicolas, 25, 60).
rangoBuscado(jesus, 18, 80).

leGusta(eduardo, videojuegos).
leDisgusta(eduardo, estudiar).


perfilIncompleto(Persona) :-
    persona(Persona, Edad, _),
    Edad < 18.

perfilIncompleto(Persona) :-
    persona(Persona, _, _),
    findall(Gusto, leGusta(Persona, Gusto), Gustos),
    length(Gustos, Cantidad),
    Cantidad < 5.

perfilIncompleto(Persona) :-
    persona(Persona, _, _),
    findall(Disguto, leDisgusta(Persona, Disgusto), Disgustos),
    length(Disgustos, Cantidad),
    Cantidad < 5.

perfilIncompleto(Persona) :-
    persona(Persona, _, _),
    not(leInteresa(Persona, _)).

perfilIncompleto(Persona) :-
    persona(Persona, _, _),
    not(rangoBuscado(Persona, _, _)).

%Analisis
almaLibre(Persona) :-
    persona(Persona, _, _),
    not(perfilIncompleto(Persona)),
    forall(persona(_, _, Genero), leInteresa(Persona, Genero)).
    
almaLibre(Persona) :-
    persona(Persona, _, _),
    not(perfilIncompleto(Persona)),
    rangoBuscado(Persona, Min, Max),
    Rango is Max - Min,
    Rango > 30.

quiereLaHerencia(Persona) :-
    persona(Persona, Edad, _),
    not(perfilIncompleto(Persona)),
    rangoBuscado(Persona, Min, _),
    Min >= Edad + 30.

indeseable(Persona) :-
    persona(Persona, _, _),
    not(pretendiente(_, Persona)).

%Matches
pretendiente(Persona1, Persona2) :-
    persona(Persona1, _, _),
    persona(Persona2, Edad2, Genero2),
    leInteresa(Persona1, Genero2),
    rangoBuscado(Persona1, Min1, Max1),
    Edad2 >= Min1,
    Edad2 =< Max1,
    gustoEnComun(Persona1, Persona2),
    Persona1 \= Persona2.

gustoEnComun(Persona1, Persona2) :-
    leGusta(Persona1, Gusto),
    leGusta(Persona2, Gusto).

hayMatch(Persona1, Persona2) :-
    pretendiente(Persona1, Persona2),
    pretendiente(Persona2, Persona1).

%Mensajes