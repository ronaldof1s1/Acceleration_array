def read_file(path):
    file_obj = open(path, 'r')
    lines = file_obj.readlines()


class array_level():


    write_ALUs = [["","",""],
                    ["","",""]]
    read_ALUs = [[("",""),("",""),("","")],
                [("",""),("",""),("","")]]

    write_mult = ["",]
    read_mult = [("","")]

    write_memory = ["",]


    def get_operation_code(op_string):
        op_string = op_string.upper()
        if op_string == 'ADD':
            return '000'
        elif op_string == 'SUB':
            return '001'
        elif op_string == 'AND':
            return '010'
        elif op_string == 'OR':
            return '011'
        elif op_string == 'XOR':
            return '100'
        else:
            raise Exception

    def register_in_mult(register):
        for mult in write_mult:
            if mult == dependant:
                return True

        return False

    def register_in_memory(register):
        for mem in write_memory:
            if mem == dependant:
                return True

        return False

    def register_in_ALUs(register):
        for line in write_ALUs:
            for alu in line:
                if alu == register
                    return True
        
        return Falses

    def check_ALU_available(dependant):   
        if register_in_memory(dependant) or register_in_mult(dependant):
            return (-1,-1)
        
    
        for row in write_ALUs:
            for col in write_ALUs:
                if write_ALUs[row][col] == dependant:
                    break
                elif write_ALUs[row][col] == '':
                    return (row,col)
                    break

        return (-1,-1)

    def set_alus(words):
        (row, col) = check_ALU_available(words[1])
        if row == -1:
            return False

        write_ALUs[row][col] = words[1]
        read_ALUs[row][col] = (words[2], words[3])

        return True

    def check_mult_available(dependant):
        if register_in_ALUs(dependant) or register_in_memory(dependant):
            return -1

        for i in range(write_mult.len):
            if write_mult[i] == "":
                return i
        return -1   

    def set_mult(words):
        mult = check_mult_available(words[1])
        if mult == -1:
            return False

        write_mult[mult] = words[1]
        read_mult[mult] = (words[2], words[3])
        return True

    def check_memory_available(dependant):
        if register_in_ALUs(dependant) or register_in_mult(dependant):
            return -1

        for i in range(write_memory.len):
            if write_memory[i] == '':
                return i

        return -1

    def set_memory(words):
        mem = check_memory_available(words[1])
        if mem == -1:
            return False

        write_memory[mem] = words[1]
        return True

def prepare_line(line):
    words = line.split()
    operation = words[0].upper()

    if operation == 'MULT':

