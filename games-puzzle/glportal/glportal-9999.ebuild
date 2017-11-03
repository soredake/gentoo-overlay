# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Open Source sci-fi first person puzzle-platformer with realistic physic simulation."
HOMEPAGE="https://glportal.de/"
EGIT_REPO_URI="https://github.com/GlPortal/glPortal"
#EGIT_SUBMODULES=( '*' '-external/RadixEngine' )

LICENSE="GPL-3+ MIT Apache-2"
IUSE="test"
SLOT="0"

RDEPEND="media-libs/assimp
	media-libs/libepoxy
	media-libs/libsdl2
	media-libs/sdl2-mixer
	media-libs/freeimage
	sci-physics/bullet
	dev-libs/tinyxml2
	media-libs/mesa"

DEPEND="${RDEPEND}
	test? ( dev-libs/unittest++ )
	virtual/pkgconfig"

src_prepare() {
	cmake-utils_src_prepare
	sed -i -e "/git describe --always/d" -e "/git update-index --assume-unchanged/d" CMakeLists.txt || die
	sed -i -e "/LICENSE.MIT/d" -e "/LICENSE.APACHE/d" -e "s/bin/$(get_libdir)/g" external/RadixEngine/external/easy_profiler/easy_profiler_core/CMakeLists.txt || die
	sed -i -e "s/TARGETS VHACD_LIB DESTINATION bin/TARGETS VHACD_LIB DESTINATION $(get_libdir)/g" external/RadixEngine/external/vhacd-lib/CMakeLists.txt || die
}
