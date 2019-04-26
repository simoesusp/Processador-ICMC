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







