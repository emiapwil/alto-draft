PANDOC_OPT=-st docbook+header_attributes

genxmlfiles=$(patsubst src/%.md, build/%.xml.gen, $(wildcard src/*.md))

rawxmlfiles=$(patsubst src/%.xml, build/%.xml, $(wildcard src/*.xml))

target=$(patsubst src/%.xml, build/%.xml, src/draft-template.xml)
output=$(patsubst build/%.xml, %.txt, $(target))

stylefile=~/.workspaces/research/my.articles/common/pandoc2rfc/transform.xsl

all: prepare $(genxmlfiles) $(rawxmlfiles)
	xml2rfc $(target) -o $(output) --text

build/%.xml.gen: src/%.md prepare
	pandoc $(PANDOC_OPT) $< | xsltproc --nonet $(stylefile) - > $@

build/%.xml: src/%.xml prepare
	cp $< $@

prepare:
	mkdir -p build

clean:
	@rm -rf $(output)
	@rm -rf build
