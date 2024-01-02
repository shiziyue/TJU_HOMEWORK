# DV Routing Lab
routing : node0.c node1.c node2.c node3.c prog3.c
	gcc node0.c node1.c node2.c node3.c prog3.c -o routing

.PHONY : make run
run:
	./routing

.PHONY : make save
save:
	./routing > result.txt

.PHONY : make clean
clean:
	rm routing
	rm result.txt

