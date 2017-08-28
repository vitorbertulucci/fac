SO: 
 * Linux Mint 18.1 Cinnamon 64-bit
 * Ubuntu 16.04.2 LTS 64-bit

Ambiente: 
 * Terminal
 * Vim
 * Visual Studio Code

-----------------------

## Questão 1

Arquivos:

### input_output.c

* implementação readCoordinates()
  * método para ler as coordenadas dos 3 pontos que serão inseridos pelo terminal

### input_output.h

* assinatura readCordinates()
 * return: void

### main.c

* função main()
 * 

### makefile

* build:

´´ 
gcc main.c -lm -o main
´´

* run:

´´
./main
´´

### operations.c

* implementação determinant()
  * método para calcular o determinante de matrizes 3x3

* implementação isCollinear()
  * método para verificar se os 3 pontos inseridos são colineares

* implementação findCircumcenter()
  * 

### operations.h 

* assinatura determinant()
  * return: double

* assinatura isCollinear()
  * return: int

* assinatura findCircumcenter()
  * return: void

### typedefs.h

* structs: Points e Circle

-----------------------

## Questão 2

Arquivos:

###