# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Fully decentralized P2P microblogging platform"
HOMEPAGE="http://twister.net.co/"
EGIT_REPO_URI="https://github.com/miguelfreitas/twister-core"

LICENSE="MIT BSD"
SLOT="0"

IUSE="tk"

RDEPEND="dev-libs/openssl:0[-bindist]
	>=sys-libs/db-4.8:*
	dev-libs/boost
	net-libs/miniupnpc
	tk? ( dev-lang/python:2.7[tk] )"

DEPEND="${RDEPEND}"

#src_prepare() {
#	cd "${S}"/libtorrent
#	./bootstrap.sh
#	cd "${S}"
#}

#src_configure() {
#	cd "${S}"/libtorrent
#	econf --enable-logging --enable-debug --enable-dht
#}

#src_compile() {
#	cd "${S}"/libtorrent
#	emake
#	cd "${S}"/src
#	emake -f makefile.unix
#}

src_install(){
	default

	use tk || rm -f "${D}/usr/bin/twister-control"
	use tk || rm -f "${D}/usr/share/applications/twister-control.desktop"

	exeinto "/usr/bin/"
	doexe "${FILESDIR}/twister-html-install"
	doexe "${FILESDIR}/twister-html-update"
}

pkg_postinst() {
	elog "Before running twister, each user must set up twister's HTML files"
	elog "in ~/.twister/html and the configs in ~/.twister/twister.conf."
	elog "They can do this by running twister-html-install."
	elog ""
	elog "To keep the HTML files up to date, run twister-html-update."
}
