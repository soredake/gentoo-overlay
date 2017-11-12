# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic git-r3 qmake-utils

DESCRIPTION="A tiny RSS and Atom feed reader"
HOMEPAGE="https://github.com/martinrotter/rssguard"
EGIT_REPO_URI="https://github.com/martinrotter/rssguard.git"
EGIT_SUBMODULES=()

LICENSE="GPL-3"
SLOT="0"
IUSE="debug webengine"
MINQT="5.8"

RDEPEND="
	>=dev-qt/qtcore-${MINQT}:5
	>=dev-qt/qtgui-${MINQT}:5
	>=dev-qt/qtnetwork-${MINQT}:5
	>=dev-qt/qtsql-${MINQT}:5
	>=dev-qt/qtwidgets-${MINQT}:5
	>=dev-qt/qtxml-${MINQT}:5
	webengine? ( >=dev-qt/qtwebengine-${MINQT}:5[widgets] )
"
DEPEND="${RDEPEND}
	>=dev-qt/linguist-tools-${MINQT}:5
"

src_configure() {
	# needed after 8eb640b6f2e140e7c5a1adbe5532cf3662d850b5
	"$(qt5_get_bindir)/lrelease" rssguard.pro
	# CONFIG+=ltcg is needed because of https://github.com/martinrotter/rssguard/issues/156
	eqmake5 \
		CONFIG+=$(usex debug debug release) \
		$(is-flagq -flto* && echo "CONFIG+=ltcg") \
		USE_WEBENGINE=$(usex webengine true false) \
		LRELEASE_EXECUTABLE="$(qt5_get_bindir)/lrelease" \
		PREFIX="${EPREFIX}"/usr \
		INSTALL_ROOT=.
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}
