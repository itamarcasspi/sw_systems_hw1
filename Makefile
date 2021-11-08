CC=gcc
DEPS = NumClass.h

all: mains maindloop maindrec loops recursives recursived loopd

#static libraries:
loops: advancedClassificationLoop.o basicClassification.o
	ar rcs libclassloops.a advancedClassificationLoop.o basicClassification.o

recursives: advancedClassificationRecursion.o basicClassification.o
	ar rcs libclassrec.a advancedClassificationRecursion.o basicClassification.o 
#dyamic libraries:
recursived: advancedClassificationRecursion.o basicClassification.o
	$(CC) -shared -o libclassrec.so advancedClassificationRecursion.o basicClassification.o

loopd: advancedClassificationLoop.o basicClassification.o
	$(CC) -shared -o libclassloops.so advancedClassificationLoop.o basicClassification.o
#driver program:
mains: main.o recursives
	$(CC) -o mains main.o libclassrec.a -lm

maindloop: main.o loopd	
	$(CC) -o maindloop main.o ./libclassloops.so -lm

maindrec: main.o recursived
	$(CC) -o maindrec main.o ./libclassrec.so -lm
#.o files
main.o: main.c NumClass.h
	$(CC) -c -Wall main.c 
		
advancedClassificationRecursion.o: advancedClassificationRecursion.c NumClass.h
	$(CC) -c -Wall advancedClassificationRecursion.c 

basicClassification.o: basicClassification.c NumClass.h
	$(CC) -c -Wall basicClassification.c 

advancedClassificationLoop.o: advancedClassificationLoop.c NumClass.h
	$(CC) -c -Wall advancedClassificationLoop.c 


.PHONY: clean
clean:
	rm -f *.o *.a *.so mains maindloop maindrec
		