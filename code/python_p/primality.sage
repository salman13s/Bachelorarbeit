############################Packages and imports ###################################### 
import numpy as np
import math
import time
import matplotlib.pyplot as plt 
from sympy import perfect_power
from numpy.polynomial import polynomial as P
from scipy.special import binom
from scipy.optimize import curve_fit
from numpy.random import randint
import warnings
from random import shuffle
import timeit
from sage.all import *
import tkinter as tk

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

##########################################################################################

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

#best test values so far(random large primes) 
# x = [8191,131071,524287,38757413,388903733,38890279,2147483647,2247586547,2547587681,17014120163,170141183297,570141191371]#x = [i  for i in range(2,200000,100)]
# x = [8191,131071,524287,38757413,388903733,38890279,2147483647,2247586547,2547587681,17014120163]
# x = [8191,131071,524287,38757413,58890301,2147483647,2547587681,17014120163,90552556889,170141183297]#,570141191371]#x = [i  for i in range(2,200000,100)]

# y = []
# bl = []
# y_2 = []
# bl_2 = []

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



# we can use the follwing commands to empirically verify the correctness of the aks algorithm
# it is known that there are 25 prime numbers in [2,100):

# nums = [i for i in range(2,100)]

# primes_1_100 = []
# for n in nums:
#     if aks(n):
#         primes_1_100.append(n)

# print("#primes < 100 = {}".format(len(primes_1_100))) # should return 25
# print("primes < 100 = {}".format(primes_1_100))# should list the primes 



# used to record the runtime of the aks and the naive algorithm
# for i in x:
#     s = time.process_time() #start 
#     res = naive_prime(i) # pick any algorithm to record its runtime
#     e = time.process_time() # end 
#     z.append(bit_length(i))
#     t.append(e-s)
#     print("n = {}, bits = {}, result = {}, time = {}".format(i,bit_length(i),res,e-s))

# print(z,t)

#####################################################################################################################################


x_8 =  [128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227]
x_9 = [256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355]
x_10 = [512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611]
x_12 = [2048, 2049, 2050, 2051, 2052, 2053, 2054, 2055, 2056, 2057, 2058, 2059, 2060, 2061, 2062, 2063, 2064, 2065, 2066, 2067, 2068, 2069, 2070, 2071, 2072, 2073, 2074, 2075, 2076, 2077, 2078, 2079, 2080, 2081, 2082, 2083, 2084, 2085, 2086, 2087, 2088, 2089, 2090, 2091, 2092, 2093, 2094, 2095, 2096, 2097, 2098, 2099, 2100, 2101, 2102, 2103, 2104, 2105, 2106, 2107, 2108, 2109, 2110, 2111, 2112, 2113, 2114, 2115, 2116, 2117, 2118, 2119, 2120, 2121, 2122, 2123, 2124, 2125, 2126, 2127, 2128, 2129, 2130, 2131, 2132, 2133, 2134, 2135, 2136, 2137, 2138, 2139, 2140, 2141, 2142, 2143, 2144, 2145, 2146, 2147]
x_13 = [4096, 4097, 4098, 4099, 4100, 4101, 4102, 4103, 4104, 4105, 4106, 4107, 4108, 4109, 4110, 4111, 4112, 4113, 4114, 4115, 4116, 4117, 4118, 4119, 4120, 4121, 4122, 4123, 4124, 4125, 4126, 4127, 4128, 4129, 4130, 4131, 4132, 4133, 4134, 4135, 4136, 4137, 4138, 4139, 4140, 4141, 4142, 4143, 4144, 4145, 4146, 4147, 4148, 4149, 4150, 4151, 4152, 4153, 4154, 4155, 4156, 4157, 4158, 4159, 4160, 4161, 4162, 4163, 4164, 4165, 4166, 4167, 4168, 4169, 4170, 4171, 4172, 4173, 4174, 4175, 4176, 4177, 4178, 4179, 4180, 4181, 4182, 4183, 4184, 4185, 4186, 4187, 4188, 4189, 4190, 4191, 4192, 4193, 4194, 4195]
x_15 = [16384, 16385, 16386, 16387, 16388, 16389, 16390, 16391, 16392, 16393, 16394, 16395, 16396, 16397, 16398, 16399, 16400, 16401, 16402, 16403, 16404, 16405, 16406, 16407, 16408, 16409, 16410, 16411, 16412, 16413, 16414, 16415, 16416, 16417, 16418, 16419, 16420, 16421, 16422, 16423, 16424, 16425, 16426, 16427, 16428, 16429, 16430, 16431, 16432, 16433, 16434, 16435, 16436, 16437, 16438, 16439, 16440, 16441, 16442, 16443, 16444, 16445, 16446, 16447, 16448, 16449, 16450, 16451, 16452, 16453, 16454, 16455, 16456, 16457, 16458, 16459, 16460, 16461, 16462, 16463, 16464, 16465, 16466, 16467, 16468, 16469, 16470, 16471, 16472, 16473, 16474, 16475, 16476, 16477, 16478, 16479, 16480, 16481, 16482, 16483]
x_16 = [32768, 32769, 32770, 32771, 32772, 32773, 32774, 32775, 32776, 32777, 32778, 32779, 32780, 32781, 32782, 32783, 32784, 32785, 32786, 32787, 32788, 32789, 32790, 32791, 32792, 32793, 32794, 32795, 32796, 32797, 32798, 32799, 32800, 32801, 32802, 32803, 32804, 32805, 32806, 32807, 32808, 32809, 32810, 32811, 32812, 32813, 32814, 32815, 32816, 32817, 32818, 32819, 32820, 32821, 32822, 32823, 32824, 32825, 32826, 32827, 32828, 32829, 32830, 32831, 32832, 32833, 32834, 32835, 32836, 32837, 32838, 32839, 32840, 32841, 32842, 32843, 32844, 32845, 32846, 32847, 32848, 32849, 32850, 32851, 32852, 32853, 32854, 32855, 32856, 32857, 32858, 32859, 32860, 32861, 32862, 32863, 32864, 32865, 32866, 32867]
x_17 = [65536, 65537, 65538, 65539, 65540, 65541, 65542, 65543, 65544, 65545, 65546, 65547, 65548, 65549, 65550, 65551, 65552, 65553, 65554, 65555, 65556, 65557, 65558, 65559, 65560, 65561, 65562, 65563, 65564, 65565, 65566, 65567, 65568, 65569, 65570, 65571, 65572, 65573, 65574, 65575, 65576, 65577, 65578, 65579, 65580, 65581, 65582, 65583, 65584, 65585, 65586, 65587, 65588, 65589, 65590, 65591, 65592, 65593, 65594, 65595, 65596, 65597, 65598, 65599, 65600, 65601, 65602, 65603, 65604, 65605, 65606, 65607, 65608, 65609, 65610, 65611, 65612, 65613, 65614, 65615, 65616, 65617, 65618, 65619, 65620, 65621, 65622, 65623, 65624, 65625, 65626, 65627, 65628, 65629, 65630, 65631, 65632, 65633, 65634, 65635]
x_19 = [262144, 262145, 262146, 262147, 262148, 262149, 262150, 262151, 262152, 262153, 262154, 262155, 262156, 262157, 262158, 262159, 262160, 262161, 262162, 262163, 262164, 262165, 262166, 262167, 262168, 262169, 262170, 262171, 262172, 262173, 262174, 262175, 262176, 262177, 262178, 262179, 262180, 262181, 262182, 262183, 262184, 262185, 262186, 262187, 262188, 262189, 262190, 262191, 262192, 262193, 262194, 262195, 262196, 262197, 262198, 262199, 262200, 262201, 262202, 262203, 262204, 262205, 262206, 262207, 262208, 262209, 262210, 262211, 262212, 262213, 262214, 262215, 262216, 262217, 262218, 262219, 262220, 262221, 262222, 262223, 262224, 262225, 262226, 262227, 262228, 262229, 262230, 262231, 262232, 262233, 262234, 262235, 262236, 262237, 262238, 262239, 262240, 262241, 262242, 262243]
x_24 = [1048576, 1048577, 1048578, 1048579, 1048580, 1048581, 1048582, 1048583, 1048584, 1048585, 1048586, 1048587, 1048588, 1048589, 1048590, 1048591, 1048592, 1048593, 1048594, 1048595, 1048596, 1048597, 1048598, 1048599, 1048600, 1048601, 1048602, 1048603, 1048604, 1048605, 1048606, 1048607, 1048608, 1048609, 1048610, 1048611, 1048612, 1048613, 1048614, 1048615, 1048616, 1048617, 1048618, 1048619, 1048620, 1048621, 1048622, 1048623, 1048624, 1048625, 1048626, 1048627, 1048628, 1048629, 1048630, 1048631, 1048632, 1048633, 1048634, 1048635, 1048636, 1048637, 1048638, 1048639, 1048640, 1048641, 1048642, 1048643, 1048644, 1048645, 1048646, 1048647, 1048648, 1048649, 1048650, 1048651, 1048652, 1048653, 1048654, 1048655, 1048656, 1048657, 1048658, 1048659, 1048660, 1048661, 1048662, 1048663, 1048664, 1048665, 1048666, 1048667, 1048668, 1048669, 1048670, 1048671, 1048672, 1048673, 1048674, 1048675]
x_22 = [2097152, 2097153, 2097154, 2097155, 2097156, 2097157, 2097158, 2097159, 2097160, 2097161, 2097162, 2097163, 2097164, 2097165, 2097166, 2097167, 2097168, 2097169, 2097170, 2097171, 2097172, 2097173, 2097174, 2097175, 2097176, 2097177, 2097178, 2097179, 2097180, 2097181, 2097182, 2097183, 2097184, 2097185, 2097186, 2097187, 2097188, 2097189, 2097190, 2097191, 2097192, 2097193, 2097194, 2097195, 2097196, 2097197, 2097198, 2097199, 2097200, 2097201, 2097202, 2097203, 2097204, 2097205, 2097206, 2097207, 2097208, 2097209, 2097210, 2097211, 2097212, 2097213, 2097214, 2097215, 2097216, 2097217, 2097218, 2097219, 2097220, 2097221, 2097222, 2097223, 2097224, 2097225, 2097226, 2097227, 2097228, 2097229, 2097230, 2097231, 2097232, 2097233, 2097234, 2097235, 2097236, 2097237, 2097238, 2097239, 2097240, 2097241, 2097242, 2097243, 2097244, 2097245, 2097246, 2097247, 2097248, 2097249, 2097250, 2097251]
x_23 = [4194304, 4194305, 4194306, 4194307, 4194308, 4194309, 4194310, 4194311, 4194312, 4194313, 4194314, 4194315, 4194316, 4194317, 4194318, 4194319, 4194320, 4194321, 4194322, 4194323, 4194324, 4194325, 4194326, 4194327, 4194328, 4194329, 4194330, 4194331, 4194332, 4194333, 4194334, 4194335, 4194336, 4194337, 4194338, 4194339, 4194340, 4194341, 4194342, 4194343, 4194344, 4194345, 4194346, 4194347, 4194348, 4194349, 4194350, 4194351, 4194352, 4194353, 4194354, 4194355, 4194356, 4194357, 4194358, 4194359, 4194360, 4194361, 4194362, 4194363, 4194364, 4194365, 4194366, 4194367, 4194368, 4194369, 4194370, 4194371, 4194372, 4194373, 4194374, 4194375, 4194376, 4194377, 4194378, 4194379, 4194380, 4194381, 4194382, 4194383, 4194384, 4194385, 4194386, 4194387, 4194388, 4194389, 4194390, 4194391, 4194392, 4194393, 4194394, 4194395, 4194396, 4194397, 4194398, 4194399, 4194400, 4194401, 4194402, 4194403]
x_24 = [8388608, 8388609, 8388610, 8388611, 8388612, 8388613, 8388614, 8388615, 8388616, 8388617, 8388618, 8388619, 8388620, 8388621, 8388622, 8388623, 8388624, 8388625, 8388626, 8388627, 8388628, 8388629, 8388630, 8388631, 8388632, 8388633, 8388634, 8388635, 8388636, 8388637, 8388638, 8388639, 8388640, 8388641, 8388642, 8388643, 8388644, 8388645, 8388646, 8388647, 8388648, 8388649, 8388650, 8388651, 8388652, 8388653, 8388654, 8388655, 8388656, 8388657, 8388658, 8388659, 8388660, 8388661, 8388662, 8388663, 8388664, 8388665, 8388666, 8388667, 8388668, 8388669, 8388670, 8388671, 8388672, 8388673, 8388674, 8388675, 8388676, 8388677, 8388678, 8388679, 8388680, 8388681, 8388682, 8388683, 8388684, 8388685, 8388686, 8388687, 8388688, 8388689, 8388690, 8388691, 8388692, 8388693, 8388694, 8388695, 8388696, 8388697, 8388698, 8388699, 8388700, 8388701, 8388702, 8388703, 8388704, 8388705, 8388706, 8388707]
x_25 = [16777216, 16777217, 16777218, 16777219, 16777220, 16777221, 16777222, 16777223, 16777224, 16777225, 16777226, 16777227, 16777228, 16777229, 16777230, 16777231, 16777232, 16777233, 16777234, 16777235, 16777236, 16777237, 16777238, 16777239, 16777240, 16777241, 16777242, 16777243, 16777244, 16777245, 16777246, 16777247, 16777248, 16777249, 16777250, 16777251, 16777252, 16777253, 16777254, 16777255, 16777256, 16777257, 16777258, 16777259, 16777260, 16777261, 16777262, 16777263, 16777264, 16777265, 16777266, 16777267, 16777268, 16777269, 16777270, 16777271, 16777272, 16777273, 16777274, 16777275, 16777276, 16777277, 16777278, 16777279, 16777280, 16777281, 16777282, 16777283, 16777284, 16777285, 16777286, 16777287, 16777288, 16777289, 16777290, 16777291, 16777292, 16777293, 16777294, 16777295, 16777296, 16777297, 16777298, 16777299, 16777300, 16777301, 16777302, 16777303, 16777304, 16777305, 16777306, 16777307, 16777308, 16777309, 16777310, 16777311, 16777312, 16777313, 16777314, 16777315]
x_27 = [67108864, 67108865, 67108866, 67108867, 67108868, 67108869, 67108870, 67108871, 67108872, 67108873, 67108874, 67108875, 67108876, 67108877, 67108878, 67108879, 67108880, 67108881, 67108882, 67108883, 67108884, 67108885, 67108886, 67108887, 67108888, 67108889, 67108890, 67108891, 67108892, 67108893, 67108894, 67108895, 67108896, 67108897, 67108898, 67108899, 67108900, 67108901, 67108902, 67108903, 67108904, 67108905, 67108906, 67108907, 67108908, 67108909, 67108910, 67108911, 67108912, 67108913, 67108914, 67108915, 67108916, 67108917, 67108918, 67108919, 67108920, 67108921, 67108922, 67108923, 67108924, 67108925, 67108926, 67108927, 67108928, 67108929, 67108930, 67108931, 67108932, 67108933, 67108934, 67108935, 67108936, 67108937, 67108938, 67108939, 67108940, 67108941, 67108942, 67108943, 67108944, 67108945, 67108946, 67108947, 67108948, 67108949, 67108950, 67108951, 67108952, 67108953, 67108954, 67108955, 67108956, 67108957, 67108958, 67108959, 67108960, 67108961, 67108962, 67108963]




# random shuffle 
shuffle(x_8)
shuffle(x_9)
shuffle(x_10)
shuffle(x_12)
shuffle(x_13)
shuffle(x_15)
shuffle(x_16)
shuffle(x_17)
shuffle(x_19)
shuffle(x_22)
shuffle(x_23)
shuffle(x_24)
shuffle(x_25)
shuffle(x_27)
# # # x = [33,63,128,513,4096,262145,2097155,30097115,294024210,2147483647]
# data

# extend the data 
xData = []
xData.extend([x_8,x_9,x_10,x_12,x_13,x_15,x_16,x_17,x_19,x_22,x_23,x_24,x_25,x_27])
# xData.extend(x_8)
# xData.extend(x_9)
# xData.extend(x_10)
# xData.extend(x_12)
# xData.extend(x_13)
# xData.extend(x_15)
# xData.extend(x_16)
# xData.extend(x_17)
# xData.extend(x_19)
# xData.extend(x_22)
 

# ignore Rankwarning error 
with warnings.catch_warnings():
    warnings.simplefilter('ignore', np.RankWarning)




    

tupels = []
# measure the run time
yData = []
for i in xData:
    for j in i:
        s = time.process_time()
        result = aks(j)
        e = time.process_time()
        tupels.append((bit_length(j),e - s)) # collect run times for each input length
        t = e - s
        yData.append(t)


#gather the max. run time of each input length
# t_8 = max([i[1] for i in tupels if i[0] == 8])
# t_9 = max([i[1] for i in tupels if i[0] == 9])
# t_10 = max([i[1] for i in tupels if i[0] == 10])
# t_12 = max([i[1] for i in tupels if i[0] == 12])
# t_13 = max([i[1] for i in tupels if i[0] == 13])
# t_15 = max([i[1] for i in tupels if i[0] == 15])
# t_16 = max([i[1] for i in tupels if i[0] == 16])
# t_17 = max([i[1] for i in tupels if i[0] == 17])
# t_19 = max([i[1] for i in tupels if i[0] == 19])
# t_22 = max([i[1] for i in tupels if i[0] == 22])
# t_23 = max([i[1] for i in tupels if i[0] == 23])
# t_24 = max([i[1] for i in tupels if i[0] == 24])
# t_25 = max([i[1] for i in tupels if i[0] == 25])
# t_27 = max([i[1] for i in tupels if i[0] == 27])


# worst_case_runtimes = []
# worst_case_runtimes.extend([t_8,t_9,t_10,t_12,t_13,t_15,t_16,t_17,t_19,t_22,t_23,t_24,t_25,t_27])
# print(worst_case_runtimes)


# seperate the data

x_8_t = []
x_9_t = []
x_10_t = []
x_12_t = []
x_13_t = []
x_15_t = []
x_16_t = []
x_17_t = []
x_19_t = []
x_22_t = []
x_23_t = []
x_24_t = []
x_25_t = []
x_27_t = []
for element in tupels:
    if element[0] == 8:
        x_8_t.append(element[1])
    if element[0] == 9:
        x_9_t.append(element[1])
    if element[0] == 10:
        x_10_t.append(element[1])
    if element[0] == 12:
        x_12_t.append(element[1])
    if element[0] == 13:
        x_13_t.append(element[1])
    if element[0] == 15:
        x_15_t.append(element[1])
    if element[0] == 16:
        x_16_t.append(element[1])
    if element[0] == 17:
        x_17_t.append(element[1])
    if element[0] == 19:
        x_19_t.append(element[1])                               
    if element[0] == 22:
        x_22_t.append(element[1])
    if element[0] == 23:
        x_23_t.append(element[1])
    if element[0] == 24:
        x_24_t.append(element[1])
    if element[0] == 25:
        x_25_t.append(element[1])
    if element[0] == 27:
        x_27_t.append(element[1])                   


x_i_t = []
x_i_t.extend([x_8_t,x_9_t,x_10_t,x_12_t,x_13_t,x_15_t,x_16_t,x_17_t,x_19_t,x_22_t,x_23_t,x_24_t,x_25_t,x_27_t])
means = []

for i in x_i_t:
    means.append(np.mean(i))

xData_bits =[] # input lenght

for i in xData:
    for j in i:
        xData_bits.append(bit_length(j))

xData_bits = np.array(xData_bits) # run-time 

xData_bits_reduced =  list(set(xData_bits))



# remark: x-axis = log n(input length), y-axis = O^(7+ e)(log n), e > 0.  

# first fitting approach 
def p(x,a,b,c,d,e,f,g,h,i,j,k):
    return a * x**(10.5) + b * x**9 + c * x**8 + d * x**7 + e * x**6 + f * x**5 + g * x**4 + h * x**3 + i * x**2 + j * x + k


popt,pcov = curve_fit(p,xData_bits,yData)



plt.plot(xData_bits,p(xData_bits,*popt),'r',label='polynomial')
plt.plot(xData_bits,yData,'bo',label='data points')
plt.plot(xData_bits_reduced,means,'g--',label = 'mean')   

# worst case
# z = np.polyfit(xData_bits_reduced,worst_case_runtimes,10.5) # deg has to be 7 (more or less)
# p = np.poly1d(z)
# plt.plot(xData_bits_reduced,worst_case_runtimes,'c^',label ='worst-case')
# plt.plot(xData_bits_reduced,p(xData_bits_reduced),'m:',label ='polynomial-worst-case')


plt.title('AKS average complexity')
plt.xlabel('log n')
plt.ylabel('time required[s]')
plt.legend()
plt.show()



