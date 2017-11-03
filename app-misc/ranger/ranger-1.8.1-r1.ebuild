# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )
PYTHON_REQ_USE="ncurses"

inherit distutils-r1 eutils

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/ranger/ranger"
	inherit git-r3
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A vim-inspired file manager for the console"
HOMEPAGE="http://ranger.nongnu.org/"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="virtual/pager"

src_prepare() {
	sed -i "s|share/doc/ranger|share/doc/${PF}|" setup.py doc/ranger.1 || die
	distutils-r1_src_prepare
}

pkg_postinst() {
	optfeature "For determining file types" sys-apps/file
	optfeature "In case of encoding detection problems" dev-python/chardet
	optfeature "To use the 'run as root'-feature" app-admin/sudo
	optfeature "To preview images" virtual/w3m
	optfeature "For ASCII-art image previews" media-libs/libcaca
	optfeature "For syntax highlighting of code" app-text/highlight dev-python/pygments
	optfeature "For previews of archives" app-arch/atool app-arch/libarchive app-arch/unrar
	optfeature "For previews of html pages" www-client/lynx virtual/w3m www-client/elinks
	optfeature "For pdf previews" app-text/poppler
	optfeature "For viewing bit-torrent information" net-p2p/transmission
	optfeature "For viewing information about media files" media-video/mediainfo media-libs/exiftool
	optfeature "For viewing OpenDocument text files (odt, ods, odp and sxw)" app-text/odt2txt
}
