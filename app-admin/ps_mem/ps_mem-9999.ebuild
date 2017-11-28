# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{3,4,5}} )
DISTUTILS_SINGLE_IMPL=true
inherit distutils-r1 git-r3

DESCRIPTION="Utility to accurately report the in core memory usage for a program"
LICENSE="LGPL-2.1"
HOMEPAGE="https://github.com/pixelb/ps_mem"
EGIT_REPO_URI="https://github.com/pixelb/ps_mem"

SLOT="0"

python_install_all() {
	doman "${PN}.1"

	distutils-r1_python_install_all
}
