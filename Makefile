CC=gcc
DEPS = NumClass.h
FLAGS = -Wall -g
OBJ_LOOP = advancedClassificationLoop.o basicClassification.o
OBJ_REC = advancedClassificationRecursion.o basicClassification.o
all: mains maindloop maindrec loops recursives recursived loopd

#static libraries:
loops: libclassloops.a
	ar -rcs libclassloops.a $(OBJ_LOOP)

libclassloops.a: $(OBJ_LOOP)
	ar -rcs libclassloops.a $(OBJ_LOOP)

recursives: libclassrec.a
	ar -rcs libclassrec.a $(OBJ_REC)

libclassrec.a: $(OBJ_REC)
	ar -rcs libclassrec.a $(OBJ_REC)

#dyamic libraries:
recursived: libclassrec.so
	$(CC) -shared -o libclassrec.so $(OBJ_REC)

libclassrec.so: $(OBJ_REC)
	$(CC) -shared -o libclassrec.so $(OBJ_REC)

loopd: libclassloops.so
	$(CC) -shared -o libclassloops.so $(OBJ_LOOP)

libclassloops.so: $(OBJ_LOOP)
	$(CC) -shared -o libclassloops.so $(OBJ_LOOP)


#driver program:
mains: main.o libclassrec.a
	$(CC) -o mains main.o libclassrec.a -lm

maindloop: main.o libclassloops.so	
	$(CC) -o maindloop main.o ./libclassloops.so -lm

maindrec: main.o libclassrec.so
	$(CC) -o maindrec main.o ./libclassrec.so -lm
#.o files
main.o: main.c NumClass.h
	$(CC) $(FLAGS) -c -Wall main.c 
		
advancedClassificationRecursion.o: advancedClassificationRecursion.c NumClass.h
	$(CC) $(FLAGS) -c advancedClassificationRecursion.c 

basicClassification.o: basicClassification.c NumClass.h
	$(CC) $(FLAGS) -c basicClassification.c 

advancedClassificationLoop.o: advancedClassificationLoop.c NumClass.h
	$(CC) $(FLAGS) -c advancedClassificationLoop.c 


.PHONY: clean
clean:
	rm -f *.o *.a *.so mains maindloop maindrec
		