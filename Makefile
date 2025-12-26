APP_NAME      := MIS
APP_BUNDLE    := $(APP_NAME).app
APP_EXEC      := mis

CC            := clang
CFLAGS        := -Wall -Wextra -Iinclude
OBJCFLAGS     := -Wall -Wextra -Iinclude -ObjC
LDFLAGS       := -framework Cocoa

SRC_DIR       := src
BUILD_DIR     := build

SRC_C         := $(wildcard $(SRC_DIR)/*.c)
SRC_OBJC      := $(wildcard $(SRC_DIR)/*.m)

OBJ_C         := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(SRC_C))
OBJ_OBJC      := $(patsubst $(SRC_DIR)/%.m,$(BUILD_DIR)/%.o,$(SRC_OBJC))

OBJS          := $(OBJ_C) $(OBJ_OBJC)

.PHONY: all clean mis agent run

all: agent

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# ---------- Compile ----------
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.m | $(BUILD_DIR)
	$(CC) $(OBJCFLAGS) -c $< -o $@

# ---------- Link ----------
mis: $(OBJS)
	$(CC) $^ $(LDFLAGS) -o $(BUILD_DIR)/$(APP_EXEC)

# ---------- macOS Utility Agent ----------
agent: mis
	rm -rf $(APP_BUNDLE)
	mkdir -p $(APP_BUNDLE)/Contents/MacOS
	mkdir -p $(APP_BUNDLE)/Contents

	cp $(BUILD_DIR)/$(APP_EXEC) \
	   $(APP_BUNDLE)/Contents/MacOS/$(APP_EXEC)

	chmod +x $(APP_BUNDLE)/Contents/MacOS/$(APP_EXEC)

	chmod +x ./generate_plist.sh
	./generate_plist.sh $(APP_BUNDLE) $(APP_EXEC)

# ---------- Run ----------
run:
	./$(APP_BUNDLE)/Contents/MacOS/$(APP_EXEC)

# ---------- Clean ----------
clean:
	rm -rf $(BUILD_DIR) $(APP_BUNDLE)
