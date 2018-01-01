# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils git-r3 cmake-utils

DESCRIPTION="Data package for colobot (Colonize with Bots)"
HOMEPAGE="https://colobot.info/"

EGIT_REPO_URI="https://github.com/colobot/colobot-data"
SRC_URI="music_ogg? ( https://colobot.info/files/music/colobot-music_ogg_latest.tar.gz -> ${P}-music-ogg.tar.gz )
	music_flac_convert? ( https://colobot.info/files/music/colobot-music_flac_latest.tar.gz -> ${P}-music-flac.tar.gz )"

DEPEND="music_flac_convert? ( media-sound/vorbis-tools )"

LICENSE="GPL-3"
SLOT="0"
IUSE="+music music_flac_convert +music_ogg"
REQUIRED_USE="
	music? ( ^^ ( music_flac_convert music_ogg ) )
	music_flac_convert? ( music )
	music_ogg? ( music )
"

src_unpack() {
	git-r3_src_unpack
	use music && tar xf "${DISTDIR}/${P}"-music-*.tar.gz -C "${S}/music" || die "Failed to unpack music"
}

src_prepare() {
	cmake-utils_src_prepare
	use music && sed -i -e '/find_program(WGET wget)/d' -e '/if(NOT WGET)/,+2 d' music/CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DMUSIC="$(usex music)"
		-DMUSIC_FLAC="$(usex music_flac_convert)"
		-DMUSIC_QUALITY="${COLOBOT_DATA_MUSIC_QUALITY:-4}"
	)
	cmake-utils_src_configure
}
