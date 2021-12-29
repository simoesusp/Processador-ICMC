# Use a ULTIMA versao do nosso montador: Montador_Ultimo_Beta_64Kb
- Essa versao monta um arquivo de memoria (*.mif) com 64Kb... 
- Os Montadores antigos montavam arquivos com 32Kb, porque as FPGAs antigas do Lab nao suportavam 64Kb.



## Para fazer tudo Funcionar no SUBLIME:
- Tem que mudar o arquivo buildandrun na pasta /usr/bin
  - Pois as versoes antigas precisavam de um segundo argumento no montador com o nome do arquivo.MIF (/usr/bin/montador "$1" "$2" && /usr/bin/sim "$2" "$3")
  - E essa nova versao nao precisa!  (/usr/bin/montador "$1" && /usr/bin/sim "$2" "$3")

- Criar arquivo " buildandrun " na pasta /usr/bin   com o seguinte:
#!/bin/bash
/usr/bin/montador "$1" && /usr/bin/sim "$2" "$3"

x----------------------x-----------------x----------
PARA INSTALAR O SUBLIME (UBUNTU 18):

Add repository:
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

Ensure apt is set up to work with https sources:
sudo apt-get install apt-transport-https

Select the channel to use:
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

Update apt sources and install Sublime Text
sudo apt-get update
sudo apt-get install sublime-text

x----------------------x-----------------x----------
Configure o Sublime para o Assembly do Processador ICMC:

Copiar arquivos:
icmc_processor.sublime-build
icmc.tmLanguage
De: https://github.com/simoesusp/Processador-ICMC/blob/master/Text_Editors_Sintaxe/Sublime_Sintaxe_F7.tar
Para: /home/simoes/.config/sublime-text-3/Packages

icmc_processor.sublime-build ==> 
{
	"selector": "source.ICMC" ,
	"working_dir": "${project_path:${folder}}",
	"variants": [
		{ 
		  "cmd": ["/usr/bin/montador", "$file_base_name.asm", "$file_base_name.mif"],
		  "name": "Build",
		},
		{
		  "cmd": ["/usr/bin/buildandrun", "$file_base_name.asm", "$file_base_name.mif", "charmap.mif"],
		  "name": "Run",
		}
	]
}

Criar arquivo " buildandrun " na pasta /user/bin   com o seguinte:
#!/bin/bash
/usr/bin/montador "$1" && /usr/bin/sim "$2" "$3"

Obs.: 	&&  faz rodar as duas linhas, mas so'  se a primeira rodar!
		$1  ... $3  Sao os argumentos passados

COPIAR: montador, sim, buildandrun    para a pasta /usr/bin/
	--> Nao esqueca de verificar se tem permissao de EXECUTAR cada um dos tres programas:
ls -l  montador     --> Mostra as permissoes!
-rw-r--r-- 1 root root 48147 mai 25 08:42 montador    
	--> Da pra ver que nao tem permissao de executar [x]

sudo chmod +x /montador
ls -l  montador
-rwxr-xr-x 1 root root 48147 mai 25 08:42 /bin/montador
	--> Agora incluiu o [x]

sudo chmod +x /sim
sudo chmod +x /buildandrun 


Cuidado:  o charmap.mif tem que estar na mesma pasta do ASM

No Sublime vai colorir a sintaxe e pra montar e simular:
Shift+Ctrl+B  -->  Builda do asm -> mif
F7 --> Save + Build and Run (simula) 





X------------------X-------------------X
