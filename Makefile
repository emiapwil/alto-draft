PANDOC_OPT=-st docbook+header_attributes
BIBTEX2RFC_HOME=../common/bibtex2rfc

genbibfiles=$(patsubst src/references/%.bibtex, build/reference.%.xml, $(wildcard src/references/*.bibtex))
genxmlfiles=$(patsubst src/%.md, build/%.xml.gen, $(wildcard src/*.md))
rawxmlfiles=$(patsubst src/%.xml, build/%.xml, $(shell find src/ -type f -name  '*.xml'))

target=$(patsubst src/%.xml, build/%.xml, $(wildcard src/draft-*.xml))
output=$(patsubst build/%.xml, %.txt, $(target))

stylefile=util/pandoc2rfc/transform.xsl

all: prepare $(output)

$(output): $(target) $(genxmlfiles) $(rawxmlfiles) $(genbibfiles)
	xml2rfc $(target) -o $(output) --text

build/%.xml.gen: src/%.md
	pandoc $(PANDOC_OPT) $< | xsltproc --nonet $(stylefile) - > $@

build/reference.%.xml: src/references/%.bibtex
	python2.7 $(BIBTEX2RFC_HOME)/bibxml.py $< > $@

build/%.xml: src/%.xml
	cp $< build

prepare:
	mkdir -p build

sync: all
	rsync -avz --exclude .git/ ./* ../alto/ietf/mp-alto/alto-draft

sync-back:
	git checkout -B sync
	rsync -avz ../alto/ietf/mp-alto/alto-draft/ .

view: all
	vim $(output)

clean:
	@rm -rf $(output)
	@rm -rf build
