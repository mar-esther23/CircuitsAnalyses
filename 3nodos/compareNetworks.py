

def line2netfile(line, motif='0'):
	'''
	Convert networks from melusina to nets that boolnet can understand
	'''
	line = line.strip().split(',')
	name = line[0]
	if len(name)==1: name = motif + '0' + name
	else: name = motif + name
	node = line[2].strip().split(';')
	func = line[3].replace('~','!').replace('true','1')
	func = func.strip().split(';')
	topo = line[-1].strip()
	line = "targets, factors\n"
	line = line + '#' + topo + '\n'
	for n, f in zip(node, func):
		line = line + n + ', ' + f + '\n'
	with open('boolnet/'+name+'.csv', 'w') as f:
		f.write(line)
	return name


def topologyDistance(topo1, topo2):
	'''
	Receives 2 topology strings and determines distance
	'''
	topo1 = topo1.strip().split(';')
	topo2 = topo2.strip().split(';')
	#print topo1
	#print topo2
	diff = (set(topo1) ^ set(topo2))
	#print diff
	diff = set([d.replace('+','').replace('-','') for d in diff])
	#print diff
	return len(diff)

def getTransitionTable(filename):
	'''
	Get transition tables from boolnet
	'''
	import rpy2.robjects as robjects
	from rpy2.robjects.packages import importr
	BoolNet = importr("BoolNet")
	#print filename
	net = BoolNet.loadNetwork(filename)
	attr = BoolNet.getAttractors(net)
	#print attr.rx2("stateInfo")
	tt = list( attr.rx2("stateInfo").rx2("table") )
	return tt



def dynamicalDistance(net1, net2):
	'''
	Receives 2 network filenames and determines distance
	'''
	# get transition tables from boolnet
	tt1 = getTransitionTable("./boolnet/"+net1) 
	#print [bin(s)[2:] for s in tt1]  
	tt2 = getTransitionTable("./boolnet/"+net2)
	#print [bin(s)[2:] for s in tt2] 
	d_dyn = 0
	for s1, s2 in zip(tt1, tt2):
		dif = bin(s1 ^ s2) #xor of states in binary
		# note bin changes the order of genes of both networks
		d_dyn += list(dif).count('1') #count diferences
	return d_dyn


# # GENERATE ALL NETWORKS
# motif = ['1', '2', '3', '4']
# for m in motif:
# 	file = "epistasis-3-genes-unknown-sign-motif{:s}-expectation.out".format(m)
# 	f = open(file)
# 	for line in f.readlines(): 
# 		print(   line2netfile(line,m)   )
# 	f.close()


# from os import walk

# f = []
# for (dirpath, dirnames, filenames) in walk("./boolnet"):
#     f.extend(filenames)
# filenames = sorted(filenames)
# #print filenames

# from itertools import combinations

# for net1, net2 in combinations(filenames, 2):
# 	# Topological distance
# 	with open("./boolnet/"+net1) as f: 
# 		f.readline()
# 		line1 = f.readline().replace('#','')
# 	with open("./boolnet/"+net2) as f: 
# 		f.readline()
# 		line2 = f.readline().replace('#','')
# 	d_top = topologyDistance(line1, line2)
# 	# Dynamical distance
# 	d_dyn = dynamicalDistance(net1, net2)

# 	print net1[0:-4], net2[0:-4], d_top, d_dyn

