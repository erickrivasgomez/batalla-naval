#!/usr/bin/env swipl batallaNaval.pl

:- dynamic barco/2.
:- dynamic barco_pc/2.

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
  assert(barcos(Numero)),
  colocar_barcos(Numero).

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

dispara_usuario() :-
  nl,leer_numero('Ingresa la fila a donde quieres disparar', X),
  nl,leer_numero('Ingresa la columna de disparo', Y),
  (
    barco_pc(X, Y) ->
    write('¡Ganaste!'), nl, nl, halt;
    write('Sigue intentando...'), nl, nl
  ).

dispara_pc() :-
  dimension(D),random(0, D, U), write(U), write(', '),
  dimension(D),random(0, D, V), write(V), nl,
  (
    barco(U, V) ->
    write('                                           ¡Ganaste PC!'),
    nl, nl, halt;
    write('                                           Sigue intentando... PC'),
    nl, nl
  ).

juego(0, QuienPrimero).
juego(N, QuienPrimero) :-
  N>0,
  write(N),nl,

  (QuienPrimero == 1 ->
    dispara_usuario(),
    dispara_pc();
    dispara_pc(),
    dispara_usuario()
  ),

  M is N-1,
  juego(M, QuienPrimero).

barco_para_usuario() :-
  write('Coordenada X para barco: '),
  read(CoordX),
  write('Coordenada Y para barco: '),
  read(CoordY),nl,
  assert(barco(CoordX,CoordY)).

barco_para_pc() :-
  dimension(D),
  random(0, D, CoordXpc),
  write('                                           '),
  write(CoordXpc),
  write(', '),
  random(0, D, CoordYpc),
  write(CoordYpc),nl,
  (
    barco_pc(CoordXpc, CoordYpc) ->
      write('                                        Barco repetido'),nl,
      barco_para_pc();
      assert(barco_pc(CoordXpc, CoordYpc))
  ).

colocar_barcos(0).
colocar_barcos(N) :-
  N>0,nl,
  write(N),nl,

  barco_para_usuario(),
  barco_para_pc(),

  M is N-1,
  colocar_barcos(M).

:- initialization(main).

main :-

  nl,nl,
  dimension_tablero('Dimension del tablero:', DimensionTablero), 
  nl, nl, write('Barcos: '), write(DimensionTablero),nl,
  numero_barcos('Barcos:', DimensionTablero),nl,nl,
  leer_numero('Primer turno para: Usuario(1), PC(Cualquier numero)', QuienPrimero),
  juego(3, QuienPrimero).
  main.
