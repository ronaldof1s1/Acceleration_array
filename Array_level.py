
class Array_level:

    def __init__(self, alus_per_row, rows_of_alus, multipliers, memory):
        self.alu_target = []
        self.alu_source = []
        self.alu_op = []
        for i in range(rows_of_alus):
            write_alu_line = []
            read_alu_line = []
            op_alu_line = []
            
            for i in range(alus_per_row):
                write_alu_line.append("")
                op_alu_line.append("")
                read_alu_line.append(("",""))
                
            self.alu_target.append(write_alu_line)
            self.alu_source.append(read_alu_line)
            self.alu_op.append(op_alu_line)
            
        self.mult_target = []
        self.mult_source =[]
        
        for i in range(multipliers):
            self.mult_target.append("")
            self.mult_source.append(("", ""))
        
        self.memory_target = []
        self.memory_op = []
        
        for i in range(memory):
            self.memory_target.append("")
            self.memory_op.append("")

    def register_in_mult(self, register):
        for mult in self.mult_target:
            if mult == register:
                return True

        return False

    def register_in_memory(self, register):
        for mem in self.memory_target:
            if mem == register:
                return True

        return False

    def register_in_ALUs(self, register):
        for line in self.alu_target:
            for alu in line:
                if alu == register:
                    return True
        
        return False

    def check_ALU_available(self, dependant):   
        if self.register_in_memory(dependant) or self.register_in_mult(dependant):
            return (-1,-1)
        
    
        for row in range(len(self.alu_target)):
            for col in range(len(self.alu_target[0])):
                if self.alu_target[row][col] == dependant:
                    break
                elif self.alu_target[row][col] == '':
                    return (row,col)
                    break

        return (-1,-1)

    def set_alus(self, words):
        (row, col) = self.check_ALU_available(words[1])
        if row == -1:
            return False

        self.alu_op[row][col] = words[0]
        self.alu_target[row][col] = words[1]
        self.alu_source[row][col] = (words[2], words[3])

        return True

    def check_mult_available(self, dependant):
        if self.register_in_ALUs(dependant) or self.register_in_memory(dependant):
            return -1

        for i in range(len(self.mult_target)):
            if self.mult_target[i] == "":
                return i
        return -1   

    def set_mult(self, words):
        mult = self.check_mult_available(words[1])
        if mult == -1:
            return False

        self.mult_target[mult] = words[1]
        self.mult_source[mult] = (words[2], words[3])
        return True

    def check_memory_available(self, dependant):
        if self.register_in_ALUs(dependant) or self.register_in_mult(dependant):
            return -1

        for i in range(len(self.memory_target)):
            if self.memory_target[i] == '':
                return i

        return -1

    def set_memory(self, words):
        mem = self.check_memory_available(words[1])
        if mem == -1:
            return False

        self.memory_op[mem] = words[0]
        self.memory_target[mem] = words[1]
        return True

