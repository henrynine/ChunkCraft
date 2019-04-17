# Acknowledgement: this Makefile is heavily based on the provided Makefile for
#                  A2
MODULES=state blocks display main control items
OBJECTS=$(MODULES:=.cmo)
MLS=$(MODULES:=.ml)
MLIS=$(MODULES:=.mli)
TEST=test.byte
MAIN=main.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind

default: build
	utop

build:
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST)

play:
	$(OCAMLBUILD) $(MAIN) && ./$(MAIN) 2> /tmp/a.txt

clean:
	ocamlbuild -clean

bisect-test:
	$(OCAMLBUILD) -package bisect -syntax camlp4o,bisect_pp \
		 $(TEST) && ./$(TEST) -runner sequential

bisect: clean bisect-test
	bisect-report -I _build -html report bisect0001.out
