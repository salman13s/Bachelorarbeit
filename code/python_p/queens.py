import random

def create_matrix(n): # creat a n x n matrix
	matrix = [[ 0 for x in range(n)] for y in range(n)]
	return matrix		



def create_queen_randomly(M): # n is the board size and m is the number of queens
	x = random.randint(0,100) % len(M)
	y = random.randint(0,100) % len(M)
	M[x][y] = 1

	return M

def print_matrix(M,):
	for i in range(len(M)):
		for j in range(len(M)):
			print(M[i][j], end=' ')
		print()	

def find_queen(M):
	for i in range(len(M)):
		for j in range(len(M)):
			if M[i][j] == 1:
				return (i,j)

def under_attack(M):
	queen_pos = find_queen(M)
	sum_pos = queen_pos[0] + queen_pos[1]
	under_attack = []
	for i in range(len(M)):
		for j in range(len(M)):
			# horizontal nodes under attack
			if i == queen_pos[0]:
				ua = (i,j)
				if ua != queen_pos:
					under_attack.append(ua)
			# vertical nodes under attack		
			if j == queen_pos[1]:
				ua = (i,j)
				if ua != queen_pos:
					under_attack.append(ua)
			# diagonal nodes under attack		
			if i + j == sum_pos or i - j ==sum_pos:
				ua = (i,j)
				if ua != queen_pos:
					under_attack.append(ua)		


	return under_attack				


def mark_under_attack(under_attack,M):
	l = len(under_attack)
	for obj in under_attack:
		i = obj[0]
		j = obj[1]
		M[i][j] = 2
	return M	
			
def place_queens():
	return


n =10
M = create_matrix(n)
m = create_queen_randomly(M)

print_matrix(M)
print(find_queen(M))

ua = under_attack(M)

M_p = mark_under_attack(ua,M)

print_matrix(M_p)	
	

	
		



