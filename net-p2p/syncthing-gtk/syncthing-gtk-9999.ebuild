# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit eutils distutils-r1 git-r3

DESCRIPTION="GTK3 & python based GUI for Syncthing"
HOMEPAGE="https://github.com/syncthing/syncthing-gtk"
EGIT_REPO_URI="https://github.com/syncthing/syncthing-gtk.git"
LICENSE="GPL-2"
SLOT="0"
IUSE="inotify libnotify"
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
	libnotify? ( x11-libs/libnotify )"

pkg_postinst() {
	optfeature "For caja support" dev-python/python-caja[${PYTHON_USEDEP}]
	optfeature "For nautilus support" dev-python/nautilus-python[${PYTHON_USEDEP}]
}
