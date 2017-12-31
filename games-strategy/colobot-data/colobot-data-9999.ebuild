# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils git-r3 cmake-utils

DESCRIPTION="Data package for colobot (Colonize with Bots)"
HOMEPAGE="https://colobot.info/"

EGIT_REPO_URI="https://github.com/colobot/colobot-data"

LICENSE="GPL-3"
SLOT="0"
IUSE="+music +music_flac music_ogg"
REQUIRED_USE="
	music? ( ^^ ( music_flac music_ogg ) )
	music_flac? ( music )
	music_ogg? ( music )
"

src_unpack() {
	git-r3_src_unpack
	git-r3_fetch https://github.com/colobot/colobot-music
	git-r3_checkout https://github.com/colobot/colobot-music "${S}"/music_temp
	use music_flac && mv "${S}"/music_temp/*.flac "${S}"/music
	use music_ogg && mv "${S}"/music_temp/*.ogg "${S}"/music
	rm -r "${S}"/music_temp
}

src_prepare() {
	cmake-utils_src_prepare
	use music_flac && sed -i -e '31,38d' -e '82,95d' music/CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DMUSIC="$(usex music)"
		-DMUSIC_FLAC="$(usex music_flac)"
	)
	cmake-utils_src_configure
}
