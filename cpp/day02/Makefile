CXX ?= g++

# path
BUILD_PATH = build
BIN_PATH = $(BUILD_PATH)/bin
SRC_PATH = ./

# executable
BIN_NAME = solution

# extensions
SRC_EXT = cc

SOURCES = $(shell find $(SRC_PATH) -name '*.$(SRC_EXT)' | sort -k 1nr | cut -f2-)

# flags
COMPILE_FLAGS = -std=c++11 -Wall -Wextra -g
INCLUDES = -I include/ -I /usr/local/include


clean:
	@echo "Deleting $(BIN_NAME) ..."
	@$(RM) $(BIN_NAME)
	@echo "Deleting directories ..."
	@$(RM) -r $(BUILD_PATH)
	@$(RM) -r $(BIN_PATH)

dirs:
	@echo "Creating directories"
	@mkdir -p $(BIN_PATH)

compile: dirs
	@echo "Compiling ... $(BIN_NAME)"
	$(CXX) $(COMPILE_FLAGS) $(INCLUDES) $(SOURCES) -o $(BIN_PATH)/$(BIN_NAME)
