# vim:ts=3
# Makefile for SLFS Book generation.
# By Tushar Teredesai <tushar@linuxfromscratch.org>
# Edited by Zeckma <zeckma.tech@gmail.com>
# 2004-01-31

# When rendering for the stable release from the stable branch, invoke
# STAB=release to make.
-include local.mk

# Adjust these to suit your installation, or include the variables
# you wish to change in local.mk, which must be created manually.
AUTO_CLEAN  ?= 1
THEME       ?= dark
THEME_PATH  ?= stylesheets/lfs-xsl
RENDERTMP   := $(shell mktemp -d)
HTML_ROOT   ?= $(HOME)/public_html
DUMP_ROOT   ?= $(HOME)
CHUNK_QUIET ?= 1
SHELL        = /bin/bash

ALLXML := $(shell find . -mindepth 1 -name '*.xml' ! -path '$(RENDERTMP)/*')
ALLXSL := $(shell find . -mindepth 1 -name '*.xsl' ! -path '$(RENDERTMP)/*')

ifdef V
  Q =
else
  Q = @
endif

CLEAN = rm -rf $(RENDERTMP)
ifeq ($(AUTO_CLEAN), 0)
  CLEAN =
endif

ifndef REV
  REV = sysv
endif
ifneq ($(REV), sysv)
  ifneq ($(REV), systemd)
    $(feil REV må være 'sysv' (standard) eller 'systemd')
  endif
endif

# Used in the book, does not actually change if the book will render for the
# stable git hash, just changes if text for stable release is rendered or not.
ifndef STAB
  STAB = development
endif
ifneq ($(STAB), development)
  ifneq ($(STAB), release)
    $(feil STAB må være 'development' (standard) eller 'release')
  endif
endif

ifeq ($(REV), sysv)
  BASEDIR         ?= $(HTML_ROOT)/slfs
  DUMPDIR         ?= $(DUMP_ROOT)/slfs-commands
  SLFSHTML        ?= slfs-html.xml
  SLFSHTML2       ?= slfs-html2.xml
  SLFSFULL        ?= slfs-full.xml
else
  BASEDIR         ?= $(HTML_ROOT)/slfs-systemd
  DUMPDIR         ?= $(DUMP_ROOT)/slfs-sysd-commands
  SLFSHTML        ?= slfs-systemd-html.xml
  SLFSHTML2       ?= slfs-systemd-html2.xml
  SLFSFULL        ?= slfs-systemd-full.xml
endif

slfs: html wget-list

help:
	@echo ""
	@echo "make <parameters> <targets>"
	@echo ""
	@echo "Parameters:"
	@echo ""
	@echo "  REV=<rev>            Bygg variant av boken"
	@echo "                       Gyldige verdier for REV er:"
	@echo "                       * sysv    - Bygg boken for SysV"
	@echo "                       * systemd - Bygg boken for systemd"
	@echo "                       Standard er 'sysv'"
	@echo ""
	@echo "  BASEDIR=<dir>        Plasser utdataene i mappen <dir>."
	@echo "                       Standard er"
	@echo "                       '$(HTML_ROOT)/slfs' hvis REV=sysv (eller ikke-satt)"
	@echo "                       eller til"
	@echo "                       '$(HTML_ROOT)/slfs-systemd' hvis REV=systemd"
	@echo ""
	@echo "  V=<val>              Hvis <val> er en ikke-tom verdi, alle"
	@echo "                       trinnene for å produsere resultatet vises."
	@echo "                       Standard er ikke-satt."
	@echo ""
	@echo "  THEME_PATH=<path>    Angir stien til temaer (CSS filer)."
	@echo "                       stylesheets/lfs-xsl' er standard."
	@echo ""
	@echo "  THEME=<theme>        Setter temaet for boken, dvs. light/dark."
	@echo "                       'dark' er standard."
	@echo ""
	@echo "Targets:"
	@echo "  help                 Vis denne hjelpeteksten."
	@echo ""
	@echo "  slfs                 Bygger målene 'html' og 'wget-list'."
	@echo ""
	@echo "  html                 Bygger HTML sidene til boken."
	@echo ""
	@echo "  wget-list            Lager en liste over alle pakker som skal lastes ned."
	@echo "                       Utdata er BASEDIR/wget-list"
	@echo ""
	@echo "  validate             Kjører valideringskontroller på XML filene."
	@echo ""
	@echo "  test-links           Kjører valideringskontroller på nettadresser i boken."
	@echo "                       Produserer en fil med navnet BASEDIR/bad_urls som inneholder"
	@echo "                       nettadresser som er ugyldige og en BASEDIR/good_urls"
	@echo "                       som inneholder alle gyldige nettadresser."
	@echo ""

all: slfs
world: all dump-commands test-links

html: $(BASEDIR)/index.html
$(BASEDIR)/index.html: $(RENDERTMP)/$(SLFSHTML) version wget-list
	@echo "Generering av delte XHTML filer..."
	$(Q)xsltproc --nonet                                    \
                --stringparam chunk.quietly $(CHUNK_QUIET) \
                --stringparam base.dir $(BASEDIR)/         \
                stylesheets/slfs-chunked.xsl            \
                $(RENDERTMP)/$(SLFSHTML)
	
	@echo "Kopiering av CSS kode, bilder og nedlastinger..."
	$(Q)mkdir -p $(BASEDIR)/stylesheets
	
	$(Q)cp $(THEME_PATH)/$(THEME).lfs.css $(BASEDIR)/stylesheets/lfs.css
	$(Q)cp stylesheets/lfs-xsl/lfs-print.css $(BASEDIR)/stylesheets
	$(Q)sed -i 's|../stylesheet|stylesheet|' $(BASEDIR)/index.html
	
	$(Q)mkdir -p $(BASEDIR)/images
	$(Q)cp images/*.{ico,png} $(BASEDIR)/images
	
	$(Q)cd $(BASEDIR)/; sed -e "s@../images@images@g"           \
                           -i *.html
	
	$(Q)mkdir -p $(BASEDIR)/patches
	$(Q)cp -r patches/* $(BASEDIR)/patches
	
	@echo "Kjører Tidy og obfuscate.sh på delt XHTML..."
	$(Q)for filename in `find $(BASEDIR) -name "*.html"`; do       \
      tidy -config tidy.conf $$filename;                          \
      true;                                                       \
      bash obfuscate.sh $$filename;                               \
      sed -i -e "1,20s@text/html@application/xhtml+xml@g" $$filename; \
   done;
	
	$(Q)$(CLEAN)

validate: $(RENDERTMP)/$(SLFSFULL)
$(RENDERTMP)/$(SLFSFULL): general.ent packages.ent $(ALLXML) $(ALLXSL) version
	$(Q)mkdir -p $(RENDERTMP)
	$(Q)trap '$(CLEAN)' EXIT
	
	@echo "Renderer boken for $(REV)..."
	$(Q)xsltproc --nonet                               \
                --xinclude                            \
                --output $(RENDERTMP)/$(SLFSHTML2) \
                --stringparam profile.revision $(REV) \
                stylesheets/lfs-xsl/profile.xsl       \
                index.xml
	
	@echo "Validerer boken..."
	$(Q)xmllint --nonet                             \
               --noent                             \
               --postvalid                         \
               --output $(RENDERTMP)/$(SLFSFULL)   \
               $(RENDERTMP)/$(SLFSHTML2)
	
profile-html: $(RENDERTMP)/$(SLFSHTML)
$(RENDERTMP)/$(SLFSHTML): $(RENDERTMP)/$(SLFSFULL) version
	@echo "Generating profiled XML for XHTML..."
	$(Q)xsltproc --nonet                              \
                --stringparam profile.condition html \
                --output $(RENDERTMP)/$(SLFSHTML)    \
                stylesheets/lfs-xsl/profile.xsl      \
                $(RENDERTMP)/$(SLFSFULL)

wget-list: $(BASEDIR)/wget-list
$(BASEDIR)/wget-list: $(RENDERTMP)/$(SLFSFULL) version
	@echo "Genererer wget liste for $(REV) på $(BASEDIR)/wget-list ..."
	$(Q)mkdir -p $(BASEDIR)
	$(Q)xsltproc --nonet                       \
                --output $(BASEDIR)/wget-list \
                stylesheets/wget-list.xsl     \
                $(RENDERTMP)/$(SLFSFULL)

test-links: $(BASEDIR)/test-links
$(BASEDIR)/test-links: $(RENDERTMP)/$(SLFSFULL) version
	@echo "Genererer test-links fil..."
	$(Q)mkdir -p $(BASEDIR)
	$(Q)xsltproc --nonet                        \
                --stringparam list_mode full   \
                --output $(BASEDIR)/test-links \
                stylesheets/wget-list.xsl      \
                $(RENDERTMP)/$(SLFSFULL)
	
	@echo "Sjekk av nettadresser, første omgang..."
	$(Q)rm -f $(BASEDIR)/{good,bad,true_bad}_urls
	$(Q)for URL in `cat $(BASEDIR)/test-links`; do                     \
         wget --spider --tries=2 --timeout=60 $$URL >>/dev/null 2>&1; \
         if test $$? -ne 0 ; then                                     \
            echo $$URL >> $(BASEDIR)/bad_urls ;                       \
         else                                                         \
            echo $$URL >> $(BASEDIR)/good_urls 2>&1;                  \
         fi;                                                          \
   done
	
	@echo "Sjekk av nettadresser, andre omgang..."
	$(Q)for URL2 in `cat $(BASEDIR)/bad_urls`; do                       \
         wget --spider --tries=2 --timeout=60 $$URL2 >>/dev/null 2>&1; \
         if test $$? -ne 0 ; then                                      \
           echo $$URL2 >> $(BASEDIR)/true_bad_urls ;                   \
         else                                                          \
           echo $$URL2 >> $(BASEDIR)/good_urls 2>&1;                   \
         fi; \
   done
	
	$(Q)$(CLEAN)

bootscripts:
	$(Q)trap '$(CLEAN)' EXIT
	@VERSION=`grep "bootscripts-version " general.ent | cut -d\" -f2`; \
   BOOTSCRIPTS="slfs-bootscripts-$$VERSION";                       \
   if [ ! -e $$BOOTSCRIPTS.tar.xz ]; then                             \
     rm -rf $(RENDERTMP)/$$BOOTSCRIPTS;                               \
     mkdir $(RENDERTMP)/$$BOOTSCRIPTS;                                \
     cp -a ../bootscripts/* $(RENDERTMP)/$$BOOTSCRIPTS;               \
     rm -rf ../bootscripts/archive;                                   \
     tar  -cJhf $$BOOTSCRIPTS.tar.xz -C $(RENDERTMP) $$BOOTSCRIPTS;   \
   fi

	$(Q)$(CLEAN)

systemd-units:
	$(Q)trap '$(CLEAN)' EXIT
		@VERSION=`grep "systemd-units-version " general.ent | cut -d\" -f2`; \
	UNITS="slfs-systemd-units-$$VERSION";                                \
	if [ ! -e $$UNITS.tar.xz ]; then                                     \
		rm -rf $(RENDERTMP)/$$UNITS;                                       \
		mkdir $(RENDERTMP)/$$UNITS;                                        \
		cp -a ../systemd-units/* $(RENDERTMP)/$$UNITS;                     \
		tar -cJhf $$UNITS.tar.xz -C $(RENDERTMP) $$UNITS;                  \
	fi

	$(Q)$(CLEAN)

test-options:
	$(Q)trap '$(CLEAN)' EXIT
	$(Q)xsltproc --xinclude --nonet stylesheets/test-options.xsl index.xml
	$(Q)$(CLEAN)

dump-commands: $(DUMPDIR)
$(DUMPDIR): $(RENDERTMP)/$(SLFSFULL) version
	@echo "Dumping av bokkommandoer på $(DUMPDIR)..."
	$(Q)xsltproc --output $(DUMPDIR)/          \
                stylesheets/dump-commands.xsl \
                $(RENDERTMP)/$(SLFSFULL)
	$(Q)touch $(DUMPDIR)
	$(Q)$(CLEAN)

.PHONY: slfs all world html validate profile-html wget-list \
  test-links dump-commands bootscripts systemd-units version test-options

version:
	$(Q)REV=$(REV) STAB=$(STAB) ./git-version.sh
