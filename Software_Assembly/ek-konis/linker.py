import os
import sys

"""
Scans a file recursivily for ;#Includes lib
and resolves depedencies
"""

libsPath = "libs/"

def CutUnmarkedRegions(filepath):
    keywordLibStart = ";START OF LIB"
    keywordLibEnd = ";END OF LIB"
    keywordInclude = ";#Include" # We need to keep these!
    
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            linhas = f.readlines()
        
        output = []
        in_lib_zone = False

        for linha in linhas:
            # Always keep include lines, no matter where they are
            if keywordInclude in linha:
                output.append(linha)
                continue
            
            # Standard guard logic
            if keywordLibStart in linha:
                in_lib_zone = True
                continue # Skip the actual ";START OF LIB" line
            if keywordLibEnd in linha:
                in_lib_zone = False
                break # Stop processing once the lib ends
            
            if in_lib_zone:
                output.append(linha)
        
        return output
    except Exception as e:
        return [f"; Erro ao processar {filepath}: {e}\n"]
def StitchFiles(main_file, output_path):
    keyword = ";#Include"
    included_files = set() 
    
    included_files.add(os.path.basename(main_file))

    with open(main_file, 'r', encoding='utf-8') as f:
        file_buffer = f.readlines()

    finished = False
    while not finished:
        found_include = False
        
        for i, linha in enumerate(file_buffer):
            if keyword in linha:
                target = linha.split(' ')[1].strip()
                
                # Check if we have already included this specific library
                if target in included_files:
                    # Replace the include line with a warning comment instead of the code
                    file_buffer[i] = f"; --- SKIP DUPLICATE INCLUDE: {target} ---\n"
                    found_include = True
                    break 

                lib_path = os.path.join(libsPath, target)
                
                # Mark as seen
                included_files.add(target)
                
                lib_code = CutUnmarkedRegions(lib_path)
                
                replacement = [
                    f"; --- BEGIN INCLUDE: {target} ---\n",
                    *lib_code,
                    f"; --- END INCLUDE: {target} ---\n"
                ]
                
                file_buffer[i:i+1] = replacement
                found_include = True
                break
        
        if not found_include:
            finished = True

    with open(output_path, 'w', encoding='utf-8') as f:
        f.writelines(file_buffer)    

def main():

    "Check for arguments"
    if len(sys.argv)  <= 2:
        sys.exit("Plese Specify an input and output file")
    if len(sys.argv) > 3:
        sys.exit("Too many args")

    file = sys.argv[1]
    outputfile = sys.argv[2]

    StitchFiles(file, outputfile)

    return 0

main()

