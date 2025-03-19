## -*- mode: makefile-gmake -*-

EMACS	    = emacs
EMACS_BATCH = $(EMACS) -batch

MY_LOADPATH = -L . 
BATCH_LOAD  = $(EMACS_BATCH) $(MY_LOADPATH)

# Main rule
#all: init.elc
all: init.el

# Generate lisp and compile it
init.el: init.org
	@rm -f $@
	@$(BATCH_LOAD)						\
		--eval "(require 'org)"			\
		--eval "(org-babel-load-file \"init.org\")"
	@chmod 444 $@

%.elc: %.el
	@echo Compiling file $<
	@$(BATCH_LOAD) -f batch-byte-compile $<

clean:
	@rm -f init.el *.elc *~
