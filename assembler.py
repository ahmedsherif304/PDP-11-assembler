import sys
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
variables = {}


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
    elif operand[-1] == ')':  # Indexed
        var_idx = operand.find('(')
        # var = operand[0:var_idx]
        code = '11' + indirect + registers[operand[var_idx+1: -1]]
    elif operand[0] == '#':                                 # Immediate
        code = '01' + indirect + '111'
        mode = 'PC_M'
    else:                                                   # Relative
        code = '11' + indirect + '111'
        mode = 'PC_R'

    return code, mode


print(sys.argv)
input_file = "test.txt"
output_file = "program.bin"
if(len(sys.argv) >= 2):
    input_file = sys.argv[1]
if(len(sys.argv) == 3):
    output_file = sys.argv[2]

file = open(input_file)


string = ""
lines = []
i = 0
for line in file:
    # split the line and get what is before the ; symbol and then make all the charchters  upper cases
    line = line.split(';')[0].upper()
    if line != "\n":
        string = string + line
    if line != '\n' and len(line) != 0:
        lines.append(line.upper())

address = 0
labels = {}
line_address = []
for line in lines:
    line_address.append(address)
    word = line.strip().replace(',', ' ').split()
    if line.startswith('DEFINE'):
        word = line.split(' ')
        variables[word[1]] = {'ADDRESS': address, 'VALUE': word[2]}
        print(address)
        address += 1
        continue

    if word[0] not in instructions and word[0][-1] == ':':
        labels[word[0][:-1]] = address
        if len(word) > 1:
            word = word[1:]
        else:
            continue
    if instructions[word[0]]['operands'] == '0':
        address += 1
        continue

    if instructions[word[0]]['operands'] == '2':
        address += 1
        _, src_mode = decode_operand(word[1])
        _, dst_mode = decode_operand(word[2])
        if src_mode == 'PC_M' or src_mode == 'PC_R':
            address += 1
        if dst_mode == 'PC_M' or dst_mode == 'PC_R':
            address += 1
    elif instructions[word[0]]['operands'] == '1':
        address += 1
        _, dst_mode = decode_operand(word[1])
        if dst_mode == 'PC_M' or dst_mode == 'PC_R':
            address += 1
    elif instructions[word[0]]['operands'] == 'b':
        address += 1


# lines = [line for line in lines if not line.startswith('DEFINE') ]
for i, line in enumerate(lines):
    print(line, line_address[i])


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


program = []
for i, line in enumerate(lines):
    word = line.strip().replace(',', ' ').split()
    if line.startswith('DEFINE'):
        word = line.split(' ')
        program.append(decode_relative(word[2]))
        continue

    if word[0] not in instructions and word[0][-1] == ':':
        if len(word) > 1:
            word = word[1:]
        else:
            continue

    if instructions[word[0]]['operands'] == '0':
        # NoOp
        # i = i + 1
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
            value = decode_relative(str(variables[word[1]]['ADDRESS']))
            program.append(value)
        # Handle immediate and relative modes for the dst
        if dst_mode == 'PC_M':
            value = decode_immediate(word[2])
            program.append(value)
        elif dst_mode == 'PC_R':
            value = decode_relative(str(variables[word[2]]['ADDRESS']))
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
            value = decode_relative(str(variables[word[1]]['ADDRESS']))
            program.append(value)
    elif instructions[word[0]]['operands'] == 'b':
        opcode = instructions[word[0]]['code']
        offset = labels[word[1]]
        print(offset)
        offset = int(offset) - line_address[i]
        print(offset)
        if offset < 0:
            offset = bin(offset % (1 << 8))[2:]
        else:
            offset = '0'*(8-len(bin(offset)[2:])) + bin(offset)[2:]
        code = '0001' + opcode + offset
        print(offset)
        program.append(code)

output = open(output_file, "w")
for inst in program:
    output.write(inst+'\n')
output.close()
print(program)
