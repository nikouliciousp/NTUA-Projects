import collections
import sys
import queue

with open(sys.argv[1],"r") as f:
	N = int(f.readline())
	Teams = []
	for i in range(N):
		team, p, a, b = map(str, f.readline().split())
		Teams.append((team, int(p), int(a), int(b)))
	
f.close()
print(Teams)

Q = collections.deque()

class StateTeam:
	def __init__(self, team, outgoals, ingoals):
		self.team = team
		self.outgoals = outgoals
		self.ingoals = ingoals

Teams.sort(key=lambda x: x[1])
print(Teams)
		
#for i in range(N):
#	if (Teams[i][1] == 1):
#		Q.append(StateTeam(Teams[i][0], Teams[i][2], Teams[i][3]))