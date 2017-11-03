# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils cmake-utils

DESCRIPTION="Colobot (Colonize with Bots) is an educational real-time strategy video game featuring 3D graphics"
HOMEPAGE="https://colobot.info/"
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/colobot/colobot"
	inherit git-r3
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/${PN}-gold-${PV}-alpha.zip"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${PN}-gold-${PV}-alpha"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/boost
	media-libs/libsdl2
	media-libs/sdl2-image
	media-libs/sdl2-ttf
	media-libs/glew:0
	media-libs/libpng:0
	sys-devel/gettext
	media-libs/libsndfile
	media-libs/libvorbis
	media-libs/libogg
	media-libs/openal
	dev-games/physfs
	media-sound/vorbis-tools
"
RDEPEND="${DEPEND}
	games-strategy/colobot-data
"
