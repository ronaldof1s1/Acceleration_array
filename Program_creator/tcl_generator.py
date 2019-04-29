from sys import argv
def read_file(path_in):
    file_obj = open(path_in, 'r')
    lines = file_obj.readlines()
    string = exec_file(lines)
    return string

def exec_file(lines):
    string = ''
    for line in lines:
        line = line.strip('\n\r')
        if line != '' and line[0].isdigit():

            string += "add_force {/Reconfigurable_Array/bitstream} -radix bin { "+ line + " 0ns}\n"
            string += "run 1 ns\n"
        
    string += "remove_forces { {/Reconfigurable_Array/bitstream} }\n"
    string += "run 1 ns\n"
    string += "run 1 ns\n"
    
    return string

def exec(path_in):
    string = read_file(path_in)
    path_out=""
    for i in range(len(path_in)-3):
        path_out += path_in[i]
    path_out += "tcl"
    file = open(path_out, 'w+')
    file.write(string)

path = argv[1]


exec(path)