# Directories
TARGETDIR = output
OPENSCADLIBDIR = $(shell pwd)

# Target
TARGETS := fc203 fc204 fc205 fc207 fc208 fc210
STACKUP_TARGET = fc205

# others
RENDERFILE = render_model.scad

# internal targets
BASEFILES = $(addprefix $(TARGETDIR)/, $(TARGETS))
PNGFILES = $(addsuffix .png, $(BASEFILES))
BOTSTLFILES = $(addsuffix _bot.stl, $(BASEFILES))
TOPSTLFILES = $(addsuffix _top.stl, $(BASEFILES))
PCBOUTLINEFILES = $(addsuffix _pcb_outline.dxf, $(BASEFILES))

STACKUPPNGFILE = $(addsuffix _stackup.png, $(addprefix $(TARGETDIR)/, $(STACKUP_TARGET)))

all: render model stackup

render: make-dir $(PNGFILES)

stackup: make-dir $(STACKUPPNGFILE)

model: make-dir $(BOTSTLFILES) $(TOPSTLFILES)

pcb-outlines: make-dir $(PCBOUTLINEFILES)

$(STACKUPPNGFILE):
	@echo Rendering stack up png for $(subst $(TARGETDIR)/,,$(basename $@))...
	@OPENSCADPATH=$(OPENSCADLIBDIR) openscad $(RENDERFILE) --colorscheme "Tomorrow Night" --render --imgsize=2048,2048 -q -o $@ -Dstackup=1 -Dcolumns=$(subst _stackup,,$(subst $(TARGETDIR)/fc2,,$(basename $@)))

$(PNGFILES):
	@echo Rendering png for $(subst $(TARGETDIR)/,,$(basename $@))...
	@OPENSCADPATH=$(OPENSCADLIBDIR) openscad $(RENDERFILE) --colorscheme "Tomorrow Night" --render --imgsize=2048,2048 -q -o $@ -Dall=1 -Dcolumns=$(subst $(TARGETDIR)/fc2,,$(basename $@))

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

print-%:
	@echo $* = $($*)

clean:
	@rm -rf $(PNGFILES)
	@rm -rf $(BOTSTLFILES)
	@rm -rf $(TOPSTLFILES)
	@rm -rf $(PCBOUTLINEFILES)

.PHONY: clean make-dir model render stackup pcb-outlines all
