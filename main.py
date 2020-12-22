#instructions = {"MOV": "0011"}
#numberOfOperands = {"MOV": 2, "ADD": 2}
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
    if (variable != " "):
        x, y = variable.split()
        variables[x] = y
print(variables)  # map of the variables
print(code)  # code
