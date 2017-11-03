# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )
inherit eutils distutils-r1

DESCRIPTION="GTK3 & python based GUI for Syncthing"
HOMEPAGE="https://github.com/syncthing/syncthing-gtk"
SRC_URI="https://github.com/syncthing/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="inotify libnotify nautilus caja"
RESTRICT="mirror"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/pygobject[cairo,${PYTHON_USEDEP}]
	dev-python/python-dateutil[$(python_gen_usedep 'python2*')]
	sys-process/psmisc
	gnome-base/librsvg[introspection]
	dev-python/bcrypt[${PYTHON_USEDEP}]
	x11-libs/gtk+:3
	net-p2p/syncthing
	inotify? ( dev-python/pyinotify[${PYTHON_USEDEP}] )
	libnotify? ( x11-libs/libnotify )
	nautilus? ( dev-python/nautilus-python[${PYTHON_USEDEP}] )
	caja? ( dev-python/python-caja[${PYTHON_USEDEP}] )"
