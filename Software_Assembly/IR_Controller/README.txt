Author:
    Marcelo Koti Kamada (marcelokkamada@gmail.com)

Contents:
    IR_Controller/
    | -> IR_controller/
    |    
    | -> modified_assembler_src/
    |
    | -> pacman/
    |
    | -> Processor_IR_PWM_DE2_70/
    |
    | -> Pictures/

IR_controller/
    Arduino source code of the IR controller. Import it using the Arduino IDE and upload it to your Arduino.

modified_assembler_src/
    Modified source code of the processor's assembler. This version supports the original instruction set and the new instruction "ir rx" to store the readings of the IR sensor into the rx register.
    Windows users can use the script "compilar_montador.bat" to compile the assembler.
    Linux users: gcc *.c -o assembler

pacman/
    | -> pacman.asm -> original game using the keyboard for input
    |
    | -> pacman_ir.asm -> modified game using the IR controller for input
    |
    | -> teste2.asm -> test code for the IR controller

Compile the .asm files to .mif files using the processor's assembler. 
    Ex: assembler pacman.asm cpuram.mif

Do not forget to replace the cpuram.mif in the Processor_IR_PWM_DE2_70 with the new one.

Processor_IR_PWM_DE2_70/
    Modified processor with instructions and hardware blocks to support the IR controller. If using Quartus, double click AP9.qsf file to open the project, compile and program the DE2_70 board to get the project running.

Pictures/
    Pictures of the project


