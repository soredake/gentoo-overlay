# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Command line script to handle Firefox and Thunderbird extensions"
HOMEPAGE="https://github.com/NicolasBernaerts/ubuntu-scripts"
EGIT_REPO_URI="https://github.com/NicolasBernaerts/ubuntu-scripts"

SLOT="0"

RDEPEND="
	app-shells/bash:0
	app-arch/unzip
	net-misc/wget"
DEPEND="${RDEPEND}"

src_install() {
	dobin mozilla/${PN}
}
