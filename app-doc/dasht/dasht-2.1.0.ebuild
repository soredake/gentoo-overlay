# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="API documentation in your terminal"
HOMEPAGE="https://github.com/sunaku/dasht"
SRC_URI="https://github.com/sunaku/dasht/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"
IUSE="zsh-completion"

RDEPEND="app-shells/bash:0
	 dev-db/sqlite
	 net-misc/wget
	 www-client/w3m
	 net-misc/socat"

DEPEND="${RDEPEND}"

src_install() {
	dobin bin/*
	doman man/man1/*

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins etc/zsh/completions/*
	fi
}
