#! /usr/bin/env Rscript

args<-commandArgs(TRUE)

decimalToBinary<-function(value,positions){
	val = value
	output <- rep(0,positions)
	counter <- 1
	while(val>0){
		output[[counter]]<-val%%2
		val <- val %/% 2
		counter <- counter+1
	}
	output
}

library(BoolNet)

showAttractors<-function(data){
	numberOfAttractors <- length(data[2]$attractors)	
	cat ("This network has", numberOfAttractors, "attractors!\n")
	for(i in 1:numberOfAttractors){
		periodSize <- length(data[2]$attractors[[i]][[1]])
		cat("Attractor:",i,"\tPeriod:",periodSize,"\tBasin size:",data[2]$attractors[[i]][[2]],"\n")
		for(j in 1:periodSize){
			binaryAttractor<-decimalToBinary(data[2]$attractors[[i]][[1]][[j]],networkSize)
			cat("\t",binaryAttractor,"\n")
		}
	}
}

net<-loadNetwork(args[1])

networkSize<-length(net[[2]])
cat("Nodes are in the following order:",net[[2]],"\n")

attr<-getAttractors(net)

cat('#####\n')
showAttractors(attr)
	
q()


