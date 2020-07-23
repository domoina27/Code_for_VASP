#!/usr/bin/env python

import os
import matplotlib.pyplot as plt

os.popen("grep -a entropy= OUTCAR > iteration.txt")
os.popen("sleep 2s")

data = open("iteration.txt",  "r")
fig = plt.figure()
ax = fig.add_subplot(111)
lines = data.readlines()
E = [float(line.split('  ')[4]) for line in lines]
i = list(range(len(lines)))

line1 = plt.plot(i,E,'go-', label = 'Convergence Progress')
plt.title('Convergence progress', fontdict= {'fontname':'DejaVu Sans', 'fontsize': '20'})
plt.xlabel('Number of iterations', fontdict = {'fontname': 'DejaVu Sans', 'fontsize': '16'})
plt.ylabel('Total energy', fontdict = {'fontname': 'Arial','fontsize':'16'})

plt.show()
