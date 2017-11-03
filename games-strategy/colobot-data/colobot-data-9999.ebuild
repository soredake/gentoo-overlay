# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils

DESCRIPTION="Data package for colobot (Colonize with Bots)"
HOMEPAGE="https://colobot.info/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/colobot/colobot-data"
	inherit git-r3
else
	SRC_URI="https://github.com/colobot/${PN}/archive/colobot-gold-${PV}-alpha.zip"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-data-${PN}-gold-${PV}-alpha"
fi

LICENSE="GPL-3"
SLOT="0"

src_install() {
	insinto /usr/share/colobot
	doins -r .
}
