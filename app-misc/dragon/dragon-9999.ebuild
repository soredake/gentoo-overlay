# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Drag and drop source/target for X"
HOMEPAGE="https://github.com/mwh/dragon"
EGIT_REPO_URI="https://github.com/mwh/dragon"

LICENSE="GPL-3"
SLOT="0"

DEPEND="x11-libs/gtk+:3"
RDEPEND="${DEPEND}"

src_configure() {
	sed -i 's|$(HOME)/.local|${ED}/usr|g' Makefile || die
}
