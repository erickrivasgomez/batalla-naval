# PROYECTO: Juego Batalla Naval en Prolog

En este proyecto se desarrolla una versión electrónica del juego batalla naval, bajo el lenguaje de programación Prolog. 


## Comenzando 🚀

_Estas instrucciones te permitirán obtener una copia del proyecto en funcionamiento en tu máquina local para propósitos de desarrollo y pruebas._

git clone https://github.com/rivaserick/batalla-naval


### Pre-requisitos 📋

_[SWI-Prolog](http://www.swi-prolog.org/)_


### Implementación 🔧

_Ejecutar los siguientes comandos:_

Obtener los archivos

```
git clone https://github.com/rivaserick/batalla-naval
```

Entrar a la carpeta del proyecto

```
cd batalla-naval
```

### Ejecución 🔧

Ejecutar desde **CMD en Windows**

```
swipl swiBatallaNaval.pl
```

Ejecutar desde **TERMINAL en Linux**

```
swipl -s swiBatallaNaval.pl
```

Ejecutar desde **línea de comandos de SWI-Prolog**

```
?- ['swiBatallaNaval.pl'].
```

### Reglas del juego 📦

El juego inicia inmediatamente cuando el archivo es ejecutado.

* Juega usuario contra PC.
* El juego permite decidir la dimensión del tablero (cuadrado, por lo que solo se solicita un lado).
* El número de barcos es el mismo que la dimensión del tablero (lado).
* Los barcos son de dimensión 1.
* Se permite elegir si el usuario juega primero, o la PC lo hace.
* El juego termina cuando todos los barcos de un jugador son derribados.
* El juego no permite imprimir el tablero a la consola.

## Construido con 🛠️

Este proyecto fue desarrolado con:

* [Visual Studio Code](https://code.visualstudio.com/) - Editor de código

## Autores ✒️

* **Erick Rivas Gómez** - *Desarrollo y documentación* - [rivaserick](https://github.com/rivaserick)
