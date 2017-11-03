# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils cmake-utils

DESCRIPTION="LiteTran is simple text translate utility. It uses Yandex.Translate"
HOMEPAGE="https://gfarniev.bitbucket.io/litetran/"
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://bitbucket.org/gfarniev/litetran"
	inherit git-r3
else
	SRC_URI="https://bitbucket.org/gfarniev/${PN}/get/${PV}.tar.bz2"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtmultimedia:5
	dev-qt/assistant:5
	dev-qt/qtx11extras:5"
RDEPEND="${DEPEND}"
