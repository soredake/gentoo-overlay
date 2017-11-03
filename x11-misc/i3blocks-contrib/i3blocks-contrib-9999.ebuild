# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Community contributed blocklets for i3blocks"
HOMEPAGE="https://github.com/vivien/i3blocks-contrib"
EGIT_REPO_URI="https://github.com/vivien/i3blocks-contrib"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="x11-misc/i3blocks"

DEPEND="${RDEPEND}"

src_install() {
	insinto /usr/share/${PN}
	doins -r .
	#toexe=( "$(grep -Irnw "${D}" -e '#!' | sed 's/:.*//g')" )
	#for e in ${toexe[@]}; do chmod +x "${e}"; done
	while read -r -d '' path; do
		[[ $(head -n1 "${path}") == \#\!* ]] || continue
		chmod +x "${path}" || die #614094
	done < <(find "${ED}" -type f -print0)
}
