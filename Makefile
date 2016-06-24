# Set QUIET to @ to suppress folder creation and deletion
# Set SILENCE to @ to suppress compier output
# For the most complete silence, pass the -s option
QUIET = @
SILENCE = @



#############################
### Project configuration ###
#############################
TEST_MODULE=state_pattern
#ROOT_DIRECTORY=
SRC_DIRS = src
INC_DIRS = inc
TEST_DIRS = tests
# MOCK_DIRS = mocks
BUILD_DIR = build
OBJECT_DIR = obj



######################
### Compiler flags ###
######################
CFLAGS += -Wall
ifeq ($(FATAL_COMPILER_ERRORS),Y)
	CFLAGS += -Wfatal-errors
endif

INCLUDE_FLAGS = $(addprefix -I, $(INC_DIRS))
INCLUDE_FLAGS += $(addprefix -I, $(MOCK_DIRS))


#############################
### Product Configuration ###
#############################
TARGET_NAME = $(TEST_MODULE)
CPPUTEST_HOME = /usr/local

# CppUTest flags
TEST_INCLUDE_FLAGS = $(addprefix -I, $(TEST_DIRS))
CPPFLAGS += -I$(CPPUTEST_HOME)/include
CXXFLAGS += -include $(CPPUTEST_HOME)/include/CppUTest/MemoryLeakDetectorNewMacros.h
CFLAGS += -include $(CPPUTEST_HOME)/include/CppUTest/MemoryLeakDetectorMallocMacros.h
LD_LIBRARIES = -L$(CPPUTEST_HOME)/lib -l CppUTest -lCppUTestExt

#Flags for archive tool
ifdef SILENCE
	ARCHIVER_FLAGS=rcs
else
	ARCHIVER_FLAGS=rcvs
endif

C_COMPILER = gcc
CPP_COMPILER = g++
ARCHIVER = ar
DEP_FLAGS = -MMD -MP
MAKE_DIR = mkdir -p
REMOVE = rm -rf



#######################
### Auto-generation ###
#######################
# Auto-generate list of source code
SRC = $(call get_c_src_from_dir_list, $(SRC_DIRS))
src_obj = $(call c_to_o, $(SRC))
SRC_OBJ = $(addprefix $(OBJECT_DIR)/, $(src_obj))
src_dep = $(call c_to_d, $(SRC))
SRC_DEP = $(addprefix $(OBJECT_DIR)/, $(src_dep))

# Auto-generate list of test code
TEST = $(call get_cpp_src_from_dir_list, $(TEST_DIRS)) $(call get_c_src_from_dir_list, $(TEST_DIRS))
# Convert .c extensions to .o, then convert .cpp extensions to .o
test_obj = $(call cpp_to_o, $(call c_to_o, $(TEST)))
TEST_OBJ = $(addprefix $(OBJECT_DIR)/, $(test_obj))
test_dep = $(call cpp_to_d, $(TEST), $(call c_to_d, $(TEST)))
TEST_DEP = $(addprefix $(OBJECT_DIR)/, $(test_dep))


# Auto-generate list of mock code
MOCK = $(call get_cpp_src_from_dir_list, $(MOCK_DIRS))
mock_obj = $(call cpp_to_o, $(MOCK))
MOCK_OBJ = $(addprefix $(OBJECT_DIR)/, $(mock_obj))
mock_dep = $(call cpp_to_d, $(MOCK))
MOCK_DEP = $(addprefix $(OBJECT_DIR)/, $(mock_dep))

DEP_FILES = $(SRC_DEP) + $(TEST_DEP) + $(MOCK_DEP)

TARGET = $(BUILD_DIR)/$(TARGET_NAME)
# Production code is compiled into a library
PRODUCTION_LIB = $(BUILD_DIR)/$(addsuffix .a,$(addprefix lib,$(TARGET_NAME)))



########################
### Helper functions ###
########################
get_c_src_from_dir_list = $(foreach dir, $1, $(call get_c_src_from_dir, $(dir)))
get_c_src_from_dir = $(wildcard $1/*.c)
c_to_o = $(call convert_extension,.c,.o,$1)
c_to_d = $(call convert_extension,.c,.d,$1)

get_cpp_src_from_dir_list = $(foreach dir, $1, $(call get_cpp_src_from_dir, $(dir)))
get_cpp_src_from_dir = $(wildcard $1/*.cpp)
cpp_to_o = $(call convert_extension,.cpp,.o,$1)
cpp_to_d = $(call convert_extension,.cpp,.d,$1)

# $1 is the initial extension
# $2 is the final extension
# $3 is the file in question
convert_extension = $(patsubst %$1,%$2,$3)



ifneq ("(MAKECMDGOALS)","clean")
-include $(DEP_FILES)
endif



###########
# Targets #
###########
.PHONY: test clean full_clean clear

test: clear $(TARGET)
	@echo Executing unit tests for: $(TARGET)
	$(IGNORE_ERROR)$(SILENCE)./$(TARGET) -c

# Be sure to link the test objects before the production library! This allows link-time substitution.
$(TARGET): $(TEST_OBJ) $(MOCK_OBJ) $(PRODUCTION_LIB)
	$(SILENCE)$(QUIET)$(MAKE_DIR) $(dir $@)
	$(SILENCE)$(CPP_COMPILER) -o $@ $^ $(INCLUDE_FLAGS) $(CPPFLAGS) $(CXXFLAGS) $(LD_LIBRARIES)

$(PRODUCTION_LIB): $(SRC_OBJ)
	$(SILENCE)$(QUIET)$(MAKE_DIR) $(dir $@)
	$(SILENCE)$(ARCHIVER) $(ARCHIVER_FLAGS) $@ $^

# Compile test .cpp files
$(OBJECT_DIR)/%.o: %.cpp
	$(SILENCE)$(QUIET)$(MAKE_DIR) $(dir $@)
	$(SILENCE)$(CPP_COMPILER) $(DEP_FLAGS) -o $@ -c $< $(CFLAGS) $(INCLUDE_FLAGS) $(TEST_INCLUDE_FLAGS)

# Compile source .c files
$(OBJECT_DIR)/%.o: %.c
	$(SILENCE)$(QUIET)$(MAKE_DIR) $(dir $@)
	$(SILENCE)$(C_COMPILER) $(DEP_FLAGS) -o $@ -c $< $(CFLAGS) $(INCLUDE_FLAGS)

filelist:
	@echo $(TEST_OBJ)
	@echo $(TEST_DEP)

clean:
	$(SILENCE)$(QUIET)$(REMOVE) $(TARGET)
	$(SILENCE)$(QUIET)$(REMOVE) $(PRODUCTION_LIB)
	$(SILENCE)$(QUIET)$(REMOVE) $(SRC_OBJ)
	$(SILENCE)$(QUIET)$(REMOVE) $(SRC_DEP)
	$(SILENCE)$(QUIET)$(REMOVE) $(TEST_OBJ)
	$(SILENCE)$(QUIET)$(REMOVE) $(TEST_DEP)
	$(SILENCE)$(QUIET)$(REMOVE) $(MOCK_OBJ)
	$(SILENCE)$(QUIET)$(REMOVE) $(MOCK_DEP)

full_clean:
	$(SILENCE)$(QUIET)$(REMOVE) $(BUILD_DIR)
	$(SILENCE)$(QUIET)$(REMOVE) $(OBJECT_DIR)

clear:
	@clear
