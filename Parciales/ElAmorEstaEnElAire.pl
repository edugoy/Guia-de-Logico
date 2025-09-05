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


perfiIncompleto(Persona) :-
    persona(Persona, Edad, _),
    Edad < 18.

perfiIncompleto(Persona) :-
    persona(Persona, _, _),
    findall(Gusto, leGusta(Persona, Gusto), Gustos),
    length(Gustos, Cantidad),
    Cantidad < 5.

perfiIncompleto(Persona) :-
    persona(Persona, _, _),
    findall(Disguto, leDisgusta(Persona, Disgusto), Disgustos),
    length(Disgustos, Cantidad),
    Cantidad < 5.

perfiIncompleto(Persona) :-
    persona(Persona, _, _),
    not(leInteresa(Persona, _)).

perfiIncompleto(Persona) :-
    persona(Persona, _, _),
    not(rangoBuscado(Persona, _, _)).

%Analisis

%Matches

%Mensajes