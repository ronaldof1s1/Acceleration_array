from sys import argv

REGS = {}

ALU_operations = ['ADD', 'SUB', 'AND', 'OR', 'XOR']
MULT_operations = ['MULT']
MEM_operations = ['SW', 'LW']

MEMORY = []

def init():
    for i in range(32):
        reg = 'R{0:02d}'.format(i)
        REGS[reg] = i

    for i in range(2 ** 16):
            MEMORY.append(0)


def read_file(path_in):
    file_obj = open(path_in, 'r')
    lines = file_obj.readlines()
    exec_file(lines)
    
def exec(path_in):
    read_file(path_in)
    path_out=""
    for i in range(len(path_in)-2):
        path_out += path_in[i]
    path_out += "res"
    file = open(path_out, 'w+')
    write_out(file)

def write_out(file):
    string = 'REGISTERS:\n'
    for i in REGS:
        string += i + ": " + str(REGS[i]) + "\n"
        
    string += "\nMEMORY:\n"
    for i in MEMORY:
        if i != 0:
            index = str(MEMORY.index(i))
            string += index + ": " +str(i) + "\n"
    
    file.write(string)


def exec_file(text):       

    for line in text:
        if line == '':
                continue

        words = line.rstrip('\n').split(' ')

        operation = words[0].upper()

        if operation in ALU_operations or operation in MULT_operations:
            exec_func(words)

        elif operation in MEM_operations:
            exec_mem(words)
                
        else:
            raise Exception
        

def exec_func(words):
        op = words[0]
        target = words[1]
        src1 = words[2]
        src2 = words[3]

        if op == "ADD":
                REGS[target] = REGS[src1] + REGS[src2]
        elif op == "SUB":
                REGS[target] = REGS[src1] - REGS[src2]
        elif op == "AND":
                REGS[target] = REGS[src1] & REGS[src2]
        elif op == "OR":
                REGS[target] = REGS[src1] | REGS[src2]
        elif op == "XOR":
                REGS[target] = REGS[src1] ^ REGS[src2]
        elif op == "MULT":
                REGS[target] = REGS[src1] * REGS[src2]
                

def exec_mem(words):
        op = words[0]
        target = words[1]
        reg=''
        pos=''
        word = ''.join(c for c in words[2] if c not in "()")
        (pos, reg) = word.split('R')
        reg = 'R' + reg
        mem_pos = REGS[reg] + int(pos)
        mem_pos_bin = "{0:016b}".format(mem_pos)
        mem_pos_bin = mem_pos_bin[8:16]
        mem_pos = int(mem_pos_bin,2)
        print(mem_pos)
                
        if op == "LW":
                REGS[target] = MEMORY[mem_pos]
        elif op == "SW":
                MEMORY[mem_pos] = REGS[target]


path = argv[1]

init()

exec(path)