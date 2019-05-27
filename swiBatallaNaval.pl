#!/usr/bin/env swipl batallaNaval.pl

%barco_pc(100, 100).
%barco(100, 100).
%dimension(100).

%retract(barco_pc(100,100)).
%retract(barco(100,100)).

barco_en_x(X, Row) :-
  tablero(Tablero),
  nth0(X, Tablero, Row).

barco_en_y(Y, Row, Barco) :-
  nth0(Y, Row, Barco).

barco_encontrado(X, Y) :-
  barco_en_x(X, Row),
  barco_en_y(Y, Row, Barco),
  Barco = 1.

disparar(X, Y, State) :-
  (barco_encontrado(X, Y) ->
    nl, write('¡Buen disparo!'), nl;
    nl, write('Dispara de nuevo'), nl
  ).

barco_PC_x(U, Row) :-
  tableroJugador(Tablero),
  nth0(U, Tablero, Row).

barco_PC_y(V, Row, Barco) :-
  nth0(V, Row, Barco).

barco_encontrado_por_PC(U, V) :-
  barco_PC_x(U, Row),
  barco_PC_y(V, Row, Barco),
  Barco = 1.

pc_dispara(U, V, State2) :-
  (barco_encontrado_por_PC(U, V) ->
    nl, write('¡Buen disparo PC!'), nl;
    nl, write('Dispara de nuevo PC'), nl
  ).

leer_numero(Mensaje, Numero) :-
  write(Mensaje),
  write(': '),
  read(Numero).

dimension_tablero(Mensaje, Numero) :-
  write(Mensaje),
  write(': '),
  read(Numero),
  assert(dimension(Numero)),
  %retract(dimension(100)),
  nl,
  write('Dimension: '),
  write(Numero),nl.

numero_barcos(Mensaje, Numero) :-
  write(Mensaje),
  write(': '),
  read(Numero),
  assert(barcos(Numero)),
  colocar_barcos(Numero);

set_barcos(0).
set_barcos(N) :- 
  N>0,
  colocar_barco(),
  %colocar_barco_pc(),
  nl,
  M is N-1,
  set_barcos(M).

colocar_barco() :-
  write('Coordenada X para barco: '),
  read(CoordX),
  write('Coordenada Y para barco: '),
  read(CoordY),
  assert(barco(CoordX,CoordY)),
  dimension(D),
  write(D),
  random(0, D, CoordXpc),
  write(CoordXpc),
  write(', '),
  random(0, D, CoordYpc),
  assert(barco_pc(CoordXpc, CoordYpc)),
  write(CoordYpc),
  nl.

%colocar_barco_pc() :-

pertenece(X,[X|_]).
pertenece(X,[_|R]):- pertenece(X,R).

juego(0).
juego(N) :-
  N>0,
  write(N),nl,
  
  nl,leer_numero('Ingresa la fila a donde quieres disparar', X),
  nl,leer_numero('Ingresa la columna de disparo', Y),
  %disparar(X, Y, State),
  (
    barco_pc(X, Y) ->
    write('¡Ganaste!'), nl, nl, halt;
    write('Sigue intentando...'), nl, nl
  ),
    
  dimension(D),random(0, D, U), write(U), write(', '),
  dimension(D),random(0, D, V), write(V), nl,
  %pc_dispara(U, V, State2),
  (
    barco(U, V) ->
    write('¡Ganaste PC!'), nl, nl, halt;
    write('Sigue intentando... PC'), nl, nl
  ),

  M is N-1,
  juego(M).

colocar_barcos(0).
colocar_barcos(N) :-
  N>0,
  write(N),nl,
  
  write('Coordenada X para barco: '),
  read(CoordX),
  write('Coordenada Y para barco: '),
  read(CoordY),
  assert(barco(CoordX,CoordY)),

  dimension(D),
  write(D),
  random(0, D, CoordXpc),
  write(CoordXpc),
  write(', '),
  random(0, D, CoordYpc),
  write(CoordYpc),
  assert(barco_pc(CoordXpc, CoordYpc)),

  M is N-1,
  colocar_barcos(M).


:- initialization(main).

main :-

  nl,nl,
  dimension_tablero('Dimension del tablero:', DimensionTablero), 
  nl, nl,
  numero_barcos('Barcos: <= 5', B),
  write('Antes de juego'),
  juego(3).
  main.
