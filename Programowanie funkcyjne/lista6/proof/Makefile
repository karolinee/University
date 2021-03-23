SOURCES = logic.ml logic.mli proof.mli proof.ml interactive.ml interactive.mli logic.mllib
CMFILES = logic.cma logic.cmi proof.cmi interactive.cmi
.PHONY: all clean build

all: logic.cma logic.cmi proof.cmi interactive.cmi

build: $(SOURCES)
	rm -f $(CMFILES)
	ocamlbuild logic.cma

logic.cma: build
	cp _build/$@ $@

logic.cmi: build
	cp _build/$@ $@

proof.cmi: build
	cp _build/$@ $@

interactive.cmi: build
	cp _build/$@ $@

clean:
	rm -f $(CMFILES)
	ocamlbuild -clean
