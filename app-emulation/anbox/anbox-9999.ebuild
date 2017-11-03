# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Container-based approach to boot a full Android system on a regular GNU/Linux system"
HOMEPAGE="https://anbox.io/"
EGIT_REPO_URI="https://github.com/anbox/anbox"

LICENSE="GPL-3"
IUSE=""
SLOT="0"

RDEPEND="sys-apps/dbus
	dev-cpp/gmock
	dev-cpp/gtest
	dev-libs/boost[threads]
	sys-libs/libcap
	dev-libs/dbus-c++
	media-libs/mesa[egl,gles2]
	dev-libs/glib
	media-libs/libsdl2
	media-libs/sdl2-image
	dev-libs/protobuf
	app-emulation/lxc"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

#src_configure() {
#	local mycmakeargs=(
#		-DBUILD_VIEWER=$(usex viewer)
#	)
#	cmake-utils_src_configure
#}
