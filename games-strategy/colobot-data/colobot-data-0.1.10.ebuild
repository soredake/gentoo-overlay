# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils cmake-utils

DESCRIPTION="Data package for colobot (Colonize with Bots)"
HOMEPAGE="https://colobot.info/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/colobot/colobot-data"
	inherit git-r3
else
	SRC_URI="
	https://github.com/colobot/${PN}/archive/colobot-gold-${PV}-alpha.tar.gz -> ${P}.tar.gz
	music_ogg? ( https://colobot.info/files/music/colobot-music_ogg_${PV}-alpha.tar.gz -> ${P}-music-ogg.tar.gz )
	music_flac? ( https://colobot.info/files/music/colobot-music_flac_${PV}-alpha.tar.gz -> ${P}-music-flac.tar.gz )
	"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-colobot-gold-${PV}-alpha"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+music +music_flac music_ogg"
REQUIRED_USE="
	music? ( ^^ ( music_flac music_ogg ) )
	music_flac? ( music )
	music_ogg? ( music )
"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}" || die
	local list
	#use music_flac && list+=( flac )
	#use music_ogg && list+=( ogg )
	#for q in "${list[@]}"; do
		tar xf "${DISTDIR}/${P}"-music-*.tar.gz -C "${S}/music" || die "Failed to unpack musc"
	#done
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

#src_install() {
#	insinto /usr/share/colobot
#	doins -r .
#}
