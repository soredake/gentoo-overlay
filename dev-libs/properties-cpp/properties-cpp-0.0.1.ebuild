# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Provides a C++ API for D-BUS"
HOMEPAGE="https://github.com/yunit-io/properties-cpp"
SRC_URI="https://github.com/yunit-io/properties-cpp/archive/debian/0.0.1+14.10.20140730-0yunit0+debian+9.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-cpp/gmock"
RDEPEND="${DEPEND}"

S="${WORKDIR}/properties-cpp-debian-0.0.1-14.10.20140730-0yunit0-debian-9"

src_prepare() {
	default
	sed -i -e "s|/usr/src/gmock/gtest/include|/usr/include|g" cmake/FindGtest.cmake
}

src_configure() {
	local mycmakeargs=(
		-DGMOCK_INSTALL_DIR=
	)
	cmake-utils_src_configure
}
