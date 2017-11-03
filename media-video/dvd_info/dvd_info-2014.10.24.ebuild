# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Display information about a DVD disc"
HOMEPAGE="http://dvds.beandog.org/doku.php?id=dvd_info"
SRC_URI="http://bluray.beandog.org/dvd_info/dvd_info-2014-10-24.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	media-libs/libdvdcss
	media-libs/libdvdread
	dev-libs/jansson
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/dvd_info-2014-10-24"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	dobin dvd_info dvd_eject dvd_drive_status
}
