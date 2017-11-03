# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A script that lets you see what videos you have in your mpv watch_later folder and enables you to continue watching them with a menu"
HOMEPAGE="https://github.com/hbers/mpv-watch-later-menu"
EGIT_REPO_URI="https://github.com/hbers/mpv-watch-later-menu"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="app-shells/bash:0"

DEPEND="${RDEPEND}"

src_install() {
	newbin ${PN}.sh ${PN}
}
