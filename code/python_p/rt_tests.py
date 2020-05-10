import numpy as np # number theroy stuff
from scipy import misc
from scipy import optimize
from scipy.misc import derivative # math stuff 
import matplotlib.pyplot as plt # ploting
import math 
import time 
from random import randint
from sympy import perfect_power


# return the bit size of a non-negative integer
def bit_length(n): 
    bits = 0
    while n >> bits: bits += 1
    return bits


# an efficient perfect-power test, that runs in O~(log^3n)
def check_perfect_powers(n):

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


# STEP 2 of the AKS-Algorithm
def find_r(n):
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






# naive AKS: the rossetta code python variant of the introductory lemma in the aks-paper (lemma 2.1)
def expand_x_1(n): 
    c =1
    for i in range(n//2+1):
        c = c*(n-i)//(i+1)
        yield c
 
def naive_aks(p):
    if p==2:
        return True
 
    for i in expand_x_1(p):
        if i % p:
            return False
    return True
#######################################
	
# trial division algorithm for primality testing
#p.s. runs in O(sqrt(n))
def naive_prime(n):
    limit = int(n)
    for i in range(2,limit):
        if n % i == 0:
            return False
    return True


print(find_r(32))
		
# Runtime complexity plot

x = [i  for i in range(2,280000,100)]
y = []
bl = []
y_2 = []
bl_1 = []
n = 10	

for a in x:
	start = time.process_time()
	find_r(a)
	#find_r(a) # pick any algorithm, and test its runtime
	# naive_aks(a)
	end = time.process_time()
	t = end - start
	l = bit_length(a)
	if l not in bl:
		y.append(t)
		bl.append(l)



g = [i**2 for i in bl]
y = sorted(y)


print(bl)
print(y)


#############################################################################

#Test: AKS vs Naive
# x = [13, 17, 19, 26, 29, 31, 32, 34,37]; # input length
# # aks
# y = [0.3012730000000001, 1.076172, 1.5995600000000003, 7.705483, 23.567881, 43.665376, 45.481381999999996, 82.56921599999998,97.769072];
# #naive 
# y2= [0.0005449999999882493, 0.008898999999985335, 0.03522099999997863, 2.7159679999999753, 27.237017000000037, 152.65455300000002, 160.04647300000005, 1201.7844949999999,6732.12];


# #embedded
# plt.title("AKS vs Naive ")
# plt.plot(x,y,label="AKS")
# plt.plot(x,y2,label="Naive")
# plt.xlabel("#Bits")
# plt.ylabel("required time")

#subplots 
# plt.subplot(2, 1, 1)
# plt.title("AKS vs Naive ")
# plt.plot(x,y,'tab:green')
# plt.ylabel("required time")


# plt.subplot(2, 1, 2)
# plt.plot(x,y2,'tab:red')
# plt.xlabel("#Bits")
# plt.ylabel("required time")

#this should stay uncommented in both cases(embedded & subplot)
# plt.legend()
# plt.show()

##################################################################################################




##################################################################################################

#tests 
plt.plot(bl,y)
plt.plot(bl,g)
plt.xlabel("#Bits")
plt.ylabel("required time")
plt.title("test")
plt.legend()
plt.show()


