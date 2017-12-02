# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )
PYTHON_REQ_USE="ncurses"

inherit distutils-r1 git-r3

DESCRIPTION="Cli and curses mixer for pulseaudio"
HOMEPAGE="https://github.com/GeorgeFilipkin/pulsemixer"
EGIT_REPO_URI="https://github.com/GeorgeFilipkin/pulsemixer"
LICENSE="MIT"
SLOT="0"

RDEPEND="media-sound/pulseaudio"
