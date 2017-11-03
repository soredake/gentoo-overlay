# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils cargo git-r3

DESCRIPTION="A cross-platform, GPU-accelerated terminal emulator"
HOMEPAGE="https://github.com/jwilm/alacritty"
EGIT_REPO_URI="https://github.com/jwilm/alacritty"

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="media-libs/freetype
	media-libs/fontconfig"
RDEPEND="x11-misc/xclip
	${DEPEND}"

src_install() {
	default

	domenu Alacritty.desktop
	insinto /usr/share/alacritty
	doins alacritty.yml
}
