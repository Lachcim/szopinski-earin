SOURCES = $(wildcard *.cpp)
HEADERS = $(wildcard *.h)
OBJECTS = $(patsubst %.cpp, build/%.o, $(SOURCES))

build/tictactoe: $(OBJECTS) | build
	$(CXX) $(LDFLAGS) -o $@ $^

build/%.o: %.c $(HEADERS) | build
	$(CXX) -c $(CFLAGS) -o $@ $<

build:
	mkdir -p build

.PHONY: clean
clean:
	rm -rf build
