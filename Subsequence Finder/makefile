main: lcs.o lps.o lts.o utility.o main.o main.h
	gcc -o main lcs.o lps.o lts.o utility.o main.o
 
lps.o: lps.c lps.h
	gcc -c lps.c
 
lts.o: lts.c lts.h
	gcc -c lts.c 
 
lcs.o: lcs.c lcs.h
	gcc -c lcs.c

utility.o: utility.c utility.h 
	gcc -c utility.c 
 
main.o: main.c lcs.h lps.h lts.h 
	gcc -c main.c 
 
clean:
	rm -f *.out *.o
 

 
