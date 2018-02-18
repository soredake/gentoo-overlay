# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="Display information about a Blu-ray disc"
HOMEPAGE="https://github.com/beandog/bluray_info"
EGIT_REPO_URI="https://github.com/beandog/bluray_info.git"

LICENSE="GPL-2"
SLOT="0"

DEPEND=">=media-libs/libbluray-1.0.0"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	eapply_user
}

