# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Frame rate limiter for Linux/OpenGL"
HOMEPAGE="https://github.com/torkel104/libstrangle"
EGIT_REPO_URI="https://github.com/torkel104/libstrangle.git"

LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	default
	sed -i -e "s|prefix=.*|prefix=/usr|" -e 's|LIB32_PATH=.*|LIB32_PATH=$(prefix)/lib32|' -e 's|LIB64_PATH=.*|LIB64_PATH=$(prefix)/lib64|' -e '/^all/s/$(BUILDDIR)libstrangle.conf//' -e '/libstrangle.conf/d' makefile || die
}

src_install() {
	default
	newbin src/strangle.sh strangle
}
