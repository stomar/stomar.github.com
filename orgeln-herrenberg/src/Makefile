#### Start of system configuration section. ####

srcdir = .

SHELL = /bin/sh
XSLPROC = xsltproc

#### End of system configuration section. ####

EINZEL_XML  := $(wildcard org_id*.xml)
EINZEL_HTML := $(patsubst %.xml,%.html,$(EINZEL_XML))

WWW_FILES := index.html orte.html erbauer.html links.html \
	orgeldb.html $(EINZEL_HTML) \
	format.css 400.html 404.html valid-html401.gif

INST_TARGET = ../db

.PHONY : usage
usage :
	@echo run
	@echo " $$ extractall"
	@echo " $$ make all"
	@echo " $$ make install"

.PHONY : all
all : index html

.PHONY : index
index : orte.html erbauer.html

.PHONY : html
html : orgeldb.html $(EINZEL_HTML)

orte.html : orgeldb.xml orte.xsl
	$(XSLPROC) -o $@ orte.xsl orgeldb.xml

erbauer.html : orgeldb.xml erbauer.xsl
	$(XSLPROC) -o $@ erbauer.xsl orgeldb.xml

%.html : %.xml orgeldb.xsl
	$(XSLPROC) -o $@ orgeldb.xsl $<

.PHONY : check
check :
	xmllint --valid --noout orgeldb.xml

.PHONY : clean
clean :
	-rm -f orte.html erbauer.html orgeldb.html $(EINZEL_HTML)

.PHONY : realclean
realclean : clean
	-rm -f $(EINZEL_XML)

.PHONY : wwwdist
wwwdist : all
	tar -czf orgeldb_www.tgz $(WWW_FILES)

.PHONY : install
install : all
	correctcoding orte.html erbauer.html orgeldb.html $(EINZEL_HTML)
	mv orte.html erbauer.html orgeldb.html $(EINZEL_HTML) $(INST_TARGET)
