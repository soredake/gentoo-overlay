# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )
inherit meson python-single-r1 git-r3 xdg-utils gnome2-utils

DESCRIPTION="GTK application to configure gaming mice"
HOMEPAGE="https://github.com/libratbag/piper"
EGIT_REPO_URI="https://github.com/libratbag/piper.git"

LICENSE="MIT"
SLOT="0"
IUSE="doc test"

DEPEND="
	x11-libs/gtk+:3
	dev-python/pygobject:3
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"
RDEPEND="
	dev-libs/libratbag
	dev-libs/libevdev
	virtual/libudev
"

src_prepare() {
	default
	sed -i "s/meson.add_install_script('meson_install.sh')//" meson.build
	python_setup 'python3*'
}

src_configure() {
	local emesonargs=(
		-Denable-documentation=$(usex doc true false)
		-Denable-tests=$(usex test true false)
	)
	meson_src_configure
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
