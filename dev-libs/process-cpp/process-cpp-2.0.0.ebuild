# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Provides a C++ API for D-BUS"
HOMEPAGE="https://sourceforge.net/projects/dbus-cplusplus/ https://sourceforge.net/apps/mediawiki/dbus-cplusplus/index.php?title=Main_Page"
SRC_URI="https://github.com/zhsj/process-cpp/archive/2887d1a9b2ac588ba42b1afff475275d44e4ceb3.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="doc ecore glib static-libs test"

CDEPEND="dev-libs/boost"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}"

#S=${WORKDIR}/lib${P}

PATCHES=(
	"${FILESDIR}"/${P}-gcc-4.7.patch #424707
	"${FILESDIR}"/${PN}-gcc7.patch #622790
)

multilib_src_configure() {
	# not just using autotools-multilib_src_configure because of multilib_native... logic

	# TODO : add ecore multilib support if/when it is multilibified
	ECONF_SOURCE="${S}" econf \
		--disable-examples \
		$(multilib_native_use_enable doc doxygen-docs) \
		$(multilib_native_use_enable ecore) \
		$(use_enable glib) \
		$(use_enable static-libs static) \
		$(use_enable test tests) \
		PTHREAD_LIBS=-lpthread
	# ACX_PTHREAD sets PTHREAD_CFLAGS but not PTHREAD_LIBS for some reason...

	if multilib_is_native_abi; then
		# docs don't like out-of-source builds
		local d
		for d in img html; do
			ln -s "${S}"/doc/${d} "${BUILD_DIR}"/doc/${d} || die
		done
	fi
}

multilib_src_install_all() {
	einstalldocs

	if use doc; then
		dohtml -r "${S}"/doc/html/*
	fi
}
