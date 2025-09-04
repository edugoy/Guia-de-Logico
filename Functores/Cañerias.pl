%tipo de cañerias [codos, caños, canillas]
%de los codos importa el color [Ej: codo rojo]
%de los caños importa el color y la longitud [Ej: caño rojo de 3 metros]
%de las canillas tipo (para abrir o cerrar) color y ancho [Ej: canilla triangular roja de 4cm de ancho]

%base de conocimiento
%Forma en la que se modelaria
%   canierias(Color, tipo(Codo)).
%   canierias(Color, tipo(Canio, Longitud)).
%   canierias(Color, tipo(Canilla, Tipo, Ancho)).
%Ejemplos del modelado
canierias(rojo, tipo(codo)).
canierias(rojo, tipo(canio, 3)).
canierias(rojo, tipo(canilla, triangular, 4)).

%1. Definir un predicado que relacione una cañería con su precio. Una cañería es una lista de piezas. Los precios son:
%    a) codos: $5.
%    b) caños: $3 el metro.
%    c) canillas: las triangulares $20, del resto $12 hasta 5 cm de ancho, $15 si son de más de 5 cm.


%2. Definir el predicado puedoEnchufar/2, tal que puedoEnchufar(P1,P2) se verifique si puedo enchufar P1 a la izquierda de P2. Puedo enchufar dos piezas si son del mismo color, o si son de colores enchufables. Las piezas azules pueden enchufarse a la izquierda de las rojas, y las rojas pueden enchufarse a la izquierda de las negras. Las azules no se pueden enchufar a la izquierda de las negras, tiene que haber una roja en el medio. P.ej.
%   a) sí puedo enchufar (codo rojo, caño negro de 3 m).
%   b) sí puedo enchufar (codo rojo, caño rojo de 3 m) (mismo color).
%   c) no puedo enchufar (caño negro de 3 m, codo rojo) (el rojo tiene que estar a la izquierda del negro).
%   d) no puedo enchufar (codo azul, caño negro de 3 m) (tiene que haber uno rojo en el medio).


%3. Modificar el predicado puedoEnchufar/2 de forma tal que pueda preguntar por elementos sueltos o por cañerías ya armadas. 
% P.ej. una cañería (codo azul, canilla roja) la puedo enchufar a la izquierda de un codo rojo (o negro), y a la derecha de un caño azul. Ayuda: si tengo una cañería a la izquierda, ¿qué color tengo que mirar? Idem si tengo una cañería a la derecha.


%4. Definir un predicado canieriaBienArmada/1, que nos indique si una cañería está bien armada o no. Una cañería está bien armada si a cada elemento lo puedo enchufar al inmediato siguiente, de acuerdo a lo indicado al definir el predicado puedoEnchufar/2.


%5. Modificar el predicado puedoEnchufar/2 para tener en cuenta los extremos, que son piezas que se agregan a las posibilidades. De los extremos me interesa de qué punta son (izquierdo o derecho), y el color, p.ej. un extremo izquierdo rojo. Un extremo derecho no puede estar a la izquierda de nada, mientras que un extremo izquierdo no puede estar a la derecha de nada. Verificar que canieriaBienArmada/1 sigue funcionando. 
% Ayuda: resolverlo primero sin listas, y después agregar las listas. Lo de las listas sale en forma análoga a lo que ya hicieron, ¿en qué me tengo que fijar para una lista si la pongo a la izquierda o a la derecha?. 


%6. Modificar el predicado canieriaBienArmada/1 para que acepte cañerías formadas por elementos y/u otras cañerías. P.ej. una cañería así: codo azul, [codo rojo, codo negro], codo negro  se considera bien armada.


%7. Armar las cañerías legales posibles a partir de un conjunto de piezas (si tengo dos veces la misma pieza, la pongo dos veces, p.ej. [codo rojo, codo rojo] )
