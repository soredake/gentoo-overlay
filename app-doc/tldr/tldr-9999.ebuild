# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit bash-completion-r1 git-r3

DESCRIPTION="Command line client tldr in C"
HOMEPAGE="https://github.com/tldr-pages/tldr-cpp-client"
EGIT_REPO_URI="https://github.com/tldr-pages/tldr-cpp-client.git"

LICENSE="MIT"
SLOT="0"
IUSE="zsh-completion"

CDEPEND="net-misc/curl
	dev-libs/libzip"
DEPEND="${CDEPEND}
	virtual/pkgconfig"
RDEPEND="${CDEPEND}"

src_prepare() {
	default
	sed -i -e "s|/usr/local|${ED}/usr|g" Makefile || die
}

src_install() {
	default
	newbashcomp autocomplete/complete.bash tldr

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		newins autocomplete/complete.zsh tldr
	fi

	insinto /usr/share/fish/completions
	newins autocomplete/complete.fish tldr
}
