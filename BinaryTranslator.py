from Array_level import Array_level

def read_file(path):
    file_obj = open(path, 'r')
    lines = file_obj.readlines()

class Binary_translator:
    level = Array_level(3, 2, 1, 1)

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