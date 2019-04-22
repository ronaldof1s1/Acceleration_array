from random import *
from sys import argv

ALU_operations = ['ADD', 'SUB', 'AND', 'OR', 'XOR']
MULT_operations = ['MULT']
MEM_operations = ['SW', 'LW']

REGs = []

for i in range(32):
    reg = "R{0:02d}".format(i)
    REGs.append(reg)

def only_alu(file):
    program = ''

    for i in range(32):
        op = choice(ALU_operations)
        target = choice(REGs)
        source1 = choice(REGs)
        source2 = choice(REGs)
        program += "{} {} {} {}\n".format(op, target, source1, source2)
        
    file.write(program)

def only_alu_seq(file):
    program = ''
    early_target = 'R1'
    for i in range(32):
        op = choice(ALU_operations)
        target = choice(REGs)
        source1 = early_target
        early_target = target
        source2 = choice(REGs)
        program += "{} {} {} {}\n".format(op, target, source1, source2)
    file.write(program)

def only_alu_par(file):
    program = ''
    targets=[]
    no_targets = REGs
    for i in range(32):
        op = choice(ALU_operations)
        target = choice(REGs)
        source1 = choice(no_targets)
        source2 = choice(no_targets)
        targets.append(target)
        no_targets.remove(target)
        program += "{} {} {} {}\n".format(op, target, source1, source2)
    file.write(program)

def full_seq(file):
    program = ''
    early_target = 'R1'
    for i in range(32):
        op_type = choice([1,2,3])
        if op_type == 1:
            op = choice(ALU_operations)
            target = choice(REGs)
            source1 = early_target
            early_target = target
            source2 = choice(REGs)
            program += "{} {} {} {}\n".format(op, target, source1, source2)
        elif op_type == 2:
            op = choice(MULT_operations)
            target = choice(REGs)
            source1 = early_target
            early_target = target
            source2 = choice(REGs)
            program += "{} {} {} {}\n".format(op, target, source1, source2)
        elif op_type == 3:
            op = choice(MEM_operations)
            target = choice(REGs)
            source1 = early_target
            early_target = target
            pos = randint(0,32)
            program += "{} {} {}({}) \n".format(op, target, pos, source1)
                
    file.write(program)


def full_par(file):
    program = ''
    targets = []
    no_targets = REGs
    for i in range(32):
        op_type = choice([1,2,3])
        if op_type == 1: 
            op = choice(ALU_operations)
            target = choice(REGs)
            source1 = choice(no_targets)
            source2 = choice(no_targets)
            targets.append(target)
            no_targets.remove(target)
            program += "{} {} {} {}\n".format(op, target, source1, source2)
        elif op_type == 2:
            op = choice(MULT_operations)
            target = choice(REGs)
            source1 = choice(no_targets)
            source2 = choice(no_targets)
            no_targets.remove(target)
            program += "{} {} {} {}\n".format(op, target, source1, source2)
        elif op_type == 3:
            op = choice(MEM_operations)
            target = choice(REGs)
            source1 = choice(no_targets)
            pos = randint(0,32)
            no_targets.remove(target)
            program += "{} {} {}({}) \n".format(op, target, pos, source1)
                
    file.write(program)

def full_rand(file):
	program = ''
	for i in range(32):
		op_type = choice([1,2,3])
		if op_type == 1: 
		    op = choice(ALU_operations)
		    target = choice(REGs)
		    source1 = choice(REGs)
		    source2 = choice(REGs)
		    program += "{} {} {} {}\n".format(op, target, source1, source2)
		elif op_type == 2:
		    op = choice(MULT_operations)
		    target = choice(REGs)
		    source1 = choice(REGs)
		    source2 = choice(REGs)
		    program += "{} {} {} {}\n".format(op, target, source1, source2)
		elif op_type == 3:
		    op = choice(MEM_operations)
		    target = choice(REGs)
		    source1 = choice(REGs)
		    pos = randint(0,32)
		    program += "{} {} {}({}) \n".format(op, target, pos, source1)

	file.write(program)


	
path = argv[1]

file = open(path, 'w+')

full_rand(file)