# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{5,6} )

inherit xdg-utils distutils-r1 git-r3 gnome2-utils flag-o-matic

DESCRIPTION="A modern, hackable, featureful, OpenGL based terminal emulator"
HOMEPAGE="https://github.com/kovidgoyal/kitty"
EGIT_REPO_URI="https://github.com/kovidgoyal/kitty.git"

LICENSE="GPL-3"
SLOT="0"
IUSE="X"

CDEPEND="dev-libs/libunistring
	media-libs/glfw
	>=media-libs/glew-2.0.0
	>=media-libs/harfbuzz-1.5.1
	media-libs/fontconfig"
DEPEND="virtual/pkgconfig
	${CDEPEND}"
RDEPEND="X? ( || ( x11-apps/xrdb x11-misc/xsel ) )
	${CDEPEND}"

src_prepare() {
	default
	python_setup 'python3*'
	local opt="$(get-flag -O)"
	sed -i -e "s/O3/${opt#-}/g" -e 's/-Werror//g' setup.py || die
}

src_install() {
	python3 setup.py linux-package --prefix "${ED}"
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
