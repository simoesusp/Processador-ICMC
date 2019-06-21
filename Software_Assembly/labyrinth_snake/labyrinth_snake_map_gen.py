#!/usr/bin/python3

# This program needs to be run with python3 and imageio. 

import imageio

import pathlib
import sys

# This program will generate a text file with a string that can be pasted to be used as
# a map for labyrinth_snake running on the ICMC processor.

# The image must be RGB and have 40x30 resolution. BMP format is preferable, but the program should
# work with other formats if compression quality is high enough or if there is none.
 
# The following colors are used:

# (0,0,0) - BLACK: Empty space.
# (255,0,0) - RED: Bonus money.
# (0,255,0) - GREEN: Regular money.
# (0,0,255) - BLUE: Player spawn (there must be exactly one).
# (255,255,255) - WHITE: Wall.

# Note that the player must not be able to access the first row or the corners of the screen,
# walls shall be placed to prevent this from happening or bugs will occur.

def main():

    # Prints a message if the program was not run correctly.
    if len(sys.argv) != 2:
        print("USAGE: program-name filename")
        sys.exit(-1)
    
    # Gets the filename from the arguments used when calling the program.
    filename = sys.argv[1]

    # Gets the path to the image.
    image_path = pathlib.Path('./{}'.format(filename))

    # Verifies if the file exists.
    if not image_path.exists() or not image_path.is_file():
        print("ERROR: Input image does not exist!")
        sys.exit(-2)

    # Tries to open the image and gives an error if it fails.
    try:
        image = imageio.imread(image_path)
    except:
        print("ERROR: Failed to open input image!")
        sys.exit(-3)
    
    # Writes the correct characters to a text file, gives an error if something goes wrong.
    try:
        
        output_text = ""

        found_player = False # Used to verify if there is only one player spawn.

        # 'Translates' the image to text.
        for x in range(image.shape[0]):
            for y in range(image.shape[1]):

                if compare(image[x,y,:], [0,0,0]):
                    output_text += ' '
                elif compare(image[x,y,:], [255,0,0]):
                    output_text += '$'
                elif compare(image[x,y,:], [0,255,0]):
                    output_text += 'o'
                elif compare(image[x,y,:], [0,0,255]):
                    if not found_player:
                        output_text += '@'
                        found_player = True
                    else:
                        print("ERROR: More than one player spawn found!")
                        sys.exit(0)
                elif compare(image[x,y,:], [255,255,255]):
                    output_text += '#'
                else:
                    print("ERROR: Invalid color at pixel ({},{})!".format(x, y))
                    sys.exit(0)

        if not found_player:
            print("ERROR: No player spawn!")
            sys.exit(0)

        output = open("map.txt", "w+")
        output.write(output_text)

    except:
        print("ERROR: Failed to write output file!")
        sys.exit(-4)

    print("DONE!")

# Compares two RGB pixels, there is a tolerance for dealing with image compression.
def compare(a, b):

    try:
        for i in range(3):
            if abs(a[i] - b[i]) > 25:
                return False
    except:
        print("ERROR: Image formating error!")
        sys.exit(-5)

    return True

main()
