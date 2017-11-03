# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Un-official open source recreation of the classic Grand Theft Auto III game executable"
HOMEPAGE="https://github.com/rwengine/openrw"
EGIT_REPO_URI="https://github.com/rwengine/openrw"

LICENSE="GPL-3+"
IUSE="viewer"
SLOT="0"

RDEPEND="media-libs/glm
	media-libs/libsdl2[opengl]
	media-libs/mesa
	media-video/ffmpeg
	media-libs/openal
	sci-physics/bullet
	viewer? (
		dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtopengl:5
	)
	"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DBUILD_VIEWER=$(usex viewer)
	)
	cmake-utils_src_configure
}
