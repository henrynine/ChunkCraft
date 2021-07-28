# Acknowledgement: this Makefile is heavily based on the provided Makefile for
#                  A2 from CS 3110 at Cornell: 
#                  https://www.cs.cornell.edu/courses/cs3110/2019sp/
MODULES=blocks colors control converter display entities items main state
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

zip:
	zip final.zip *.ml* _tags Makefile README.md

test:
	$(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST)

play:
	$(OCAMLBUILD) $(MAIN) && ./$(MAIN)

clean:
	ocamlbuild -clean

docs: docs-public docs-private

docs-public: build
	mkdir -p doc.public
	ocamlfind ocamldoc -I _build -package yojson,ANSITerminal \
		-html -stars -d doc.public $(MLIS)

docs-private: build
	mkdir -p doc.private
	ocamlfind ocamldoc -I _build -package yojson,ANSITerminal \
		-html -stars -d doc.private \
		-inv-merge-ml-mli -m A $(MLIS) $(MLS)

bisect-test:
	$(OCAMLBUILD) -package bisect -syntax camlp4o,bisect_pp \
		 $(TEST) && ./$(TEST) -runner sequential

bisect: clean bisect-test
	bisect-report -I _build -html report bisect0001.out
