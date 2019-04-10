from Array_level import Array_level
from sys import argv
#from numpy import matrix

def translate_file(lines, path):
    bt = Binary_translator()
    i = 0
    file = open(path, 'w+')
    while(i < len(lines)):
        i = bt.decode_assembly(lines, i)
        bitstream = bt.translate_levels()
        file.write(bitstream[::-1])
        bt.clear()
    

def read_file(path_in, path_out):
    file_obj = open(path_in, 'r')
    lines = file_obj.readlines()
    translate_file(lines, path_out)
    
class Binary_translator:
    def __init__(self):
        self.register_quantity = 32
        self.rows = 3
        self.cols = 3
        self.mults = 1
        self.mem = 1
        self.create_levels(3)
        #self.insert_fault(0, 'alu', (0,0))

    def prepare_line(self, line):
        if line == '':
            return True

        words = line.rstrip('\n').split(' ')
        operation = words[0].upper()
        if operation == 'MULT':
            for level in self.levels:
                if level.set_mult(words):
                    return True
            print('error in ' + operation)
            return False

        elif operation == 'LW':
            for level in self.levels:
                if level.set_memory(words):
                    return True
            print('error in ' + operation)
            return False

        elif operation == 'SW':
            for level in self.levels:
                if level.set_memory(words):
                    return True
            print('error in ' + operation)
            return False

        elif operation == 'ADD':
            for level in self.levels:
                if level.set_alus(words):
                    return True
            print('error in ' + operation)
            return False

        elif operation == 'SUB':
            for level in self.levels:
                if level.set_alus(words):
                    return True
            print('error in ' + operation)
            return False

        elif operation == 'AND':
            for level in self.levels:
                if level.set_alus(words):
                    return True
            print('error in ' + operation)
            return False

        elif operation == 'OR':
            for level in self.levels:
                if level.set_alus(words):
                    return True
            print('error in ' + operation)
            return False

        elif operation == 'XOR':
            for level in self.levels:
                if level.set_alus(words):
                    return True
            print('error in ' + operation)
            return False
        
        else:
            raise Exception

    def decode_assembly(self, text, line):
        while(line < len(text)):
            if not self.prepare_line(text[line]):
                break
            line += 1
        return line
        
    def get_mux4_selector(self, string):
        return '{:02b}'.format(string)

    def get_mux32_selector(self, string):
        string = ''.join(filter(lambda x: x.isdigit(), string))
        
        if string == '':
            return '11111'

        reg_number = "{:05b}".format(int(string))
        return reg_number

    def get_operation_code(self, op_string):
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

            elif op_string == 'NOT':
                return '101'
            
            elif op_string == 'X':
                return '111'
                
            else:
                raise Exception

    def translate_alu_input_muxes(self, level):
        bitstream = ''

        for read_alu in level.alu_source:
            for (in1, in2) in read_alu:
                bitstream += self.get_mux32_selector(in1)[::-1] + self.get_mux32_selector(in2)[::-1]

        return bitstream

    def translate_alu_op(self, level):
        bitstream = ''

        for op_line in level.alu_op:
            for op in op_line:
                if op:
                    bitstream += self.get_operation_code(op)[::-1]
                else:
                    bitstream += '111'

        return bitstream

    def translate_output_alus(self, level):
        bitstream = ''
        registers = ["R" + str(i) for i in range(self.register_quantity)]

        for row in range(self.rows):
            for reg in registers:
                line = level.alu_target[row]
                if reg in line:
                    col = line.index(reg)
                    bitstream += self.get_mux4_selector(col)[::-1]
                else:
                    bitstream += '11'

        return bitstream

    def translate_final_muxes(self, level):
        bitstream = ''
        registers = ["R" + str(i) for i in range(self.register_quantity)]

        
        for reg in registers:
            if level.register_in_mult(reg):
                bitstream += '00'

            elif level.register_in_memory(reg) and level.memory_op[level.memory_target.index(reg)] == "LW":
                bitstream += '10'

            else:
                bitstream += '01'

        return bitstream

    def translate_mult_sources(self, level):
        bitstream = ''
        for (in1, in2) in level.mult_source:
            bitstream += self.get_mux32_selector(in1) + self.get_mux32_selector(in2)
        return bitstream

    def translate_memory_data(self, level):
        bitstream = ''
        for addr in level.memory_addr:
            if addr:
                bitstream += addr
            else:
                bitstream += '00000'
                
        for pos in level.memory_pos:
            if addr:
                bitstream += pos[::-1]
            else:
                bitstream += '0000000000000000'

        for write in level.memory_op:
            if write == 'LW':
                bitstream += '0'
            else:
                bitstream += '1'

        for in1 in level.memory_target:
            bitstream += self.get_mux32_selector(in1)

        return bitstream

    def translate_levels(self):

        bitstream = ''
        
        for level in self.levels:

            bitstream += self.translate_alu_input_muxes(level)

            bitstream += self.translate_alu_op(level)

            bitstream += self.translate_output_alus(level)

            bitstream += self.translate_final_muxes(level)

            bitstream += self.translate_mult_sources(level)

            bitstream += self.translate_memory_data(level)

        return bitstream

    def insert_fault(self, level, component, pos):
        fault = (component, pos)
        self.levels[level].insert_fault(fault)

    def create_levels(self, level_number):
        self.levels = []
        for i in range(level_number):
            level = Array_level(self.rows, self.cols, self.mults, self.mem)
            self.levels.append(level)

    def clear(self):
        for level in self.levels:
            level = Array_level(self.rows, self.cols, self.mults, self.mem)


read_file(argv[1], argv[2])
