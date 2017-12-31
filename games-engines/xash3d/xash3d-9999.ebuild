# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="Xash3D Engine is a custom Gold Source engine rewritten from scratch"
HOMEPAGE="https://xash.su/"

EGIT_REPO_URI="https://github.com/FWGS/xash3d"

LICENSE="GPL-3"
SLOT="0"
IUSE="+X +sdl dedicated +dll-loader static gles gles-fixes +vgui force-64bit"
EGIT_SUBMODULES=( mainui )
EGIT_BRANCH=0.19.x

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
	vgui? ( !force-64bit )
	dll-loader? ( !force-64bit )"

src_unpack() {
	git-r3_src_unpack
	git-r3_fetch https://github.com/FWGS/halflife HEAD
	git-r3_checkout https://github.com/FWGS/halflife "${S}/hlsdk"
	if use gles; then
		git-r3_fetch https://github.com/FWGS/nanogl HEAD
		git-r3_checkout https://github.com/FWGS/nanogl "${S}/nanogl"
	fi
}

src_prepare() {
	cmake-utils_src_prepare
	sed -i 's/lib32/lib/' xash3d.sh
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
		mycmakeparams+=( -DLIB_SUFFIX="" )
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
		-DHL_SDK_DIR="${S}/hlsdk"
		"${mycmakeparams[@]}"
	)
	cmake-utils_src_configure
}
