# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Lightweight audio filtering library made from webrtc code."
HOMEPAGE="https://github.com/irungentoo/filter_audio"
EGIT_REPO_URI="https://github.com/irungentoo/filter_audio.git"

LICENSE="BSD"
SLOT="0"

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" LIBDIR="$(get_libdir)" install
}
