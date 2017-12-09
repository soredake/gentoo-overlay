# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 gnome2-utils xdg-utils

DESCRIPTION="A GTK2 image viewer, manga reader, and booru browser"
HOMEPAGE="https://github.com/ahodesuka/ahoviewer"
EGIT_REPO_URI="https://github.com/ahodesuka/ahoviewer.git"

LICENSE="MIT"
SLOT="0"
IUSE="+gstreamer +libsecret +rar +zip ssl libressl openssl gnutls"
REQUIRED_USE="ssl? ( ?? ( libressl openssl gnutls ) )"

DEPEND="dev-cpp/glibmm
	dev-cpp/gtkmm:2.4
	dev-libs/libconfig
	dev-libs/libsigc++:2
	net-misc/curl
	openssl? ( net-misc/curl[curl_ssl_openssl] )
	libressl? ( net-misc/curl[curl_ssl_libressl] )
	gnutls? ( net-misc/curl[curl_ssl_gnutls] )
	dev-libs/libxml2
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-bad[opengl]
	)
	libsecret? ( app-crypt/libsecret )
	rar? ( app-arch/unrar )
	zip? ( dev-libs/libzip )"
RDEPEND="${DEPEND}
	gstreamer? (
		media-libs/gst-plugins-good
		|| (
			media-plugins/gst-plugins-vpx
			media-plugins/gst-plugins-libav
		)
	)
"

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	if use openssl; then
		ssl=openssl
	else
		ssl=libressl
	fi
	econf \
		$(use_enable $ssl ssl) \
		$(use_enable gnutls ssl) \
		$(use_enable gstreamer gst) \
		$(use_enable libsecret) \
		$(use_enable rar) \
		$(use_enable zip)
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
