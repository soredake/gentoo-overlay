# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Xash3D FWGS Engine"
HOMEPAGE="https://github.com/FWGS/xash3d"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/FWGS/xash3d"
	inherit git-r3
else
	SRC_URI="
	https://github.com/FWGS/xash3d/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/FWGS/nanogl/archive/98a2f2a11ba4f626620fce19fcd7ae8a2d7e3b8a.tar.gz -> ${P}-nanogl.tar.gz
	https://github.com/FWGS/halflife/archive/235f2f448f5cab7251206f8ff1f242e30346a4d4.tar.gz -> ${P}-hlsdk.tar.gz
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+X +sdl dedicated +dll-loader static gles gles-fixes +vgui force-64bit"

RDEPEND="
	sdl? (
		gles-fixes? ( media-libs/libsdl2[-opengl] )
		!gles-fixes? ( media-libs/libsdl2 )
	)"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

REQUIRED_USE="
	|| ( sdl dedicated )
	gles-fixes? ( gles )
	sdl? ( X )
	vgui? ( !force-64bit )"

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}"
	list=( hlsdk )
	if use gles; then
		mkdir nanogl
		list+=( nanogl )
	fi
	local i
	for i in "${list[@]}"; do
		tar xf "${DISTDIR}/${P}-${i}.tar.gz" --strip-components 1 -C "${i}"
	done
}

detect_bits() {
	mycmakeparams=()
	if use amd64; then
		if use force-64bit; then
			mycmakeparams+=( -DXASH_64BIT=yes )
		else
			mycmakeparams+=(
				-DCMAKE_CXX_FLAGS=-m32
				-DCMAKE_C_FLAGS=-m32
				-DCMAKE_EXE_LINKER_FLAGS=-m32
			)
		fi
	fi

	if ! use force-64bit; then
		mycmakeparams+=( -DLIB_SUFFIX="32" )
	fi
}

src_configure() {
	detect_bits
	local mycmakeargs=(
		-DXASH_VGUI=$(usex vgui)
		-DXASH_X11=$(usex X)
		-DXASH_SDL=$(usex sdl)
		-DXASH_DEDICATED=$(usex dedicated)
		-DXASH_DLL_LOADER=$(usex dll-loader)
		-DXASH_GLES=$(usex gles-fixes)
		-DNANOGL=$(usex gles)
		-DXASH_STATIC=$(usex static)
		"${mycmakeparams[@]}"
	)
	cmake-utils_src_configure
}
