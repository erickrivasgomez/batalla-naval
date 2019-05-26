#!/usr/bin/env gprolog --consult-file batallaNaval.pl

% Simplest possible battleship game:
%   - single player
%   - one ship, hardcoded at position row 2, col 1
%   - loop endlessly until you hit the ship

board([[1, 1],
       [1, 0]]).

row_at(X, Row) :-
  board(Board),
  nth(X, Board, Row).

column_at(Y, Row, Cell) :-
  nth(Y, Row, Cell).

ship_at(X, Y) :-
  row_at(X, Row),
  column_at(Y, Row, Cell),
  Cell = 1.

fire_at(X, Y, State) :-
  (ship_at(X, Y) ->
    nl, write('¡Buen disparo!'), nl;
    nl, write('Dispara de nuevo'), nl).

prompt_number(Prompt, Number) :-
  write(Prompt),
  write(': '),
  read_integer(Number).

:- initialization(main).
main :-
  repeat,
  board(X,Y),
  nl,prompt_number('Ingresa la fila a donde quieres disparar', X),
  nl,prompt_number('Ingresa la columna de disparo', Y),
  fire_at(X, Y, State),
  (ship_at(X, Y) ->

    write('¡Ganaste!'), nl, nl, halt ;
    write('Sigue intentando...'), nl, nl, fail).
