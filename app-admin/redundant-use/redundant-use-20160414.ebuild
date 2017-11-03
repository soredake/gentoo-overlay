# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit vcs-snapshot

DESCRIPTION="Prints diagnostics pertaining to redundant USE flags specified in make.conf package.use/*"
HOMEPAGE="https://gist.github.com/whitslack/7a831faf3c6b0abf64077faeaafed015"
SRC_URI="${HOMEPAGE}/archive/9fcb9192ac844c4f7dda3e92632fa8b07c687d77.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="amd64"

RDEPEND="app-shells/bash:0"
DEPEND="${RDEPEND}"

src_install() {
	newbin ${PN}.sh ${PN}
}
