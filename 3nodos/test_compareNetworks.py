import unittest
from compareNetworks import *


class Test(unittest.TestCase):


	def test_topologyDistance(self):
		lines = []
		for n in ['100.csv', '103.csv', '107.csv']:
			with open("./boolnet/"+n) as f: 
				f.readline()
				lines.append( f.readline().replace('#','') )
		self.assertEqual( topologyDistance(lines[0], lines[0]), 0 )
		self.assertEqual( topologyDistance(lines[0], lines[1]), 2 )
		self.assertEqual( topologyDistance(lines[0], lines[2]), 0 )
		self.assertEqual( topologyDistance(lines[1], lines[2]), 2 )


	def test_getTransitionTable(self):
    	#nets=['100.csv', '101.csv', '107.csv']
		self.assertEqual( getTransitionTable('boolnet/100.csv'), [9,11,15,15,9,11,15,15] )
		self.assertEqual( getTransitionTable('boolnet/103.csv'), [9,11,13,15,9,11,13,15] )
		self.assertEqual( getTransitionTable('boolnet/107.csv'), [9,11,15,15,9,11,15,15] )

	def test_dynamicalDistance(self):
		self.assertEqual( dynamicalDistance('100.csv', '100.csv'), 0 )
		self.assertEqual( dynamicalDistance('100.csv', '103.csv'), 2 )
		self.assertEqual( dynamicalDistance('100.csv', '107.csv'), 0 )
		self.assertEqual( dynamicalDistance('103.csv', '107.csv'), 2 )


if __name__ == '__main__':
    unittest.main()