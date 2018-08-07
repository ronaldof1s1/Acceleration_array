from Array_level import Array_level

def translate_file(lines):
    bt = Binary_translator()
    bt.decode_assembly(lines)

def read_file(path):
    file_obj = open(path, 'r')
    lines = file_obj.readlines()
    translate_file(lines)

class Binary_translator:
    level = Array_level(3, 2, 1, 1)

    
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
        if string == 'r0':
            return '00'
        elif string == 'r1':
            return '01'
        elif string == 'r2':
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

    def translate_levels(self):
        bitstream = ''
       
        for read_alu in self.level.read_ALUs:
            for (in1, in2) in read_alu[0]:
                bitstream += self.get_mux_selector(in1) + self.get_mux_selector(in2) 
       
       
        for op_line in self.level.ALUs_OPs:
            for op in op_line:
                bitstream += self.get_operation_code(op)

        for write_alus in self.level.write_ALUs:
            for out in write_alus:
                bitstream += self.get_mux_selector(out)
       

        for (in1, in2) in self.level.read_mult:
            bitstream += self.get_mux_selector(in1) + self.get_mux_selector(in2)

        for out in self.level.write_mult:
            bitstream +=  self.get_mux_selector(out)
        
        