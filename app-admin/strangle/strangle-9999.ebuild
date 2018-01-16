# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 multilib-minimal

DESCRIPTION="Frame rate limiter for Linux/OpenGL"
HOMEPAGE="https://github.com/torkel104/libstrangle"
EGIT_REPO_URI="https://github.com/torkel104/libstrangle.git"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i -e "s|prefix=.*|prefix=/usr|" -e 's|LIB32_PATH=.*|LIB32_PATH=$(prefix)/lib|' -e 's|LIB64_PATH=.*|LIB64_PATH=$(prefix)/lib64|' -e '/^all/s/$(BUILDDIR)libstrangle.conf//' -e '/libstrangle.conf/d' makefile || die
}

multilib_src_compile() {
	CFLAGS="${CFLAGS} -rdynamic -fPIC -shared -Wall -std=c99 -fvisibility=hidden -DHOOK_DLSYM"
	LDFLAGS="-Wl,-z,relro,-z,now"
	LDLIBS="-ldl -lrt"
	${CC}
}

multilib_src_install() {
	default
	echo ""
	newbin src/strangle.sh strangle
}
