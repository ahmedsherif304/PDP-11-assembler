#
F1 = {
    "no": "000",
    "pc_out": "001",
    "mdr_out": "010",
    "z_out": "011",
    "rsrc_out": "100",
    "rdst_out": "101",
    "source_out": "110",
    "dest_out": "111"
}

F2 = {
    "no": "000",
    "pc_in": "001",
    "ir_in": "010",
    "z_in": "011",
    "rsrc_in": "100",
    "rdst_in": "101"
}

F3 = {
    "no": "00",
    "mar_in": "01",
    "mdr_in": "10"
}

F4 = {
    "no": "00",
    "y_in": "01",
    "source_in": "10",
    "dest_in": "11"
}

F5 = {
    "no": "0000",
    "add": "0100",
    "adc": "0101",
    "sub": "0110",
    "sbc": "0111",
    "and": "1000",
    "or": "1001",
    "xor": "1010",
    "cmp": "1011",
    "not": "0001",
    "lsr": "0010",
    "ror": "0011",
    "asr": "1100",
    "lsl": "1101",
    "rol": "1110"
}


F6 = {
    "no": "00",
    "read": "01",
    "write": "10"
}

F7 = {
    "no": "0",
    "clear_y": "1"
}


F8 = {
    "no": "0",
    "carry_in_0": "0",  # carry_in_0
    "carry_in_1": "1",
    "set_carry": "1"
}

F9 = {
    "no": "0",
    "wmfc": "1"
}
F10 = {
    "no": "000",
    "or_dst": "001",
    "or_indsrc": "010",
    "or_inddst": "011",
    "or_result": "100",

}

F11 = {
    "no": "0",
    "pla_out": "1"
}


FS = [
    F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11
]
# next_address:pc_out,mar_in,read,z_in,clear_y,carry_in_0
# eg:
# line = "0:1 pc_out,mar_in,read,z_in,clear_y,carry_in_0"


def check_false_inst(instructions):
    for inst in instructions:
        found = False
        for i, F in enumerate(FS):
            if inst in F:
                found = True
                break
        if not found:
            raise("{} instruction not found".format(inst))


file1 = open('rom.txt', 'r')
file_out = open('rom.bin', 'w')
lines = file1.readlines()
for line in lines:
    line = line.replace('\n', '')
    # if(line.find('#') >= 0):
    #     line = line.split("#")[0]
    # line = "0:1 rsrc_out,rdst_in"
    print("line is ", line)

    # decode the line
    addresses_inst = line.split(' ')
    print(addresses_inst)

    adds = addresses_inst[0].split(':')
    instructions = addresses_inst[1].split(',')
    print("instruction address ", adds[0])
    print("next instruction address ", adds[1])
    print("instruction", instructions)
    print("hi")

    def get_binary(num, length=8):
        out_str = ""
        b = bin(int(num))[2:]
        for i in range(length - len(b)):
            out_str += '0'
        out_str += b
        return out_str

    print(get_binary('11'))
    # print(bin(int(adds[1])))

    out_line = adds[0] + " => "
    for char in adds[1]:
        print("char", char)
        out_line += get_binary(char, 3)
    check_false_inst(instructions)
    # out_line += get_binary(adds[1])
    for i, F in enumerate(FS):
        found = False
        for micro in F:
            if micro in instructions:
                print("F", i+1, micro, F[micro])
                out_line += F[micro]
                found = True
        if(not found):
            print("F", i+1, "no",  F['no'])
            out_line += F['no']
        out_line
    file_out.writelines([out_line+',\n'])
    print(out_line)
