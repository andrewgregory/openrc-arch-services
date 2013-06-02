INPUT_FILES = ${wildcard init.d/*.in}
INIT_FILES  = ${INPUT_FILES:.in=}
CONF_FILES  = ${wildcard conf.d/*}

PREFIX     ?= /usr/local
SYSCONFDIR ?= ${PREFIX}/etc
SBINDIR    ?= ${PREFIX}/sbin

INITDIR = ${DESTDIR}/${SYSCONFDIR}/init.d
CONFDIR = ${DESTDIR}/${SYSCONFDIR}/conf.d

all: ${INIT_FILES} ${CONF_FILES}

%: %.in
	sed -e 's:@SBINDIR@:${SBINDIR}:g' $< > $@

install: ${INIT_FILES}
	install -d "${INITDIR}" "${CONFDIR}"
	install -m 755 -t "${INITDIR}" ${INIT_FILES}
	install -m 644 -t "${CONFDIR}" ${CONF_FILES}
