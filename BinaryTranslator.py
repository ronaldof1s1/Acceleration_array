def read_file(path):
    file_obj = open(path, 'r')
    lines = file_obj.readlines()


class array_level():

    def __init__(self, alus_per_row, rows_of_alus, multipliers, memory):
        self.write_ALUs = []
        self.read_ALUs = []
        for i in range(rows_of_alus):
            alu_line = []
            
            for i in range(alus_per_row):
                write_alu_line.append("")
                read_alu_line.append(("",""))
                
            self.write_ALUs.append(write_alu_line)
            self.read_ALUs.append(read_alu_line)
            
       self.write_mult = []
    
        for i in range(multipliers):
            self.write_mult.append("")
            self.read_mult.append(("", ""))
        
        for i in range(memory):
            self.write_memory.append("")

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

    def register_in_mult(self, register):
        for mult in self.write_mult:
            if mult == dependant:
                return True

        return False

    def register_in_memory(self, register):
        for mem in self.write_memory:
            if mem == dependant:
                return True

        return False

    def register_in_ALUs(self, register):
        for line in self.write_ALUs:
            for alu in line:
                if alu == register:
                    return True
        
        return Falses

    def check_ALU_available(self, dependant):   
        if self.register_in_memory(dependant) or self.register_in_mult(dependant):
            return (-1,-1)
        
    
        for row in range(len(self.write_ALUs)):
            for col in range(len(self.write_ALUs[0])):
                if self.write_ALUs[row][col] == dependant:
                    break
                elif self.write_ALUs[row][col] == '':
                    return (row,col)
                    break

        return (-1,-1)

    def set_alus(self, words):
        (row, col) = self.check_ALU_available(words[1])
        if row == -1:
            return False

        self.write_ALUs[row][col] = words[1]
        self.read_ALUs[row][col] = (words[2], words[3])

        return True

    def check_mult_available(self, dependant):
        if self.register_in_ALUs(dependant) or self.register_in_memory(dependant):
            return -1

        for i in range(len(self.write_mult)):
            if self.write_mult[i] == "":
                return i
        return -1   

    def set_mult(self, words):
        mult = self.check_mult_available(words[1])
        if mult == -1:
            return False

        self.write_mult[mult] = words[1]
        self.read_mult[mult] = (words[2], words[3])
        return True

    def check_memory_available(self, dependant):
        if self.register_in_ALUs(dependant) or self.register_in_mult(dependant):
            return -1

        for i in range(len(self.write_memory)):
            if self.write_memory[i] == '':
                return i

        return -1

    def set_memory(self, words):
        mem = self.check_memory_available(words[1])
        if mem == -1:
            return False

        self.write_memory[mem] = words[1]
        return True

def prepare_line(line):
    words = line.split()
    operation = words[0].upper()
