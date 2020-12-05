#!/usr/bin/env python
import re
import sys
import shlex

quotes = shlex.shlex().quotes
index = int(sys.argv[1])
buf = sys.argv[2]
m = re.match(r".*[\s{}](\S*)$".format(quotes), ' ' + buf[:index])
query = m.group(1)
print(buf[:(index - len(m.group(1)))], end='\x00')
print(m.group(1), end='\x00')
print(buf[index:], end='')
