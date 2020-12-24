instructions = {"MOV": {'code': '0011', 'operands': '2'}, "ADD": {'code': '0100', 'operands': '2'}, "ADC": {'code': '0101', 'operands': '2'},
                "SUB": {'code': '0110', 'operands': '2'}, "SBC": {'code': '0111', 'operands': '2'}, "AND": {'code': '1000', 'operands': '2'},
                "OR":  {'code': '1001', 'operands': '2'}, "XOR": {'code': '1010', 'operands': '2'}, "CMP": {'code': '1011', 'operands': '2'},

                "INC": {'code': '0011', 'operands': '1'}, "DEC": {'code': '0100', 'operands': '1'}, "CLR": {'code': '0101', 'operands': '1'},
                "INV": {'code': '0110', 'operands': '1'}, "LSR": {'code': '0111', 'operands': '1'}, "ROR": {'code': '1000', 'operands': '1'},
                "ASR": {'code': '1001', 'operands': '1'}, "LSL": {'code': '1010', 'operands': '1'}, "ROL": {'code': '1011', 'operands': '1'},
                "JSR": {'code': '1100', 'operands': '1'},

                "BR": {'code': '0011', 'operands':  'b'}, "BEQ": {'code': '0100', 'operands': 'b'}, "BNE": {'code': '0101', 'operands': 'b'},
                "BLO": {'code': '0110', 'operands': 'b'}, "BLS": {'code': '0111', 'operands': 'b'}, "BHI": {'code': '1000', 'operands': 'b'},
                "BHS": {'code': '1001', 'operands': 'b'},
                "HLT": {'code': '000', 'operands': '0'}, "NOP": {'code': '001', 'operands': '-1'}, "RESET": {'code': '010', 'operands': '0'},
                "RTS": {'code': '011', 'operands': '0'}, "IRET": {'code': '100', 'operands': ' 0'}
                }
registers = {
    "R0": "000",
    "R1": "001",
    "R2": "010",
    "R3": "011",
    "R4": "100",
    "R5": "101",
    "R6": "110",
    "R7": "111"
}


def decode_operand(operand):
    '''
    For the PC mode ==> Rn = PC = R7:
        Immediate = Auto-increment ==> value = [PC]
        Absolute(Indirect Immediate) = Indirect Auto-increment ==> value = [[PC]]
        Relative = Indexed ==> value = [X+[PC]]
        Indirect Relative = Indirect Indexed ==> value = [[X+[PC]]]
    '''
    
    code = ''
    mode = 'REG'
    indirect = '0'
    if operand[0] == '@':
        operand = operand[1:]
        indirect = '1'
    
    if operand in registers.keys():                         # Register
        code = '00' + indirect + registers[operand]
    elif operand[0] == '(' and operand[-1] == '+':          # Auto-increment
        code = '01' + indirect + registers[operand[1:-2]]
    elif operand[0] == '-' and operand[-1] == ')':          # Auto-decrement
        code = '10' + indirect + registers[operand[2:-1]]
    elif operand[0].upper() == 'X' and operand[-1] == ')':  # Indexed
        code = '11' + indirect + registers[operand[2: -1]] 
    elif operand[0] == '#':                                 # Immediate
        code = '01' + indirect + '111'
        mode = 'PC'
    else:                                                   # Relative                                                    
        code = '11' + indirect + '111'
        mode = 'PC'
        
    return code, mode


file = open("test.txt")
string = ""
for line in file:
    # split the line and get what is before the ; symbol and then make all the charchters  upper cases
    line = line.split(';')[0].upper()
    if line != "\n":
        string = string + line

code = string.split("HLT")[0]
variablesString = string.split("HLT")[1].split("DEFINE")

variables = {}
for variable in variablesString:
    if variable.strip():
        x, y = variable.split()
        variables[x] = y
code = code.replace(',', ' ')
print(variables)  # map of the variables
print(code)  # code'
ouput = open("ouput.txt", 'w')
code = code.split()
print(code)
i = 0
labels = {}
line = 1
program = []
while i < len(code):
    word = code[i]
    if not (word in instructions):
        # label
        # putting the number of the line this label in
        labels[word] = line
        i = i + 1
        continue

    if instructions[word]['operands'] == '-1':
        # NoOp
        i = i + 1
        line = line + 1
        continue

    # add both the operand to the file according to the operand
    if instructions[word]['operands'] == '2':
        ouput.write(instructions[word]['code'])
        # add the 2 operands
        i = i + 2
    elif instructions[word]['operands'] == '1':
        # add the operand
        ouput.write('0000'+instructions[word]['code'])
        i = i + 1
    elif instructions[word]['operands'] == 'b':
        # add the offset
        ouput.write('0001'+instructions[word]['code'])
        i = i + 1
    elif instructions[word]['operands'] == '0':
        ouput.write('0010', instructions[word]['code'])
    # for debugging purpose
    ouput.write('\n')
    i = i + 1
    line = line + 1
