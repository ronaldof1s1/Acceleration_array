from Array_level import Array_level

def translate_file(lines):
    bt = Binary_translator()
    bt.decode_assembly(lines)
    bitstream = bt.translate_levels()
    return bitstream

def read_file(path):
    file_obj = open(path, 'r')
    lines = file_obj.readlines()
    bitstream = translate_file(lines)
    return bitstream

class Binary_translator:
    def __init__(self):
        self.register_quantity = 32
        self.rows = 3
        self.cols = 3
        self.mults = 1
        self.mem = 1
        self.level = Array_level(self.rows, self.cols, self.mults, self.mem)


    def prepare_line(self, line):
        words = line.split(' ')
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

        elif operation == 'ADD':
            if self.level.set_alus(words):
                return True

        elif operation == 'SUB':
            if self.level.set_alus(words):
                return True

        elif operation == 'AND':
            if self.level.set_alus(words):
                return True

        elif operation == 'OR':
            if self.level.set_alus(words):
                return True

        elif operation == 'XOR':
            if self.level.set_alus(words):
                return True
        else:
            raise Exception

    def decode_assembly(self, text):
        for line in text:
            if self.prepare_line(line):
                continue
            else:
                break

    def get_mux4_selector(self, string):
        if string == 'R0':
            return '00'
        elif string == 'R1':
            return '01'
        elif string == 'R2':
            return '10'
        else:
            return '11'

    def get_mux32_selector(self, string):
        if string == 'R0':
            return '00000'
        elif string == 'R1':
            return '00001'
        elif string == 'R2':
            return '00010'
        elif string == 'R3':
            return '00011'
        elif string == 'R4':
            return '00100'
        elif string == 'R5':
            return '00101'
        elif string == 'R6':
            return '00110'
        elif string == 'R7':
            return '00111'
        elif string == 'R8':
            return '01000'
        elif string == 'R9':
            return '01001'
        elif string == 'R10':
            return '01010'
        elif string == 'R11':
            return '01011'
        elif string == 'R12':
            return '01100'
        elif string == 'R13':
            return '01101'
        elif string == 'R14':
            return '01110'
        elif string == 'R15':
            return '01111'
        elif string == 'R16':
            return '10000'
        elif string == 'R17':
            return '10001'
        elif string == 'R18':
            return '10010'
        elif string == 'R19':
            return '10011'
        elif string == 'R20':
            return '10100'
        elif string == 'R21':
            return '10101'
        elif string == 'R22':
            return '10110'
        elif string == 'R23':
            return '10111'
        elif string == 'R24':
            return '11000'
        elif string == 'R25':
            return '11001'
        elif string == 'R26':
            return '11010'
        elif string == 'R27':
            return '11011'
        elif string == 'R28':
            return '11100'
        elif string == 'R29':
            return '11101'
        elif string == 'R30':
            return '11110'
        else:
            return '11111'

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
            else:
                raise Exception

    def translate_alu_input_muxes(self):
        bitstream = ''

        for read_alu in self.level.alu_source:
            for (in1, in2) in read_alu:
                bitstream += self.get_mux32_selector(in1) + self.get_mux32_selector(in2)

        return bitstream

    def translate_alu_op(self):
        bitstream = ''

        for op_line in self.level.alu_op:
            for op in op_line:
                if op:
                    bitstream += self.get_operation_code(op)
                else:
                    bitstream += '000'

        return bitstream

    def translate_output_alus(self):
        bitstream = ''
        registers = ["R" + str(i) for i in range(self.register_quantity)]

        print(self.level.alu_target)
        for row in range(self.rows):
            for reg in registers:
                line = self.level.alu_target[row]
                if reg in line:
                    col = line.index(reg)
                    temp = 'R'+str(col)
                    bitstream += self.get_mux4_selector(temp)
                else:
                    bitstream += '11'

        return bitstream

    def translate_final_muxes(self):
        bitstream = ''
        registers = ["R" + str(i) for i in range(self.register_quantity)]

        for reg in registers:
            if self.level.register_in_mult(reg):
                bitstream += '00'

            elif self.level.register_in_memory(reg):
                bitstream += '01'

            else:
                bitstream += '10'

        return bitstream

    def translate_mult_sources(self):
        bitstream = ''
        for (in1, in2) in self.level.mult_source:
            bitstream += self.get_mux32_selector(in1) + self.get_mux32_selector(in2)
        return bitstream

    def translate_memory_data(self):
        bitstream = ''
        for addr in self.level.memory_addr:
            if addr:
                bitstream += addr
            else:
                bitstream += '00000000000000000000000000000000'

        for write in self.level.memory_op:
            if write == 'LW':
                bitstream += '0'
            else:
                bitstream += '1'

        for in1 in self.level.memory_target:
            bitstream += self.get_mux32_selector(in1)

        return bitstream

    def translate_levels(self):
        bitstream = ''

        bitstream += self.translate_alu_input_muxes()

        bitstream += self.translate_alu_op()

        bitstream += self.translate_output_alus()

        bitstream += self.translate_final_muxes()

        bitstream += self.translate_mult_sources()

        bitstream += self.translate_memory_data()

        return bitstream


bitstream = read_file('testes/teste_inicial.txt')
print(bitstream+'0')