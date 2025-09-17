# Nova versao do Procesador ICMC com 12MHz e Tela RGB
- Nesta versão mudamos o clock máximo de 1MHz para 12MHz e a Tela de 16 cores do DOS para RGB

## Novo padrão de Cores:

- Um charactere é defindo por 16 bits:
  - Bits 7-0 => Codigo ASCII do Charactere
  - Bits 9-8 => Blue (4 niveis)
  - Bits 12-10 => Green (8 niveis)
  - Bits 15-13 => Red (8 niveis)

### Exemplo de como formar uma cor:
- O cóigo da Letra 'A' na tabela ASCII é 65.
- Se somarmos 65 + cor ==> Teremos um A colorido para imprimir com OUTCHAR

### Por Exemplo: 
- cor =  R(3b)G(3b)B(2b) + Char(8b) 00000011 00000000 => #768 => azul!
  - 65 + 768 = 833 ==> Letra A na cor azul.
	
- cor = R(3b)G(3b)B(2b) + Char(8b) 00011100 00000000 => #7168 => verde!

- cor = R(3b)G(3b)B(2b) + Char(8b) 11111100 00000000 => #64512 => amarelo!

- cor = R(3b)G(3b)B(2b) + Char(8b) 11100000 00000000 => #57344 => vermelho!


# Instalação (como instalar o Quartus no LINUX - Testado no FEDORA)
Baixar Quartus Prime Lite em https://www.intel.com/content/www/us/en/collections/products/fpga/software/downloads.html

Após terminar o download, execute os seguintes comandos, substituindo `<ARQUIVO>` pelo nome do arquivo baixado:

```sh
chmod +x <ARQUIVO>.run
./<ARQUIVO>.run
```

O instalador vai abrir uma janela de instalação. Garanta que a opção "Cyclone V" esteja selecionada.

Após a instalação, criar o arquivo `/etc/udev/rules.d/51-usbblaster.rules` com o seguinte conteúdo:

```
# Intel FPGA Download Cable
SUBSYSTEMS=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6001", MODE="0666"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6002", MODE="0666"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6003", MODE="0666"

# Intel FPGA Download Cable II
SUBSYSTEMS=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6010", MODE="0666"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6810", MODE="0666"
```

Reinicie o sistema para que as regras do udev entrem em vigor.

# Observação
**Conecte a FPGA ao computador por porta USB 2.0. USB 3.0 NÃO FUNCIONAM.**
