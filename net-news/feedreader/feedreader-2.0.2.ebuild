# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils gnome2 vala

DESCRIPTION="A simple feedreader client for web services like Tiny Tiny RSS and in the future others"
HOMEPAGE="https://jangernert.github.io/FeedReader/"
SRC_URI="https://github.com/jangernert/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+gnome"

RDEPEND="$(vala_depend)
	app-crypt/libsecret[vala(+)]
	app-text/html2text
	dev-db/sqlite:3
	dev-libs/gobject-introspection
	dev-libs/json-glib
	dev-libs/libgee:0.8
	dev-libs/libpeas
	dev-libs/libxml2
	gnome? ( gnome-base/gnome-keyring )
	media-libs/gst-plugins-base:1.0
	media-libs/gstreamer:1.0
	net-libs/gnome-online-accounts
	net-libs/libsoup:2.4
	net-libs/rest:0.7
	x11-libs/libnotify
	net-libs/webkit-gtk:4
	net-misc/curl
	x11-libs/gtk+:3
	x11-libs/libnotify"

DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

S="${WORKDIR}/FeedReader-${PV}"

src_prepare() {
	vala_src_prepare
	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DWITH_LIBUNITY=OFF
		-DVALA_EXECUTABLE="${VALAC}"
		-DGSETTINGS_LOCALINSTALL=OFF
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}

pkg_preinst() {
	gnome2_pkg_preinst
}

pkg_postinst() {
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}
