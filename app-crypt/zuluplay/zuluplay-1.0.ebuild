# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

ZULUCRYPT_V="5.2.0"

DESCRIPTION="ZuluCrypt's fork of the original tcplay with support for VeraCrypt volumes"
HOMEPAGE="https://github.com/mhogomchungu/zuluCrypt/tree/master/external_libraries/zuluplay"
SRC_URI="https://github.com/mhogomchungu/zuluCrypt/releases/download/${PV}/zuluCrypt-${ZULUCRYPT_V}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

CDEPEND="
	dev-libs/libgcrypt:0=
	sys-apps/util-linux
	sys-fs/cryptsetup
	sys-fs/lvm2
	dev-libs/libgpg-error
"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	virtual/pkgconfig
"
S="${WORKDIR}/zuluCrypt-${ZULUCRYPT_V}/external_libraries/zuluplay"
