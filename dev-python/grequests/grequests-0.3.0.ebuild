# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1

DESCRIPTION="GRequests allows you to use Requests with Gevent to make asyncronous HTTP Requests easily"
HOMEPAGE="https://github.com/kennethreitz/grequests"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-python/gevent
	dev-python/requests
	dev-python/nose
	dev-python/setuptools"
RDEPEND="${DEPEND}"

RESTRICT="test"
