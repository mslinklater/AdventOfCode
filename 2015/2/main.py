f = open("2/input.txt", "rt")

# read line by line
lines = f.readlines()

total = 0
ribbon = 0

for line in lines:
    dims = line.split("x")
    x = int(dims[0])
    y = int(dims[1])
    z = int(dims[2])
    side1 = x*y
    side2 = x*z
    side3 = z*y
    circ1 = x*2 + y*2
    circ2 = y*2 + z*2
    circ3 = z*2 + x*2
    smallestSide = min(side1, min(side2, side3))
    smallestCirc = min(circ1, min(circ2, circ3))
    total += side1*2 + side2*2 + side3*2 + smallestSide

    ribbon += smallestCirc + x*y*z

print("answer 1 - " + str(total))
print("answer 2 - " + str(ribbon))
