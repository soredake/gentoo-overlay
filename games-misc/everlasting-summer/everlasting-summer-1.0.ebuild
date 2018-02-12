# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Everlasting Summer is a visual novel about the days past."
HOMEPAGE="http://everlastingsummer.su/"

SRC_URI="everlasting_summer-${PV}-all.zip"
RESTRICT="fetch"

LICENSE="CC-BY-NC-SA-4.0"
SLOT="1.0"
KEYWORDS="amd64 ~x86"

IUSE="+system-renpy"

RDEPEND="system-renpy? ( games-engines/renpy )
	!system-renpy? (
		media-libs/freetype
		media-libs/glew
		media-libs/libjpeg-turbo
		media-libs/libpng
		media-libs/libsdl
		media-libs/sdl-image
		media-libs/sdl-sound
		media-libs/sdl-ttf
		media-video/ffmpeg
		sys-libs/zlib
	)"
DEPEND="app-arch/unzip"

QA_PREBUILT="/usr/share/${PN}/${PV}/lib/*"

S="${WORKDIR}/everlasting_summer-${PV}-all"

src_unpack() {
	unzip "${DISTDIR}/${A}" "everlasting_summer-${PV}-all/game/*" $(usex system-renpy "" "everlasting_summer-${PV}-all/renpy/*")
}

src_install() {
	if use system-renpy ; then
		insinto "/usr/share/${PN}/${PV}"
		doins -r game/.
		make_wrapper ${P} "renpy --savedir \${XDG_DATA_HOME}/everlasting_summer-${PV} '/usr/share/${PN}/${PV}'"
	else
		insinto /usr/share/${PN}/${PV}
		doins -r game renpy "Everlasting Summer.py"
		make_wrapper ${P} "/usr/share/${PN}/${PV}/Everlasting Summer.py" "/usr/share/${PN}/${PV}/game"
		fperms +x "/usr/share/${PN}/${PV}/Everlasting Summer.sh"
	fi

	newicon "${FILESDIR}"/es.png ${PN}.png
	make_desktop_entry "${P}" "Everlasting Summer" "${PN}" "Game" "GenericName=Everlasting Summer version ${PV}"
}

pkg_postinst() {
	elog "Savegames from system-renpy and the bundled version are incompatible"

	if use system-renpy; then
		ewarn "system-renpy is unstable and not supported upstream"
	fi
}
