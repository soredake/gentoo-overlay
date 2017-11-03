# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="Display information about a DVD disc"
HOMEPAGE="http://dvds.beandog.org/doku.php?id=dvd_info"
EGIT_REPO_URI="https://github.com/beandog/dvd_info"

LICENSE="GPL-2"
SLOT="0"

DEPEND="
	media-libs/libdvdcss
	media-libs/libdvdread
	dev-libs/jansson
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	# there is no dvd_cat yet
	sed -e "s/^dvd_cat.*//g" -e "s/dvd_cat//g" -i Makefile.am || die
	eautoreconf
}
