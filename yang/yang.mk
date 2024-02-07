YANGDIR ?= yang

STDYANGDIR ?= tools/yang
$(STDYANGDIR):
	git clone --depth 10 -b main https://github.com/YangModels/yang $@

OPTIONS=--tree-print-groupings --tree-no-expand-uses -f tree --tree-line-length=70
ifeq ($(OS), Windows_NT)
YANG_PATH="$(YANGDIR);$(STDYANGDIR)/standard/ietf/RFC/;$(STDYANGDIR)/standard/ieee/published/802.1/;$(STDYANGDIR)/experimental/ietf-extracted-YANG-modules"
else
YANG_PATH="$(YANGDIR):$(STDYANGDIR)/standard/ietf/RFC/:$(STDYANGDIR)/standard/ieee/published/802.1/:$(STDYANGDIR)/experimental/ietf-extracted-YANG-modules"
endif
YANG=$(wildcard $(YANGDIR)/*.yang)
STDYANG=$(wildcard $(YANGDIR)/ietf-*.yang)
TXT=$(patsubst $(YANGDIR)/%.yang,%-diagram.txt,$(YANG))

.PHONY: yang-lint yang-gen-diagram yang-clean

pyang-lint: $(STDYANG) $(STDYANGDIR)
	pyang -V --ietf -f tree --tree-line-length=70 --tree-print-groupings -p $(YANG_PATH) $(STDYANG)	

yang-lint: $(STDYANG) $(STDYANGDIR)
	yanglint --verbose -p $(YANGDIR) -p $(STDYANGDIR)/standard/ietf/RFC/ -p $(STDYANGDIR)/experimental/ietf-extracted-YANG-modules -p $(STDYANGDIR)/standard/ieee/published/802.1/ $(STDYANG) -i

yang-gen-diagram: yang-lint $(TXT)

yang-clean:
	rm -f $(TXT)

%-diagram.txt: $(YANGDIR)/%.yang
	pyang $(OPTIONS) -p $(YANG_PATH) $< > $@
