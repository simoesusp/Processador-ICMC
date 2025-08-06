# Instalação
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
