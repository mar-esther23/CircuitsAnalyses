import os

def split(src):
    name = "%s_output" % src
    if os.path.exists(name):
        print "Output folder '%s' already exist" % name
    else:
        os.mkdir(name)
        f = open(src)
        n = 1
        for line in f:
            if line.startswith("This "):
                print "new model: ", n
                filename = "%s/net%s.boolfunctions" % (name,n)
                out = open(filename, "w")
                n += 1
            elif len( line.strip() ) < 1:
                out.close()
            else:
                out.write(line)
        f.close()
    batch(name)


def analysis(filename):
    out = open("%s.circuits" % filename, "w")
    model = lm.loadModel(filename, "boolfunctions")
    g = LogicalModel2RegulatoryGraph.importModel(model)
    c_algo = s_circuits.getCircuitAnalyser(g, False)

    order = g.getNodeOrder()
    circuits = c_algo.call()
    manager = c_algo.getManager()
    searcher = PathSearcher(manager, 1,3)
    for ct in circuits:
        c = ct.getCircuit()
        pos = 0
        neg = 0
        for ctx in c.t_context:
            if ctx > 0:
                print "# Estimate ",  ctx
                path = searcher.setNode(ctx)
                for v in searcher:
                    curcount = 1
#                    print "  %s:  " % v,
                    for a in path:
                        if a<0: curcount*= 2
#                        print a,
#                    print "  [%s]" % curcount
                    if v == 1: pos += curcount
                    elif v == 2: neg += curcount
                out.write("%2d  %2d  %s\n" % (pos, neg, ct))
    out.close()


def batch(name):
    files = os.listdir(name)
    for f in files:
        if f.endswith(".boolfunctions"):
            print f
            analysis(os.path.join(name,f))



if 'gs' not in locals():
    print "This script should run in GINsim"
else:
    from org.colomoto.mddlib import PathSearcher
    from org.ginsim.core.graph.regulatorygraph import LogicalModel2RegulatoryGraph
    s_circuits = gs.service("circuitAnalysis")

for name in gs.args:
    split(name)


