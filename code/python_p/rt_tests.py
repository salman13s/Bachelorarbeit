import numpy as np # number theroy stuff
from scipy import misc
from scipy import optimize
from scipy.misc import derivative # math stuff 
import matplotlib.pyplot as plt # ploting
import math 
import time 
from random import randint


def bit_length(n): # return the bit size of a non-negative integer
    bits = 0
    while n >> bits: bits += 1
    return bits

def check_pefect_powers(n):

	b = 2

	while 2**b <= n:
		a = 1
		c = n
		while c - a >= 2:
			m = math.floor((a+c)/2)
			p = min([m**b, n + 1])

			if p == n:
				return True
			if p < n:
				a = m
			else:
				c = m
		b = b + 1
	return False	 				



def smallest(n):
	I = max(3,math.floor(math.log2(n)**5))
	r = 2
	while r <= math.floor(I):
		c = 0
		b = math.floor(math.log2(n))**2
		# ord(r,n) = k
		# check for all k's in [1,log^2 n] if n^k != 1(mod r)
		for k in range(1,b):
			if (n**k) % r ==1:
				c = c + 1
		if c ==0:
			break
		# else keep trying successive values of r 	
		r = r + 1			
	return r



def naive_prime(n):
	limit = int(n)
	for i in range(2,limit):
		if n % i == 0:
			return False
	return True		


def expand_x_1(n): 
# This version uses a generator and thus less computations
    c =1
    for i in range(n//2+1):
        c = c*(n-i)//(i+1)
        yield c
 
def naive_aks(p):
    if p==2:
        return True
 
    for i in expand_x_1(p):
        if i % p:
# we stop without computing all possible solutions
            return False
    return True

	



# Runtime complexity plot

x = [i  for i in range(2,200000,100)]
y = []
bl = []
n = 10	
for a in x:
	start = time.process_time()
	# check_pefect_powers(a)
	smallest(a)
	# naive_aks(a)
	end = time.process_time()
	t = end - start
	l = bit_length(a)
	if l not in bl:
		y.append(t)
		bl.append(bit_length(a))

y = sorted(y)

plt.plot(bl,y)
plt.xlabel("n")
plt.ylabel("time")
plt.title("runtime")
plt.show()





