# vim: noexpandtab

SRC:=$(patsubst %/$(lastword $(MAKEFILE_LIST)),%/,$(abspath $(lastword $(MAKEFILE_LIST))))
SH:=$(wildcard *.sh)
EXE:=$(SH:.sh=)
MBIN=/mbin/

.PHONY: install uninstall
install: $(EXE)

$(EXE): $(SH)
	ln -sfn $(SRC)$< $(DESTDIR)$(MBIN)$@

uninstall:
	-rm $(addprefix $(DESTDIR)$(MBIN), $(EXE))
