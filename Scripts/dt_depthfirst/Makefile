CC=gcc
OBJ = main.o
TARGET = dt

%.o: %.c 
	$(CC) -c -o $@ $<

dt: $(OBJ)
	$(CC) -o $@ $^

.PHONY: clean

clean:
	rm -f *.o $(TARGET)
