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
check for perfect powers, i.e. n = a^b, for some a,b £ N 
"""

def check_perfect_power(n):

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

"""
 a function to find the smalles r,
such that n^k != 1 (mod r), for all k <= log^2 n
"""
def find_r(n):
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
    #STEP 1    
    if check_perfect_power(n) == True:
        return False
    #STEP 2    
    r = find_r(n)

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
        s =Integers(n) # define s in Z_n 
        R.<x> = PolynomialRing(s) # define the polynomial ring
        Q = R.quotient((x^r)-1) # quotient ring Q = Z_n\(X^r - 1)
        q = Q((x+a)) # representation of x + a in the Quotient ring Q  
        V = Q((q^n)) # (x + a)^n in Q
        e = Mod(n,r) #  e = n mod r
        d = (x^e) + a # x^e + a, i.e exponents reduction
        if (V != d): # if (x + a)^n != x^e + a -> COMPOSITE  
            return False
    return True #STEP 6           


# naive primality test
def naive_prime(n):
    limit = int(n)
    for i in range(2,limit):
        if n % i == 0:
            return False
    return True     



#### Time-Complexity_Analysis ############################################################

#return the bit size of a non-negative integer
def bit_length(n):
    bits = 0
    while n >> bits: bits += 1
    return bits

#best test values so far 
# x = [8191,131071,524287,38757413,388903733,38890279,2147483647,2247586547,2547587681,17014120163,170141183297,570141191371]#x = [i  for i in range(2,200000,100)]
# x = [8191,131071,524287,38757413,388903733,38890279,2147483647,2247586547,2547587681,17014120163]
x = [8191,131071,524287,38757413,58890301,2147483647,2547587681,17014120163,90552556889,170141183297]#,570141191371]#x = [i  for i in range(2,200000,100)]

y = []
bl = []
y_2 = []
bl_2 = []

# for a in x:
#     start = time.process_time()
   
#     aks(a)
    
#     end = time.process_time()
#     t = end - start
#     l = bit_length(a)
#     if l not in bl:
#         y.append(t)
#         bl.append(l)

# for a in x:
#     start = time.process_time()
#     naive_prime(a)
#     end = time.process_time()
#     t = end - start
#     l = bit_length(a)
#     if l not in bl_2:
#         y_2.append(t)
#         bl_2.append(l)



# ############################### Plotting #################################################


z = []

t = []

# print(bl,y)

# print(bl_2,y_2)
# # y = sorted(y)

# plt.plot(bl,y,bl_2,y_2)
# plt.xlabel("#Bits")
# plt.ylabel("required time")
# plt.title("AKS")
# plt.show()



# we can use the follwing command to empirically verify the correctness of the aks algorithm
# it is known that there are 25 prime numbers in [2,100):

nums = [i for i in range(2,100)]

primes_1_100 = []
for n in nums:
    if aks(n):
        primes_1_100.append(n)

print("#primes < 100 = {}".format(len(primes_1_100))) # should return 25
print("primes < 100 = {}".format(primes_1_100))# should list the primes 



# used to record the runtime of the aks and the naive algorithm
# for i in x:
#     s = time.process_time() #start 
#     res = naive_prime(i) # pick any algorithm to record its runtime
#     e = time.process_time() # end 
#     z.append(bit_length(i))
#     t.append(e-s)
#     print("n = {}, bits = {}, result = {}, time = {}".format(i,bit_length(i),res,e-s))

# print(z,t)




