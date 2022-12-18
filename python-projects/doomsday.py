import sys
import queue

#Ypologizw to N
N = 0
M = 0
with open(sys.argv[1],"r") as f:
    for line in f:
        N = N + 1
		
f.close()

#Ypologizw to M
M = 0
with open(sys.argv[1],"r") as f:
    for line in f:
        M = (len(line))

#Diastaseis pinaka pou tha dhmiourgisw
N = N + 2
M = M + 1

f.close()

#Dimiouria pinaka
A = [["X" for x in range(M)] for y in range(N)]

#Voithikoi metrites
counter_in = 0
counter_out = 0
timer = 1

#Simplirwsi pinaka
i = 1
j = 1
with open(sys.argv[1],"r") as f:
	for line in f:  
		for ch in line:
			if ch != "\n":
				A[i][j] = ch
				j = j + 1
		j = 1
		i = i + 1
		
f.close()

#print (N)
#print (M)

#Dimiourgia ourwn gia na krataw tis theseis twn "+" kai "-"
q_i = queue.Queue()
q_j = queue.Queue()

#Voithitikes oures
bq_i = queue.Queue()
bq_j = queue.Queue()

i = 1
j = 1
while (i < N - 1):
	while (j < M - 1):
		if A[i][j] != "X" and A[i][j] != ".":
			q_i.put(i)
			q_j.put(j)
			counter_out = counter_out + 1
			j = j + 1
		j = j + 1
	j = 1
	i = i + 1

#Flags
flag = 0
boom = 0

#Solve
while (not q_i.empty() and flag == 0):
	while (counter_out != 0 and flag == 0):
		while (counter_out != 0):
			i = q_i.get()
			j = q_j.get()
			counter_out = counter_out - 1
			
			if (A[i][j] == "+"):
				if (A[i + 1][j] == "."):
					A[i + 1][j] = "+"
					q_i.put(i + 1)
					q_j.put(j)
					counter_in = counter_in + 1;
				elif (A[i + 1][j] == "-"):
					bq_i.put(i + 1)
					bq_j.put(j)
					boom = 1
				else:
					A[i + 1][j] = A[i + 1][j]
					
				if (A[i - 1][j] == "."):
					A[i - 1][j] = "+"
					q_i.put(i - 1)
					q_j.put(j)
					counter_in = counter_in + 1
				elif (A[i - 1][j] == "-"):
					bq_i.put(i - 1)
					bq_j.put(j)
					boom = 1
				else:
					A[i - 1][j] = A[i - 1][j]
					
				if (A[i][j + 1] == "."):
					A[i][j + 1] = "+"
					q_i.put(i)
					q_j.put(j + 1)
					counter_in = counter_in + 1;
				elif (A[i][j + 1] == "-"):
					bq_i.put(i)
					bq_j.put(j + 1)
					boom = 1
				else:
					A[i][j + 1] = A[i][j + 1]
					
				if (A[i][j - 1] == "."):
					A[i][j - 1] = "+"
					q_i.put(i)
					q_j.put(j - 1)
					counter_in = counter_in + 1
				elif (A[i][j - 1] == "-"):
					bq_i.put(i)
					bq_j.put(j - 1)
					boom = 1
				else:
					A[i][j - 1] = A[i][j - 1]
					
			else:
				if (A[i + 1][j] == "."):
					A[i + 1][j] = "-"
					q_i.put(i + 1)
					q_j.put(j)
					counter_in = counter_in + 1
				elif (A[i + 1][j] == "+"):
					bq_i.put(i + 1)
					bq_j.put(j)
					boom = 1
				else:
					A[i + 1][j] = A[i + 1][j]
					
				if (A[i - 1][j] == "."):
					A[i - 1][j] = "-"
					q_i.put(i - 1)
					q_j.put(j)
					counter_in = counter_in + 1
				elif (A[i - 1][j] == "+"):
					bq_i.put(i - 1)
					bq_j.put(j)
					boom = 1
				else:
					A[i - 1][j] = A[i - 1][j]
					
				if (A[i][j + 1] == "."):
					A[i][j + 1] = "-"
					q_i.put(i)
					q_j.put(j + 1)
					counter_in = counter_in + 1;
				elif (A[i][j + 1] == "+"):
					bq_i.put(i)
					bq_j.put(j + 1)
					boom = 1
				else:
					A[i][j + 1] = A[i][j + 1]	
					
				if (A[i][j - 1] == "."):
					A[i][j - 1] = "-"
					q_i.put(i)
					q_j.put(j - 1)
					counter_in = counter_in + 1
				elif (A[i][j - 1] == "+"):
					bq_i.put(i)
					bq_j.put(j - 1)
					boom = 1
				else:
					A[i][j - 1] = A[i][j - 1]
					
		while (not bq_i.empty()):
			i = bq_i.get()
			j = bq_j.get()
			A[i][j] = "*"
			
		if (boom == 1):
			flag = boom
		else:
			counter_out = counter_in
			counter_in = 0
			timer = timer + 1
		
		
#Ektipwsi pinaka
if(flag == 1):
	print(timer)
else:
	print("the world is saved")

	
i = 1
j = 1
while (i < N - 1):
	while (j < M - 1):
		print(A[i][j], end='')
		j = j + 1
	print()
	j = 1
	i = i + 1
	


