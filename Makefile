CC = clang
CFLAGS = -Wall -Wextra -Iinclude -std=c17
OBJCFLAGS = -Wall -Wextra -Iinclude -ObjC

SRC_C = src/main.c src/rules.c
SRC_OBJC = src/macos_bridge.m

OBJ_C = $(patsubst src/%.c, build/%.o, $(SRC_C))
OBJ_OBJC = $(patsubst src/%.m, build/%.o, $(SRC_OBJC))
OBJ = $(OBJ_C) $(OBJ_OBJC)

TARGET = mis

all: $(TARGET)

build/%.o: src/%.c
	mkdir -p build
	$(CC) $(CFLAGS) -c $< -o $@

build/%.o: src/%.m
	mkdir -p build
	$(CC) $(OBJCFLAGS) -c $< -o $@

$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET) -lobjc -framework Foundation -framework AppKit -framework Carbon

clean:
	rm -rf build $(TARGET)
