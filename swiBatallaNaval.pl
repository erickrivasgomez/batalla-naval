#!/usr/bin/env swipl swiBatallaNaval.pl

/*
Juego BATALLA NAVAL en SWI-prolog
Erick Rivas Gómez
Programación Lógica y Funcional
Ingeniería en Sistemas Computacionales
Instituto Tecnológico de Morelia
2019

Ejecución en Windows y Linux:

ruta\archivo> swipl swiBatallaNaval.pl
ruta\archivo# swipl -s swiBatallaNaval.pl

Ejecución en SWI-Prolog (desde la ruta del archivo):
?- ['swiBatallaNaval.pl'].

*/


:- dynamic barco/2.
:- dynamic barco_pc/2.

mensaje_de_bienvenida() :-
  write('Erick Rivas Gomez - 2019'),nl,
  write('##################################################################'),nl,
  write('#######                  JUEGO BATALLA NAVAL               #######'),nl,
  write('#############                Bienvenidos           ###############'),nl,
  write('##################################################################'),nl.

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
  write('####################################################'),nl,
  write(' TURNO DE USUARIO'),nl,
  nl,leer_numero('Ingresa la fila a donde quieres disparar', X),
  nl,leer_numero('Ingresa la columna de disparo', Y),nl,nl,
  (
    barco_pc(X, Y) ->
      retract(barco_pc(X, Y)),
      write('Le diste al barco de PC'),
      (
        barco_pc(_, _) ->
          nl;
          write('¡Ganaste!'), nl, halt
      );
      write('Sigue intentando, usuario'), nl, nl
  ).

dispara_pc() :-
  write('####################################################'),nl,
  write('                                         TURNO DE PC'),nl,
  write('                                           '),
  dimension(D),random(0, D, U), write(U), write(', '),
  dimension(D),random(0, D, V), write(V), nl,
  (
    barco(U, V) ->
      retract(barco(U, V)),
      write('                                           ¡Disparaste al barco del usuario!'),
      nl,
      (
        barco(_, _) ->
          nl;
          write('                                           ¡Ganaste PC!'),
          nl, halt
      );
      write('                                           Sigue intentando, PC'),
      nl, nl
  ).

juego(0).
juego(N, QuienPrimero) :-
  N>0,
  write(N),nl,

  (QuienPrimero == 1 ->
    dispara_usuario(),
    dispara_pc();
    dispara_pc(),
    dispara_usuario()
  ),
  nl,

  %M is N-1,
  juego(N, QuienPrimero).

barco_para_usuario() :-
  write('Coordenada X para barco: '),
  read(CoordX),
  write('Coordenada Y para barco: '),
  read(CoordY),nl,
  assert(barco(CoordX,CoordY)).

barco_para_pc() :-
  dimension(D),
  random(0, D, CoordXpc),
  %write('                                           '),
  %write(CoordXpc),  // Descomentar estas 3 lineas para poder ver las coordenadas
  %write(', '),      // de los barcos de PC
  random(0, D, CoordYpc),
  %write(CoordYpc),
  (
    barco_pc(CoordXpc, CoordYpc) ->
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
  mensaje_de_bienvenida(),
  nl,
  dimension_tablero('Dimension del tablero:', DimensionTablero), 
  nl, write('Barcos: '), write(DimensionTablero),nl,
  numero_barcos('Barcos:', DimensionTablero),nl,
  leer_numero('Primer turno para: Usuario(1), PC(Cualquier numero)', QuienPrimero),
  %AciertosUsuario is 0;
  %AciertosPC is 0;
  juego(DimensionTablero, QuienPrimero).
  main.
