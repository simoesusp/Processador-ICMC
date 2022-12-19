# Instalação de extensões de syntax highlighting para o assembly do processador
## Sublime
1) Descubra onde é o diretório de configuração do seu sublime. Normalmente ele se encontra no .config da sua Home:
		```~/.config/sublime-text-3/```
	- Dentro deste diretório existe uma subdiretório chamado Packages. Copie os 2 arquivos contidos aqui para lá.
		cp icmc.tmLanguage icmc_processor.sublime-build ~/.config/sublime-text-3/Packages/
	(Substitua o diretório especificamente para o da sua máquina).
	
	- Copie o arquivo " buildandrun " para a pasta /user/bin 

	- Copie os arquivos sim e montador  para a pasta /user/bin 

2) Montando seu programa:
	- Com o Sublime Text aberto no seu arquivo .asm, dê um Ctrl + B

3) Simulando seu programa:
	- Dê um F7 ou Ctrl + Shift + B
## Vim e Neovim
- Colocar em ~ /.config/vim/syntax/ (ou o equivalente ~/.config/nvim/syntax para neovim). Se a path não existir, simplesmente crie os diretórios necessários.
- Quando abrir o arquivo digitar ":set syntax=icmc"

## VSCode e VSCodium
Existem duas maneiras de instalar as extensões de VSCode/VSCodium:
- Clonar o repositório em github.com/gabriel-libardi/icmc-assembly e seguir as instruções de instalação disponíveis no README do repositório.
- Baixar diretamente da Microsoft store no link: [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=Libardi120205.icmc-assembly)

## Contribua!
Façam um fork do repositório da extensão (ou do repositório do processador) para
melhorar as extensões disponíveis. Elas são muito importantes para o desenvolvimento
de programas no assembly do processador.