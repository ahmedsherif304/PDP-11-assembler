file = open("test.txt")
string = ""
for line in file:
    # split the line and get what is before the ; symbol and then make all the charchters  upper cases
    line = line.split(';')[0].upper()
    if line != "\n":
        string = string + line

code = string.split("HLT")[0]
variables = string.split("HLT")[1].split("DEFINE")
print(variables)
print(code)
