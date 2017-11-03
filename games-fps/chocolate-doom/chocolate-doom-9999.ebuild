# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} pypy2_0 )
EGIT_REPO_URI="https://github.com/chocolate-doom/chocolate-doom"

inherit eutils autotools python-any-r1 git-r3

DESCRIPTION="Doom, Heretic, Hexen and Strife port designed to act identically to original games"
HOMEPAGE="https://www.chocolate-doom.org"

LICENSE="GPL-2"
SLOT="0"

IUSE="+doom heretic hexen strife server timidity"

RDEPEND="media-libs/libsamplerate
	>=media-libs/libsdl-1.1.3:0
	media-libs/sdl-mixer[timidity?]
	media-libs/sdl-net"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}"

pkg_setup() {
	games_pkg_setup
	python-any-r1_pkg_setup
}

src_prepare() {
	# Change default search path for IWAD
	sed -i \
		-e "s:/usr/share/games/doom:${GAMES_DATADIR}/doom-data:" \
		src/d_iwad.c man/INSTALL.template || die "sed failed"
	sed -i \
		-e "s:^gamesdir =.*:gamesdir = ${GAMES_BINDIR}:" \
		src/setup/Makefile.am || die "sed Makefile.am failed"

	eautoreconf
}

src_configure() {
	egamesconf \
		#--disable-sdltest
}

src_install() {
	doicon data/${PN}.png
	doicon data/chocolate-setup.png

	dogamesbin src/chocolate-setup
	make_desktop_entry chocolate-setup "Chocolate Setup" \
		chocolate-setup "Settings"
	doman man/chocolate-setup.6
	doman man/default.cfg.5

	local opt game game_full
	for opt in "doom Doom" \
		"heretic Heretic" \
		"strife Strife" \
		"hexen Hexen"
	do
		game=${opt%% *}
		game_full=${opt#* }
		if use $game ; then
			dogamesbin src/chocolate-${game}
			dosym chocolate-setup "${GAMES_BINDIR}/chocolate-${game}-setup"

			make_desktop_entry chocolate-${game} \
				"Chocolate ${game_full}" ${PN} "Game;Shooter"
			make_desktop_entry chocolate-${game}-setup \
				"Chocolate ${game_full} Setup" chocolate-setup "Settings"

			doman man/*${game}*.{5,6}
		fi
	done

	if use server ; then
		dogamesbin src/chocolate-server
		doman man/chocolate-server.6
	fi

	domenu src/${PN}-screensaver.desktop
	dodoc AUTHORS ChangeLog HACKING NEWS NOT-BUGS README* TODO

	keepdir "${GAMES_DATADIR}/doom-data"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	einfo
	einfo "To play the original Doom levels, place doom.wad and/or doom2.wad"
	einfo "into ${GAMES_DATADIR}/doom-data, then run: ${PN}"
	einfo
	einfo "To configure game options run: chocolate-setup"
	einfo
}
