############################Packages and imports ###################################### 
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



################ Helper Functions #####################################################
"""
gcd: N x N - > N 
calculates the gcd of 2 numbers using euclid's algorithm
"""
def gcd(a,b):
	if b == 0:
		return a
	return gcd(b,a % b)	



"""
check_for_perfect powers using the perfect power function of sympy
"""
def check_perfect_power(n):
    if perfect_power(n) == False:
        return False
    else:
        return True 

"""
 a function to find the smalles r,
such that n^k != 1 (mod r), for all k <= log^2 n
"""
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
		




##### The-Algorithm #############################################################

def aks(n):
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
        Q = R.quotient((x^r)-1) # quotient ring Z\(X^r - 1)
        q = Q((x+a)) # representation of x + a in the Quotient ring Q  
        V = Q((q^n)) # (x + a)^n in Q
        e = Mod(n,r) #  e = n mod r
        d = (x^e) + a # x^e + a
        if (V != d): # if (x + a)^n = x^e + a -> COMPOSITE  
            return False
    return True            




#### Time-Complexity_Analysis ############################################################

#return the bit size of a non-negative integer
def bit_length(n):
    bits = 0
    while n >> bits: bits += 1
    return bits

#best test values so far 
x = [i  for i in range(2,200000,100)]
y = []
bl = []
n = 10  
for a in x:
    start = time.process_time()
    # check_pefect_powers(a)
    aks(a)
    end = time.process_time()
    t = end - start
    l = bit_length(a)
    if l not in bl:
        y.append(t)
        bl.append(bit_length(a))



############################### Plotting #################################################


y = sorted(y)

plt.plot(bl,y)
plt.xlabel("n")
plt.ylabel("required time")
plt.title("#Bits")
plt.show()

##Tests##

"""
First-Test: check_perfect_power
"""
# test_set = [i for i in range(10)]

# for m in test_set:
#     s = time.process_time()
#     check_perfect_power(m)
#     e = time.process_time()


#     if check_perfect_power(m):
#         print("{} is a perfect power with {}, time: {}".format(m,perfect_power(m),e-s))







