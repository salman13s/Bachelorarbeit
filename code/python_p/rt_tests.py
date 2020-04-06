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



def naive_prime(n):
	limit = int(n)
	for i in range(2,limit):
		if n % i == 0:
			return False
	return True		


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

	

def brute_force_prime_test(n):
    if n < 2:
        return False
    for i in range(2, int(math.sqrt(n)) + 1):
        if n % i == 0:
            return False
    return True

# Runtime complexity plot

# x = [i  for i in range(2,100000000000,200)]
# y = []
# bl = []
# y_2 = []
# bl_1 = []
# n = 10	

# for a in x:
# 	start = time.process_time()
# 	check_perfect_powers(a)
# 	#find_r(a)
# 	# naive_aks(a)
# 	end = time.process_time()
# 	t = end - start
# 	l = bit_length(a)
# 	if l not in bl:
# 		y.append(t)
# 		bl.append(l)



# y = sorted(y)


# print(bl)
# print(y)


#############################################################################

#Test results for AKS vs Naive
x = [13, 17, 19, 26, 29, 31, 32, 34]; # input length
# aks
y = [0.3012730000000001, 1.076172, 1.5995600000000003, 7.705483, 23.567881, 43.665376, 45.481381999999996, 82.56921599999998];
#naive 
y2= [0.0005449999999882493, 0.008898999999985335, 0.03522099999997863, 2.7159679999999753, 27.237017000000037, 152.65455300000002, 160.04647300000005, 1201.7844949999999];


plt.subplot(2, 1, 1)
plt.title("AKS vs Naive ")
plt.plot(x,y,'tab:green')
plt.ylabel("required time")


plt.subplot(2, 1, 2)
plt.plot(x,y2,'tab:red')
plt.xlabel("#Bits")
plt.ylabel("required time")

plt.legend()
plt.show()

##################################################################################################

# plt.plot(bl,y)
# plt.xlabel("#Bits")
# plt.ylabel("required time")
# plt.title("find_r")
# plt.show()


