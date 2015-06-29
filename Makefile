PANDOC_OPT=-st docbook+header_attributes

genbibfiles=$(patsubst src/references/%.bibtex, build/reference.%.xml, $(wildcard src/references/*.bibtex))
genxmlfiles=$(patsubst src/%.md, build/%.xml.gen, $(wildcard src/*.md))
rawxmlfiles=$(patsubst src/%.xml, build/%.xml, $(shell find src/ -type f -name  '*.xml'))

target=$(patsubst src/%.xml, build/%.xml, src/draft-template.xml)
output=$(patsubst build/%.xml, %.txt, $(target))

stylefile=../common/pandoc2rfc/transform.xsl

all: prepare $(genxmlfiles) $(rawxmlfiles) $(genbibfiles)
	xml2rfc $(target) -o $(output) --text

build/%.xml.gen: src/%.md prepare
	pandoc $(PANDOC_OPT) $< | xsltproc --nonet $(stylefile) - > $@

build/reference.%.xml: src/references/%.bibtex prepare
	python2.7 ../common/bibtex2rfc/bibxml.py $< > $@

build/%.xml: src/%.xml prepare
	cp $< build

prepare:
	mkdir -p build

clean:
	@rm -rf $(output)
	@rm -rf build
