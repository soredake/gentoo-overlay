# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator

DESCRIPTION="Smooth and meditative game from the creators of \"Everlasting Summer\"."
HOMEPAGE="https://moonworks.ru/"

SRC_URI="https://download.moonworks.ru/travnica-${PV}-linux-nosteam.tar.bz2"
#RESTRICT="fetch"
MY_V="$(get_version_component_range 1-2)"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE="doc +system-renpy"

RDEPEND="system-renpy? ( games-engines/renpy )
	media-libs/freetype
	media-libs/glew
	media-libs/libjpeg-turbo
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-sound
	media-libs/sdl-ttf
	media-video/ffmpeg
	sys-libs/zlib"
DEPEND="app-arch/tar"

QA_PREBUILT="/usr/share/${PN}/lib/*"

S="${WORKDIR}/travnica-${MY_V}-linux"

#src_unpack() {
#	unpack "${DISTDIR}/${A}" "travnica-${MY_V}-linux/game/*" "travnica-${MY_V}-linux/mods/*" $(usex system-renpy "" "travnica-${MY_V}-linux/renpy/*")
#}

src_install() {
	if use system-renpy ; then
		insinto "/usr/share/${PN}"
		doins -r game mods
		make_wrapper travnica "renpy --savedir \${XDG_DATA_HOME}/travnica '/usr/share/${PN}/game'"
	else
		insinto /usr/share/${PN}
		doins -r game mods renpy travnica.py
		make_wrapper travnica "/usr/share/${PN}/travnica.py" "/usr/share/${PN}/game"
		fperms +x "/usr/share/${PN}/travnica.py"
	fi

	#newicon "${FILESDIR}"/es.png ${PN}.png
	make_desktop_entry "${PN}" "The Herbalist" "${PN}" "Game"
	use doc && dodoc readme*
}

pkg_postinst() {
	elog "Savegames from system-renpy and the bundled version are incompatible"

	if use system-renpy; then
		ewarn "system-renpy is unstable and not supported upstream"
	fi
}
