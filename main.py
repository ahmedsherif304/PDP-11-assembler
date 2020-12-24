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
                "HLT": {'code': '000', 'operands': '0'}, "NOP": {'code': '001', 'operands': '0'}, "RESET": {'code': '010', 'operands': '0'},
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
        mode = 'PC_M'
    else:                                                   # Relative
        code = '11' + indirect + '111'
        mode = 'PC_R'

    return code, mode


def encode_decimal(operand):
    if operand in variables.keys():
        operand = variables[operand]

    code = ''
    operand = int(operand)
    if operand < 0:
        code = bin(operand % (1 << 16))[2:]
    else:
        code = '0'*(16-len(bin(operand)[2:])) + bin(operand)[2:]

    return code


def decode_immediate(operand):
    if operand[0] == '@':
        operand = operand[2:]
    else:
        operand = operand[1:]

    return encode_decimal(operand)


def decode_relative(operand):
    if operand[0] == '@':
        operand = operand[1:]

    return encode_decimal(operand)


file = open("test.txt")
string = ""
lines = []
for line in file:
    # split the line and get what is before the ; symbol and then make all the charchters  upper cases
    line = line.split(';')[0].upper()
    if line != "\n":
        string = string + line
    if line != '\n' and len(line) != 0:
        lines.append(line.upper())

lines = [line for line in lines if not line.startswith('DEFINE')]
for line in lines:
    print(line)

code = string.split("HLT")[0]
variablesString = string.split("HLT")[1].split("DEFINE")

variables = {}
for variable in variablesString:
    if variable.strip():
        x, y = variable.split()
        variables[x] = y
code = code.replace(',', ' ')
# print(code)
# print(variables)  # map of the variables
# print(code)  # code'
code = code.split()
# print(code)

i = 1
labels = {}
for i in range(len(lines)):
    word = lines[i].strip().replace(',', ' ').split()
    if word[0] not in instructions and word[0][-1] == ':':
        # label
        # putting the number of the line this label in
        print(word[0][:-1])
        labels[word[0][:-1]] = i


# line = 1
program = []
for line in lines:
    word = line.strip().replace(',', ' ').split()

    if word[0] not in instructions and word[0][-1] == ':':
        if len(word) > 1:
            word = word[1:]
        else:
            continue

    # Q: Why -1 ?
    if instructions[word[0]]['operands'] == '0':
        # NoOp
        i = i + 1
        program.append(
            '0010' + instructions[word[0]]['code'] + ''.join(['0'*9]))
        continue

    # add both the operand to the file according to the operand
    if instructions[word[0]]['operands'] == '2':
        opcode = instructions[word[0]]['code']
        src, src_mode = decode_operand(word[1])
        dst, dst_mode = decode_operand(word[2])
        code = opcode + src + dst
        program.append(code)

        # Handle immediate and relative modes for the src
        if src_mode == 'PC_M':
            value = decode_immediate(word[1])
            program.append(value)
        elif src_mode == 'PC_R':
            value = decode_relative(word[1])
            program.append(value)
        # Handle immediate and relative modes for the dst
        if dst_mode == 'PC_M':
            value = decode_immediate(word[2])
            program.append(value)
        elif dst_mode == 'PC_R':
            value = decode_relative(word[2])
            program.append(value)
    elif instructions[word[0]]['operands'] == '1':
        opcode = instructions[word[0]]['code']
        dst, dst_mode = decode_operand(word[1])
        # 4-bits FLAG + 4-bits OPCODE + 2-bits DONT CARE + 6-bits DST
        code = '0000' + opcode + '00' + dst
        program.append(code)
        # Handle immediate and relative modes for the dst
        if dst_mode == 'PC_M':
            value = decode_immediate(word[1])
            program.append(value)
        elif dst_mode == 'PC_R':
            value = decode_relative(word[1])
            program.append(value)
    elif instructions[word[0]]['operands'] == 'b':
        opcode = instructions[word[0]]['code']
        offset = bin(labels[word[1]])[2:]
        offset = '0'*(8-len(offset)) + offset
        code = '0001' + opcode + offset
        program.append(code)
    # i = i + 1

output = open("program.txt", "w")
for inst in program:
    print(inst)
    output.write(inst+'\n')
output.close()
