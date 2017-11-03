# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )
PYTHON_REQ_USE="ncurses"

inherit distutils-r1

SRC_URI="https://github.com/ellisonleao/vl/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

DESCRIPTION="A URL link checker CLI for text files"
HOMEPAGE="https://github.com/ellisonleao/vl/"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/click
	 dev-python/grequests
	 dev-python/six"
