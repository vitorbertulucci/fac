SO:
* Linux Mint 18.1 Cinnamon 64-bit
* Ubuntu 16.04.2 LTS 64-bit

Ambiente:
* Terminal
* Vim
* Visual Studio Code

-----------------------
# MANUAL DE USO

## Questão 1

### Como compilar:

 &emsp;&emsp; Na pasta onde se encontram os arquivos, execute o seguinte código na linha de comando (terminal):

``
$ make build
``

 &emsp;&emsp; Isso vai fazer com que o programa compile todos os códigos C do arquivo e gerará um único executável, denominado `main`.

### Como utilizar:

 &emsp;&emsp; Para executar o programa, basta executar o comando no terminal:

``
$ make run
``

 &emsp;&emsp; Isso executará o programa e você poderá utilizá-lo normalmente. Seguem alguns exemplos de uso:

* Exemplo 1

Entradas: 

 &emsp;&emsp;&emsp; 1.0 0.0

 &emsp;&emsp;&emsp; 0.0 1.0

 &emsp;&emsp;&emsp; -1.0 0.0

Saídas esperadas:
	
 &emsp;&emsp;&emsp; Raio: 1.000.

 &emsp;&emsp;&emsp; Centro: (0.000, 0.000).

* Exemplo 2

Entradas: 

 &emsp;&emsp;&emsp; 0 0

 &emsp;&emsp;&emsp; 0 1

 &emsp;&emsp;&emsp; 0 -1

Saídas esperadas:

 &emsp;&emsp;&emsp; Circulo nao viavel.

* Exemplo 3

Entradas:

 &emsp;&emsp;&emsp;	2 1
 
 &emsp;&emsp;&emsp;	0 5
 
 &emsp;&emsp;&emsp;	-1 2

Saídas esperadas:

 &emsp;&emsp;&emsp;	Raio: 2.236.

 &emsp;&emsp;&emsp;	Centro: (1.000, 3.000).

### Arquivos:

#### input_output.c

* implementação do método readCoordinates(struct Points* points): método para ler as coordenadas dos 3 pontos que serão inseridos via terminal;
* implementação do método printResults(struct Circle circle): método para mostrar os resultados do cálculo do programa;

#### input_output.h

* assinatura do método readCordinates(struct Points* points): retorno do tipo void;
* assinatura do método void printResults(struct Circle circle): retorno do tipo void;

#### main.c

* função main(): utilizada para fazer o controle geral da aplicação;
* Retorno do tipo int.

#### makefile

Separado em 3 vertentes:
* build: faz a compilação de todos os arquivos interligados ao main.c e gera um executável denominado main;

``
gcc main.c -lm -o main
``

* run: utilizado para a execução do programa;

``
./main
``

* clear: utilizado para remover todos os arquivos com extensão .o e executáveis.

#### operations.c

* implementação determinant(double matrix[3][3]): método para calcular o determinante de matrizes 3x3;

* implementação isCollinear(struct Points *points): método para verificar se os 3 pontos inseridos são colineares, se o retorno for 0, a implementação não tem solução;

* implementação findCircumcenter(struct Circle* circle, struct Points* points): utilizado para encontrar o centro do círculo e seu respectivo raio.

#### operations.h

* assinatura determinant(double matrix[3][3]): retorno do tipo double;

* assinatura isCollinear(struct Points *points): retorno do tipo int;

* assinatura findCircumcenter(struct Circle* circle, struct Points* points): retorno do tipo void

#### typedefs.h

* structs: Points e Circle

-----------------------

## Questão 2

### Como compilar:

 &emsp;&emsp; Na pasta onde se encontram os arquivos, execute o seguinte código na linha de comando (terminal):

``
$ gcc questao_02.c -o nome-do-executavel
``

 &emsp;&emsp; Isso vai fazer com que o programa compile o código C do arquivo e gerará um único executável, denominado pelo `nome-do-executavel` escolhido.

### Como utilizar:

 &emsp;&emsp; Para executar o programa, basta executar o próximo comando e passar todos os parâmetros na mesma linha:

``
$ ./nome-do-executavel [parametros]
``

 &emsp;&emsp; Isso executará o programa e você poderá utilizá-lo normalmente. Seguem alguns exemplos de uso:

* Exemplo 1

Entradas: 

	./nome-do-executavel -a bababa -30 33 21

Saídas esperadas:

	# de parametros: 5
	Parametro #1: -a
	Parametro #2: bababa
	Parametro #3: -30
	Parametro #4: 33
	Parametro #5: 21

* Exemplo 2

Entradas: 

	./nome-do-executavel tito e dibre 2017 so SS

Saídas esperadas:

	# de parametros: 6
	Parametro #1: tito
	Parametro #2: e
	Parametro #3: dibre
	Parametro #4: 2017
	Parametro #5: so
	Parametro #6: SS
