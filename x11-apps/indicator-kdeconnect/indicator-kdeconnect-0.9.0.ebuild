# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils vala gnome2

DESCRIPTION="AppIndicator for KDE Connect"
HOMEPAGE="https://github.com/Bajoja/indicator-kdeconnect"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="$(vala_depend)
	dev-libs/libappindicator:3
	dev-python/requests-oauthlib
	kde-misc/kdeconnect
	x11-libs/gtk+:3"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	vala_src_prepare
	sed -i -e '28,35d' "${S}/data/CMakeLists.txt"
	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
		-DGSETTINGS_COMPILE=NO
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}

pkg_preinst() {
	gnome2_pkg_preinst
}

pkg_postinst() {
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}
