
class Array_level:

    def __init__(self, rows, cols, multipliers, memory):
        self.alu_target = []
        self.alu_source = []
        self.alu_op = []
        for row in range(rows):
            write_alu_line = []
            read_alu_line = []
            op_alu_line = []

            for col in range(cols):
                write_alu_line.append("")
                op_alu_line.append("")
                read_alu_line.append(("",""))

            self.alu_target.append(write_alu_line)
            self.alu_source.append(read_alu_line)
            self.alu_op.append(op_alu_line)

        self.mult_target = []
        self.mult_source =[]

        for mult in range(multipliers):
            self.mult_target.append("")
            self.mult_source.append(("", ""))

        self.memory_target = []
        self.memory_op = []
        self.memory_pos = []
        self.memory_addr = []

        for mem in range(memory):
            self.memory_target.append("")
            self.memory_op.append("")
            self.memory_pos.append("")
            self.memory_addr.append("")

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
            for col in range(len(self.alu_target[row])):
                if self.alu_target[row][col] == dependant:
                    break
                elif self.alu_target[row][col] == '':
                    return (row,col)

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

        reg=''
        pos=''
        word = ''.join(c for c in words[2] if c not in "()")
        (pos, reg) = word.split('R')

        self.memory_addr[mem] = "{0:05b}".format(int(reg))
        self.memory_pos[mem] = "{0:016b}".format(int(pos))

        return True

    def insert_fault(self, fault):
        if fault[0] == 'mem':
            self.insert_fault_mem(fault[1])
        elif fault[0] == 'mult':
            self.insert_fault_mult(fault[1])
        else:
            self.insert_fault_alu(fault[1])

    def insert_fault_mem(self, pos):
        self.memory_op[pos] = 'x'
        self.memory_target[pos] = 'x'
        self.memory_addr[pos] = 'x'
        self.memory_pos[pos] = 'x'

    def insert_fault_mult(self, pos):
        self.mult_target[pos] = 'x'
        self.mult_source[pos] = 'x'

    def insert_fault_alu(self, pos):
        x = pos[0]
        y = pos[1]
        self.alu_target[x][y] = 'x'
        self.alu_source[x][y] = ('x','x')
        self.alu_op[x][y] = 'x'
    
    def clear(self):
        self.clear_alu()
        self.clear_mult()
        self.clear_memory()
    
    def clear_alu(self):
        for i in range(len(self.alu_op)):
            for j in range(len(self.alu_op[i])):
                self.alu_op[i][j] = ""
                self.alu_target[i][j] = ""
                self.alu_source[i][j] = ("","")

    def clear_mult(self):
        for i in range(len(self.mult_source)):
            self.mult_source[i] = ("","")
            self.mult_target[i] = ""

    def clear_memory(self):
        for i in range(len(self.memory_op)):
            self.memory_op[i] = ""
            self.memory_target[i] = ""
            self.memory_pos[i] = ""
            self.memory_addr[i] = ""