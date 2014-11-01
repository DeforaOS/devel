TARGETS	= $(OBJDIR)ar
OBJDIR	=
PREFIX	= /usr/local
DESTDIR	=
BINDIR	= $(PREFIX)/bin
SBINDIR	= $(PREFIX)/sbin
CC	= cc
CPPFLAGSF= -I ../include
CPPFLAGS=
CFLAGSF	= -W
CFLAGS	= -Wall -g -O2 -pedantic
RM	= rm -f
LN	= ln -f
MKDIR	= mkdir -m 0755 -p
INSTALL	= install


all: $(TARGETS)

ar_OBJS = $(OBJDIR)ar.o
ar_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)
ar_LDFLAGS = $(LDFLAGSF) $(LDFLAGS)

$(OBJDIR)ar: $(ar_OBJS)
	$(CC) -o $(OBJDIR)ar $(ar_OBJS) $(ar_LDFLAGS)

$(OBJDIR)ar.o: ar.c
	$(CC) $(ar_CFLAGS) -o $(OBJDIR)ar.o -c ar.c

clean:
	$(RM) -- $(ar_OBJS)

distclean: clean
	$(RM) -- $(TARGETS)

install: $(TARGETS)
	$(MKDIR) $(DESTDIR)$(BINDIR)
	$(INSTALL) -m 0755 $(OBJDIR)ar $(DESTDIR)$(BINDIR)/ar

uninstall:
	$(RM) -- $(DESTDIR)$(BINDIR)/ar

.PHONY: all clean distclean install uninstall
