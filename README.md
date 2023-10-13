# Projeto 1 - ALU

**NOTE**<br>
Este código foi testado apenas em um ambiente com um <em>ISE 14.7</em> em um Windows 10. Isso foi possível pois a instalação do programa se deu em uma **Máquina Virtual** utilizando o Oracle Virtual Box. Pesquise sobre como fazer isso no windows para que você possa usufuir da ferramenta neste sistema operacional.

## Sistemas Digitais - 2023/2 - EEL480 - UFRJ

Este repositório contém arquivos .vhd com a especificação de circuitos lógicos digitais que compõem uma <em>Unidade Lógica Aritmética</em> [(ALU)](https://pt.wikipedia.org/wiki/Unidade_l%C3%B3gica_e_aritm%C3%A9tica).

## Como percorrer pelos códigos

A ALU possui, até agora, apenas 5 operações das 8 que precisa (são especificações do trabalho) até o dia em que foi feito o último commit. As operações são:

- Somador (obrigatória)
- Subtrator (obrigatória)
- Incremento (obrigatória)
- Troca de Sinal (obrigatória)
- Decremento (nova sugerida)
- TODO
- TODO
- TODO

O arquivo <em>test_alu.vhd</em> serve para testarmos as saídas da ALU com entradas definidas de uma maneira mais prática que aquela forçando valores.

O arquivo <em>somador_subtrator.vhd</em>, como diz o nome, possui o módulo somador e subtrator juntos e opera com um <em>[Carry Lookahead](https://en.wikipedia.org/wiki/Carry-lookahead_adder)</em> com números binários em [Complemento de Dois](https://pt.wikipedia.org/wiki/Complemento_para_dois).

O arquivo <em>complete.vhd</em> é a ALU em si (completa). Fazendo o uso de PORT MAP, foi possível "importar" outros módulos VHDL fazendo, sempre que possível, reúso de código.

Os demais arquivos possuem os nomes das suas respectivas funcionalidades.