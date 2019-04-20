from Array_level import Array_level

class Array:
    def __init__(self, rows, cols, multipliers, memory, levels):
        self.level_quantity = levels
        self.levels = []
        for i in range(levels):
            level = Array_level(rows, cols, multipliers, memory)
            self.levels.append(level)

     
    def check_ALU_available(self, dependent1, dependent2):

        dep_level = -1
        for level in self.levels:
            if level.register_in_memory(dependent1) or level.register_in_mult(dependent1):
                dep_level = self.levels.index(level)
            if level.register_in_memory(dependent2) or level.register_in_mult(dependent2):
                dep_level = self.levels.index(level)
        
        if dep_level == 2:
            return (-1, -1, -1)

        dep_row = -1

        
        #search levels without dependence
        for level_i in range(dep_level+1, len(self.levels)):
            level = self.levels[level_i]
            #checks rows of that level
            for row in range(len(level.alu_target)):
                #checks cols of that row
                for col in range(len(level.alu_target[row])):
                    #if found dependence
                    if level.alu_target[row][col] == dependent1 or level.alu_target[row][col] == dependent2:
                        dep_row = row
                        dep_level = level_i-1
                        break
                    #if no more regs in that row
                    elif level.alu_target[row][col] == '':
                        break
                
        
        for level in range(dep_level+1, len(self.levels)):
            for row in range(dep_row+1, len(self.levels[level].alu_target)):
                for col in range(len(self.levels[level].alu_target[row])):
                    if self.levels[level].alu_target[row][col]=='':
                        return (row, col, level)
            dep_row = -1

        return (-1,-1, -1)

    def set_alus(self, words):
        (row, col, level) = self.check_ALU_available(words[2], words[3])
        if row == -1:
            return False

        self.levels[level].alu_op[row][col] = words[0]
        self.levels[level].alu_target[row][col] = words[1]
        self.levels[level].alu_source[row][col] = (words[2], words[3])

        return True
    
    
    def check_mult_available(self, dependent1, dependent2):
        
        dep_level = -1
        for level in self.levels:
            if level.register_in_memory(dependent1) or level.register_in_ALUs(dependent1):
                dep_level = self.levels.index(level)
                #print("aaaaa")
            if level.register_in_memory(dependent2) or level.register_in_ALUs(dependent2):
                dep_level = self.levels.index(level)
                #print('BBBBB')
        # print(dep_level)

        if dep_level == 2:
            return (-1, -1)

        dep_mul = -1
        for level_i in range(dep_level+1, len(self.levels)):
            level = self.levels[level_i]
            for i in range(len(level.mult_target)):
                if level.mult_target[i] == dependent1 or level.mult_target[i] == dependent2:
                    dep_mul = i
                    dep_level = level_i-1
                    break

        
        for level in range(dep_level+1, len(self.levels)):
            for i in range(dep_mul+1, len(self.levels[level].mult_target)):
                if self.levels[level].mult_target[i] == '':
                    return (i, level)
            dep_mul = -1
    
        return (-1,-1)

       

    def set_mult(self, words):
        (mult, level) = self.check_mult_available(words[2], words[3])
        if mult == -1:
            return False

        self.levels[level].mult_target[mult] = words[1]
        self.levels[level].mult_source[mult] = (words[2], words[3])
        return True

    def check_memory_available(self, dependent1, dependent2):
        dep_level = -1
        for level in self.levels:
            if level.register_in_mult(dependent1) or level.register_in_ALUs(dependent1) or level.register_in_mult(dependent2) or level.register_in_ALUs(dependent2):
                dep_level = self.levels.index(level)

        if dep_level == 2:
            return (-1, -1)

        dep_mem = -1
        for level_i in range(dep_level+1, len(self.levels)):
            level = self.levels[level_i]
            for i in range(len(level.memory_target)):
                if level.memory_target[i] == dependent1 or level.memory_target[i] == dependent2:
                    dep_mem = i
                    dep_level = level_i-1
                    break
        
        for level in range(dep_level+1, len(self.levels)):
            for i in range(dep_mem+1, len(self.levels[level].memory_target)):
                if self.levels[level].memory_target[i] == '':
                    return (i, level)
            dep_mem = -1
    
        return (-1,-1)
        

    def set_memory(self, words):

        reg=''
        pos=''
        word = ''.join(c for c in words[2] if c not in "()")
        (pos, reg) = word.split('R')

        (mem, level) = self.check_memory_available(words[1], 'R' + reg)
        if mem == -1:
            return False

        self.levels[level].memory_op[mem] = words[0]
        self.levels[level].memory_target[mem] = words[1]


        self.levels[level].memory_addr[mem] = "{0:05b}".format(int(reg))
        self.levels[level].memory_pos[mem] = "{0:016b}".format(int(pos))

        return True
