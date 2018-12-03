from Array_level import Array_level

def translate_file(lines):
    bt = Binary_translator()
    bt.decode_assembly(lines)
    bt.translate_levels()

def read_file(path):
    file_obj = open(path, 'r')
    lines = file_obj.readlines()
    translate_file(lines)

class Binary_translator:
    def __init__(self):
        self.register_quantity = 3
        self.rows = 3
        self.cols = 2
        self.mults = 1
        self.mem = 1
        self.level = Array_level(self.rows, self.cols, self.mults, self.mem)

    
    def prepare_line(self, line):
        words = line.split()
        operation = words[0].upper()
        
        if operation == 'MULT':
            if self.level.set_mult(words):
                return True
        
        elif operation == 'LW':
            if self.level.set_memory(words):
                return True
        
        elif operation == 'SW':
            if self.level.set_memory(words):
                return True
        
        else:
            pass

    def decode_assembly(self, text):
        for line in text:
            if self.prepare_line(line):
                continue
            else:
                break

    def get_mux_selector(self, string):
        if string == 'R0':
            return '00'
        elif string == 'R1':
            return '01'
        elif string == 'R2':
            return '10'
        else:
            return '11'

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
            
            else:
                raise Exception

    def translate_alu_input_muxes(self):
        bitstream = ''

        for read_alu in self.level.alu_source:
            for (in1, in2) in read_alu:
                bitstream += self.get_mux_selector(in1) + self.get_mux_selector(in2) 

        return bitstream

    def translate_alu_op(self):
        bitstream = ''
        
        for op_line in self.level.alu_op:
            for op in op_line:
                bitstream += self.get_operation_code(op)

        return bitstream

    def translate_mult_sources(self):
        bitstream = ''
        for (in1, in2) in self.level.mult_source:
            bitstream += self.get_mux_selector(in1) + self.get_mux_selector(in2)
        return bitstream

    def translate_output_alus(self):
        bitstream = ''
        registers = ["R" + i for i in range(self.register_quantity)]

        for row in range(self.rows):
            for reg in registers:
                line = self.level.alu_target[row]
                if reg in line:
                    col = line.index(reg)
                    temp = 'R'+col
                    bitstream += self.get_mux_selector(temp)
                else:
                    bitstream += '11'

        return bitstream

    def translate_final_muxes(self):
        bitstream = ''
        registers = ["R" + i for i in range(self.register_quantity)]

        for reg in registers:
            if self.level.register_in_mult(reg):
                bitstream += '00'

            elif self.level.register_in_memory(reg):
                bitstream += '01'

            else:
                bitstream += '10'

        return bitstream


    def translate_levels(self):
        bitstream = ''
        
        bitstream += self.translate_alu_input_muxes()
        
        bitstream += self.translate_alu_op()

        bitstream += self.translate_mult_sources()

        bitstream += self.translate_output_alus()

        bitstream += self.translate_output_alus()

       #first lines
       



