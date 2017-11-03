# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils cmake-utils

DESCRIPTION="Colobot (Colonize with Bots) is an educational real-time strategy video game featuring 3D graphics"
HOMEPAGE="https://colobot.info/"
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/colobot/colobot"
	EGIT_SUBMODULES=()
	inherit git-r3
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/${PN}-gold-${PV}-alpha.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${PN}-gold-${PV}-alpha"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="devbuild test tools doc +openal"

DEPEND="
	dev-games/physfs
	dev-libs/boost
	media-libs/glew:0
	media-libs/libogg
	media-libs/libpng:0
	media-libs/libsdl2
	media-libs/libsndfile
	media-libs/libvorbis
	media-libs/openal
	media-libs/sdl2-image
	media-libs/sdl2-ttf
	media-sound/vorbis-tools
	sys-devel/gettext
"
RDEPEND="${DEPEND}
	games-strategy/colobot-data
"
src_prepare() {
	default
	sed -i 's|${CMAKE_INSTALL_PREFIX}/games|${CMAKE_INSTALL_PREFIX}/bin|' CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DDEV_BUILD="$(usex devbuild)"
		-DTESTS="$(usex test)"
		-DTOOLS="$(usex tools)"
		-DINSTALL_DOCS="$(usex doc)"
		-DOPENAL_SOUND="$(usex openal)"
	)
	cmake-utils_src_configure
}
