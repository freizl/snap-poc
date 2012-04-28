
PROG  = snap-poc
PROG_PREV = ./dist/build/snap-poc/snap-poc

HC=ghc

DIST=dist

default: build

clean:
	rm -rf $(DIST)

conf:
	cabal configure

build: conf
	cabal build

rebuild: clean build

preview:
	$(PROG_PREV) -p 8800

p: preview

bp: build preview

rp: rebuild preview

