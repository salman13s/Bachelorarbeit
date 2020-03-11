
import numpy as np
import math
import time
import matplotlib.pyplot as plt 
from sympy import perfect_power
from numpy.polynomial import polynomial as P
from scipy.special import binom
from numpy.random import randint
import timeit


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


def fast_power_poly(base, power, r, Z_n):
    result = 1
    while power > 0:
        # If power is even
        if power % 2 == 0:
            # Divide the power by 2
            power = power / 2
            # Multiply base to itself
            base = P.polymul(base, base)
            #base = P.polydiv(square, modulus)[1]
            # base = base mod (x^r-1)
            x = np.nonzero(result)[0]
            for i in x[x>=r]:
                if base[i] != 0:
                    base[i % r] += base[i]
                    base[i] = 0
            # Keep the coefficients in Z_n
            base = base % Z_n
        else:
            # Decrement the power by 1 and make it even
            power = power - 1
            # Take care of the extra value that we took out
            # We will store it directly in result
            result = P.polymul(result, base)
            #result = P.polydiv(mult, modulus)[1]
            #print(np.nonzero(result))
            x = np.nonzero(result)[0]
            for i in x[x>=r]:
                #print(i)
                if result[i] != 0:
                    result[i % r] += result[i]
                    result[i] = 0
            # Keep the coefficients in Z_n
            result = result % Z_n

            # Now power is even, so we can follow our previous procedure
            power = power / 2
            base = P.polymul(base, base)
            #base = P.polydiv(square, modulus)[1]
            x = np.nonzero(result)[0]
            for i in x[x>=r]:
                if base[i] != 0:
                    base[i % r] += base[i]
                    base[i] = 0
            # Keep the coefficients in Z_n
            base = base % Z_n

    return result

# x = [2,2,4,15,11]
# for i in x:
print(find_r(5),smallest(5))

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
	limit = int(np.ceil(math.sqrt(r-1) * np.log2(n)))
	for a in range(1, limit):
		base = [a, 1]
		coefficients = fast_power_poly(base, n, r, n)
		check = np.zeros(len(coefficients))
		check[n % r] = 1
		check[0] = a
		if not (check == coefficients).all():
			return False

	return True	

#############################################################################
# inefficient algorithm to calculate prime numbers
def expand_x_1(p):
    ex = [1]
    for i in range(p):
        ex.append(ex[-1] * -(p-i) / (i+1))
    return ex[::-1]
 
def aks_test(p):
    if p < 2: return False
    ex = expand_x_1(p)
    ex[0] += 1
    return not any(mult % p for mult in ex[0:-1])
 
 
print('# p: (x-1)^p for small p')
for p in range(12):
    print('%3i: %s' % (p, ' '.join('%+i%s' % (e, ('x^%i' % n) if n else '')
                                   for n,e in enumerate(expand_x_1(p)))))
 
print('\n# small primes using the aks test')
print([p for p in range(101) if aks_test(p)])
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



# def aks_2(n):
#     if n < 2:
#         return
#     #STEP 1    
#     if check_perfect_power(n) == True:
#         return False
#     #STEP 2    
#     r = smallest(n)

#     #STEP 3
#     for k in range(1,r):
#         if 1 < gcd(k,n) and gcd(k,n) < n:
#             return False
#     #STEP 4        
#     if n <= r:
#         return True
#     #STEP 5
#     l=floor((2*sqrt(euler_phi(r))*log(n,2)+1))
#     for a in range(1,l):
#         s =Integers(n)
#         R = PolynomialRing(s)
#         F = R.quotient((x^r)-1)
#         q = F((x+a))
#         V = F((q^n))
#         e = Mod(n,r)
#         d = (x^e) + a
#         if (V != d):
#             return False
#     return True            


print(ordr(2,3))

