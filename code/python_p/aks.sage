
import numpy as np
import math
import time
import matplotlib.pyplot as plt 
from sympy import perfect_power
from numpy.polynomial import polynomial as P
from scipy.special import binom
from numpy.random import randint
import timeit
from sage.all import *


"""
gcd: N x N - > N 
calculates the gcd of 2 numbers using euclid's algorithm
"""
def gcd(a,b):
	if b == 0:
		return a
	return gcd(b,a % b)	


"""
calculates the remainder of the polynomial division poly/r
"""
def polyRemainder(poly,r):
    x = np.array(poly)
    y = np.zeros(r+1)
    y[0] = 1
    y[r] = -1
    print(y)
    res = np.polydiv(x,y)

    return res[1]

# tested against the wolframalpha ord function
""" calculates the multiplicative order of r mod n"""
def ordr(r,n):
	if gcd(r,n) != 1:
		return -1

	result = 1

	k = 1

	while (k < n):
		result = (result * r) % n

		if (result == 1):
			return k

		k = k + 1	

	return -1		




def find_r(n):
    limit = int(np.ceil((np.log2(n)) ** 2))

    r = 2
    while 1:
        found = True
        for k in range(1, limit):
            if n % r == 1:
                found = False
                break
        if found:
            return r
        r += 1

def smallest(n):
	m = max(3,math.floor(math.log2(n)**5))
	r = 2
	while r <= math.floor(m):
		c = 0
		b = math.floor(math.log2(n))**2
		for k in range(1,b):
			if (n**k) % r ==1:
				c = c + 1
		if c ==0:
			break
		r = r + 1			
	return r
		
def check_perfect_power(n):
	if perfect_power(n) == False:
		return False
	else:
		return True	


	

#############################################################################

# x = []
# y = []
# for i in range(0,20001,100):
# 	start = time.process_time()
# 	aks_test(i)
# 	end = time.process_time()
# 	t = end - start
# 	y.append(t)
	
	
# x=[i for i in range(0,20001,100)]



# plt.xlabel("n")
# plt.ylabel("Time required")
# plt.plot(x,y)
# plt.show()



def aks_2(n):
    if n < 2:
        return
    #STEP 1    
    if check_perfect_power(n) == True:
        return False
    #STEP 2    
    r = smallest(n)

    #STEP 3
    for k in range(1,r):
        if 1 < gcd(k,n) and gcd(k,n) < n:
            return False
    #STEP 4        
    if n <= r:
        return True
    #STEP 5
    l=floor((2*sqrt(euler_phi(r))*log(n,2)+1))
    for a in range(1,l):
        s =Integers(n) # define n in Z_n 
        R.<x> = PolynomialRing(s) # define the polynomial ring
        F = R.quotient((x^r)-1)
        q = F((x+a))
        V = F((q^n))
        e = Mod(n,r)
        d = (x^e) + a
        if (V != d):
            return False
    return True            



for i in range(100):
    if aks_2(i):
        print(i)

