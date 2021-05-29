# vim: noexpandtab

EXT=sh
BINDIR=/usr/local/bin/

.PHONY: install uninstall
install: $(addprefix $(DESTDIR)$(BINDIR),$(basename $(wildcard *.$(EXT))))

$(BINDIR)%: %.$(EXT)
	ln --symbolic --force --no-dereference $(abspath $?) $@

uninstall:
	-rm $(addprefix $(DESTDIR)$(BINDIR),$(basename $(wildcard *.$(EXT))))
