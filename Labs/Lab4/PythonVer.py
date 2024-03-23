import time
from math import cos, sin, exp

x = float(input('Input x: '))

start_time = time.time()
res_arr: list = []

for j in range(100000):
    for i in range(-1, 3):
        xmod = x + i
        res_arr.append((cos(xmod) + sin(xmod))/exp(xmod))
    res = max(res_arr)

print(res)

end_time = time.time()
duration = end_time - start_time
print("Execution Time:", duration, "seconds")
