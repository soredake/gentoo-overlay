# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="A tesseract OCR front-end"
HOMEPAGE="https://github.com/manisandro/gImageReader"
SRC_URI="https://github.com/manisandro/gImageReader/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk +qt5"
REQUIRED_USE="?? ( gtk qt5 )"

DEPEND="app-text/tesseract
	app-text/podofo
	gtk? (
		app-text/gtkspell[introspection]
		app-text/poppler[introspection]
		dev-cpp/cairomm
		dev-cpp/gtkmm
		dev-cpp/libxmlpp
		dev-libs/json-glib
		x11-libs/gtksourceview
	)
	qt5? (
		app-text/poppler[qt5]
		app-text/qtspell
		dev-qt/qtcore:5
	)
	media-gfx/sane-backends"

src_configure() {
	local mycmakeargs=(
		-DINTERFACE_TYPE=$(usex gtk gtk qt5)
	)
	cmake-utils_src_configure
}
