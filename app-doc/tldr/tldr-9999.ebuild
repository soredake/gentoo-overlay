# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit bash-completion-r1 git-r3

DESCRIPTION="Command line client tldr in C"
HOMEPAGE="https://github.com/tldr-pages/tldr-cpp-client"
EGIT_REPO_URI="https://github.com/tldr-pages/tldr-cpp-client.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="zsh-completion"

DEPEND="
	net-misc/curl
	dev-libs/libzip
	virtual/pkgconfig
"
RDEPEND="
	${DEPEND}
"

src_install() {
	default
	dobin tldr
	doman man/tldr.1
	newbashcomp autocomplete/complete.bash tldr

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		newins autocomplete/complete.zsh tldr
	fi

	insinto /usr/share/fish/completions
	newins autocomplete/complete.fish tldr
}
