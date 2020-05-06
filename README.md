# ICMC-Processor
Development of a complete environment to teach and learn computer architecture, VHDL processor design and Assembly language

This project consists of the development of a complete environment to teach and learn computer architecture, VHDL processor design and Assembly language.

The proposed ICMC-Processor was designed to be simple, efficient, and easy to teach and understand. It was proposed as the main project for Computer Organization classes at the ICMC-University of Sao Paulo, in Sao Carlos, Sao Paulo state, Brazil.

This project consists of five parts:

1-	FPGA processor design (Altera VHDL project for Cyclone II DE2-70 board)

2-	Assembler software (to generate binary code for the ICMC-Processor implemented on FPGA)

3-	Simulator software (to simulate the execution of code on the ICMC-Processor)

4-	Compiler software (to compile a reduced set of  C language commands)

5-	Documentation (Processor architecture and Assembly language description)

## Aulas a Distância

- Aula01 - https://drive.google.com/file/d/1ucFPXroi7lXQq5qj4DN_a59JgJtiMLZR/view?usp=sharing

- Aula02 - https://drive.google.com/file/d/1okiL76FewUbyGMTcjNSI0Xhy0rsizia2/view?usp=sharing

- Aula03 17/04/20 - Parte1: https://drive.google.com/file/d/1JugSodvm6wiZIyiCYXl-gaDbAdB2Yd1P/view?usp=sharing - 
Parte2: https://drive.google.com/file/d/15Olmivl_6dFfzbz0j2-lQUj2PCYKGOXX/view?usp=sharing

- Aula04 24/0420 - https://drive.google.com/file/d/1UgvGZ4suo8emRTWnyZTSAoGBYFHCAPB-/view?usp=sharing


# Projetos dos Alunos 2020

- Processador do Breno Cunha Queiroz: https://github.com/Brenocq/MyMachine

- RNAssembly: Anderson Cardoso Gonçalves - https://github.com/ansoncg/RNAssembly_LabOrgComp

- TODOS OS ALUNOS PRECISAM APRESENTAR O TRABALHO PESSOALMENTE!! 

# Projetos dos Alunos 2019

- COMO FAZER: Incluir no seu GIT: CPU.VHD e JOGO.ASM e o CPURAM.MIF, e caso tenha alterado, o CHARMAP.MIF. Se possível, incluir um video mostrando o jogo funcionando e explicando tudo. (Upa no Youtube e poe um link no teu Github). Dai' Forca a pagina da disciplina (esta página!!) no teu git, edita o READ.ME e Comita. Depois faz um Pull Request No git original da disciplina. Veja o video: 

[![FELIZ WAS HERE](http://img.youtube.com/vi/0vT8zuG9CYM/0.jpg)](http://www.youtube.com/watch?v=0vT8zuG9CYM)


- Jogo da chuva de letras: Felipe Guilermmo Santuche Moleiro - https://github.com/FelipeMoleiro/ProjetoLabOrgArqComp

- Rex Scape: Caio Augusto Duarte Basso, Gabriel Garcia Lorencetti, Giovana Daniele da Silva, Luana Balador Belisario - https://github.com/gabrielgarcia7/game-rexscape

- Space Laser: Gustavo Vinicius Vieira Silva Soares - https://github.com/gsoares1928/ProjLabOrgArq

- Labyrinth Snake: Julia Carolina Frare Peixoto, Luís Eduardo Rozante de Freitas Pereira, Maurílio da Motta Meireles - https://github.com/LuisEduardoR/Processador-ICMC

- Snake: Gabriel Mattheus Bezerra Alves de Carvalho, Wallace Cruz de Souza - https://github.com/GabrielBCarvalho/Snake-Assembly

- Pencil: Marcelo Isaias de Moraes Junior - https://github.com/MarceloMoraesJr/JogoOrgComp

- Battle of Tiers: Jonas Wendel Costa de Souza - https://github.com/4Vertrigo/BattleOfTiers

- Bandersnack - A Dora's Text Adventure: Igor Lovatto Resende, Lucas Mateus M. A. Castro, Marcelo Temoteo de Castro - https://github.com/Beadurof/dora-machineworks

- Tic-Tac-Toe-Assembly-ICMC: NOMES: Guilherme Holanda Sanches, Lucas Henrique Rodrigues, João Vitor VIllaça - https://github.com/holondo/Tic-Tac-Toe-Assembly-ICMC


# Configuração da Placa DE0:

1- Configure o Clock para 1MHz: SW[2] = 1; SW[1]=1; SW[0]=0

2- Selecione o clock AUTOMATICO => sw[8] = 0

3- Agora e' so' programar a placa do Quartus

4- Para clock MANUAL => SW[8]=1  e  mudar a SW[9] para dar o clock no circuito

# Configuração da Placa DE115:

1- Configure o Clock para 1MHz: SW[6] = 1   e TODAS as outras para 0 (Para outros Clocks, tentar subir uma por uma (e apenas uma!) das SW[0]=1Hz, SW[1]=10Hz  ate' SW[6]=1MHz)

2- Selecione o clock AUTOMATICO => sw[16] = 1

3- Agora e' so' programar a placa do Quartus

4- Para clock MANUAL => SW[16]=1  e  mudar a SW[17] para dar o clock no circuito

# Para gerar o PROGRAMA:

1- Escreva o programa NORMALMENTE no Sublime (nome.ASM)

2- F7 para montar o arquivo binario (nome.MIF) e Simular (pra ver se Funciona, ANTES de esperar 20min no Quartus!!)

3- Mude o NOME do arquivo nome.MIF para CPURAM.MIF

4- Copie CPURAM.MIF para a pasta do Projeto no Quartus

5- Compile o projeto no Quartus

6- Programe a Placa e REZE!!!!

7- Troque o  input do Monitor para entrada VGA (tu vai sofrer nos menuzinhos da Philipis!!!)






