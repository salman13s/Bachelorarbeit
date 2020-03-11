import math
import numpy as np 
import random
import timeit
from datetime import datetime



def binarySearchHelper(array, target,left,right):
	middle = (left + right)//2

	if left > right:
		return -1

	if array[middle] == target:
		return middle

	if target > array[middle]:
		return binarySearchHelper(array,target,middle+1	,right)
		
	elif target < array[middle]:
		return binarySearchHelper(array,target,left,middle-1)
	


# test case 1 
a = [2,45,61,1,2,5,5,110,9,10,110,8,1,2,3,100]

#test case 2 
b = [12,4,42,15,2151,2521,32,11,21,2,1232,32,11,11]



def remove_duplicates(a):
	a = sorted(a)
	tmp = []
	for i in range(len(a)-1):
		if a[i] != a[i+1]:
			tmp.append(a[i])	

	tmp.append(a[len(a)-1])		
	return tmp
	

			



def bubbleSort(array):
	isSorted = False

	while not isSorted:
		isSorted = True
		for i in range(len(array)- 1):
			if array[i] > array[i+1]:
				swap(i,i+1,array)
				isSorted = False
	return array


def swap(a,b,array):
	tmp = a
	a = b
	b =tmp
	array[a] = array[b]		



def merge_lists(a,b):
	ptr1 = 0
	ptr2 = 0
	c = []
	while len(a) != 0 and b != 0:
		if a[0] < b[0]:
			c.append(a[0])
			a.remove(a[0])
		else:
			c.append(b[0])
			b.remove(b[0])

	while len(a) !=0:
		c.append(a[0])
		a.remove(a[0])

	while len(b) !=0:
		c.append(b[0])
		b.remove(b[0])	
	return c


print(merge_lists([10,27,90,99],[1,6,70,999]))			 	
		

