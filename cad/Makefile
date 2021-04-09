# Directories
TARGETDIR = output
OPENSCADLIBDIR = $(shell pwd)

# Target
TARGETS := fc203 fc204 fc205 fc207 fc208 fc210

# others
RENDERFILE = render_model.scad

# internal targets
BASEFILES = $(addprefix $(TARGETDIR)/, $(TARGETS))
PNGFILES = $(addsuffix .png, $(BASEFILES))
BOTSTLFILES = $(addsuffix _bot.stl, $(BASEFILES))
TOPSTLFILES = $(addsuffix _top.stl, $(BASEFILES))
PCBOUTLINEFILES = $(addsuffix _pcb_outline.dxf, $(BASEFILES))

all: renders models

renders: make-dir $(PNGFILES)

models: make-dir $(BOTSTLFILES) $(TOPSTLFILES)

pcb-outlines: make-dir $(PCBOUTLINEFILES)

$(PNGFILES):
	@echo Rendering png for $(subst $(TARGETDIR)/,,$(basename $@))...
	@OPENSCADPATH=$(OPENSCADLIBDIR) openscad $(RENDERFILE) --colorscheme "Tomorrow Night" -q -o $@ -Dall=1 -Dcolumns=$(subst $(TARGETDIR)/fc2,,$(basename $@))

$(BOTSTLFILES):
	@echo Rendering bottom stl for $(subst $(TARGETDIR)/,,$(basename $@))...
	@OPENSCADPATH=$(OPENSCADLIBDIR) openscad $(RENDERFILE) -q -o $@ -Dbot=1 -Dcolumns=$(subst _bot,,$(subst $(TARGETDIR)/fc2,,$(basename $@)))

$(TOPSTLFILES):
	@echo Rendering top stl for $(subst $(TARGETDIR)/,,$(basename $@))...
	@OPENSCADPATH=$(OPENSCADLIBDIR) openscad $(RENDERFILE) -q -o $@ -Dtop=1 -Dcolumns=$(subst _top,,$(subst $(TARGETDIR)/fc2,,$(basename $@)))

$(PCBOUTLINEFILES):
	@echo Rendering pcb outline for $(subst $(TARGETDIR)/,,$(basename $@))...
	@OPENSCADPATH=$(OPENSCADLIBDIR) openscad $(RENDERFILE) -q -o $@ -Dpcb=1 -Dcolumns=$(subst _pcb_outline,,$(subst $(TARGETDIR)/fc2,,$(basename $@)))

make-dir:
	@mkdir -p $(TARGETDIR)

clean:
	@rm -rf $(PNGFILES)
	@rm -rf $(BOTSTLFILES)
	@rm -rf $(TOPSTLFILES)
	@rm -rf $(PCBOUTLINEFILES)

.PHONY: clean make-dir models renders pcb-outlines all
