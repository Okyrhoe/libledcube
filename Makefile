CC := g++
CFLAGS := -Wall -Wextra -Wcast-align -Wfloat-equal -Wpointer-arith -Wshadow -Wundef -O2 -fstack-protector -DCUBE_WIDTH=5 -DCHARMAP_COMPRESS
LIBS :=

LIBNAME := ledcube
LIBFILE := lib$(LIBNAME).a

ZIP := zip
ZIPFILE := libledcube.zip

ARDUINOLIB := $(HOME)/Arduino/libraries

SOURCEDIR := .

SOURCES := $(shell find $(SOURCEDIR) -name '*.cpp')
HEADERS := $(shell find $(SOURCEDIR) -name '*.h')
OBJECTS := $(patsubst %.cpp, %.o, $(SOURCES))

.PHONY: all zip install uninstall clean

all: $(OBJECTS)
	ar rcs $(LIBFILE) $(OBJECTS)

$(OBJECTS): $(SOURCEDIR)/%.o : $(SOURCEDIR)/%.cpp
	$(CC) $(CFLAGS) $(LIBS) -c $< -o $@

zip:
	$(ZIP) -r $(ZIPFILE) $(SOURCES) $(HEADERS) examples/ keywords.txt readme.txt

install:
	mkdir -p "$(ARDUINOLIB)/lib$(LIBNAME)"
	unzip "$(ZIPFILE)" -d "$(ARDUINOLIB)/lib$(LIBNAME)/"

uninstall:
	rm -rf "$(ARDUINOLIB)/lib$(LIBNAME)"

clean:
	-@rm $(OBJECTS)
	-@rm $(ZIPFILE)
	-@rm $(LIBFILE)
