# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils systemd flag-o-matic

DESCRIPTION="BitTorrent Client using libtorrent"
HOMEPAGE="https://rakshasa.github.io/rtorrent/"
SRC_URI="
	http://rtorrent.net/downloads/${P}.tar.gz
	ps? (
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/command_pyroscope.cc
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ps-event-view_all.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ps-fix-double-slash-319_all.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ps-fix-sort-started-stopped-views_all.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ps-fix-throttle-args_all.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ps-handle-sighup-578_all.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ps-info-pane-xb-sizes_all.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ps-issue-515_all.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ps-item-stats-human-sizes_all.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ps-ssl_verify_host_all.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ps-throttle-steps_all.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ps-ui_pyroscope_all.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ps-view-filter-by_all.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/pyroscope.patch
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ui_pyroscope.cc
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ui_pyroscope.h
		https://raw.githubusercontent.com/pyroscope/rtorrent-ps/master/patches/ui_pyroscope.patch
	)
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris"
IUSE="daemon debug ipv6 selinux test xmlrpc +ps"

COMMON_DEPEND="~net-libs/libtorrent-0.13.${PV##*.}[ps?]
	dev-libs/libsigc++:2
	net-misc/curl
	sys-libs/ncurses:0=
	xmlrpc? ( dev-libs/xmlrpc-c )"
RDEPEND="${COMMON_DEPEND}
	daemon? ( app-misc/screen )
	selinux? ( sec-policy/selinux-rtorrent )
"
DEPEND="${COMMON_DEPEND}
	dev-util/cppunit
	virtual/pkgconfig"

DOCS=( doc/rtorrent.rc )

# bug #358271
PATCHES=(
	"${FILESDIR}"/${PN}-0.9.1-ncurses.patch
	"${FILESDIR}"/${PN}-0.9.4-tinfo.patch
	"${FILESDIR}"/${PN}-0.9.6-cppunit-pkgconfig.patch
)

src_prepare() {
	default
	# https://github.com/rakshasa/rtorrent/issues/332
	cp "${FILESDIR}"/rtorrent.1 "${S}"/doc/ || die

	if use ps ; then
		list=(
			"${DISTDIR}"/ps-event-view_all.patch
			"${DISTDIR}"/ps-fix-double-slash-319_all.patch
			"${DISTDIR}"/ps-fix-sort-started-stopped-views_all.patch
			"${DISTDIR}"/ps-handle-sighup-578_all.patch
			"${DISTDIR}"/ps-info-pane-xb-sizes_all.patch
			"${DISTDIR}"/ps-issue-515_all.patch
			"${DISTDIR}"/ps-item-stats-human-sizes_all.patch
			"${DISTDIR}"/ps-ssl_verify_host_all.patch
			"${DISTDIR}"/ps-throttle-steps_all.patch
			"${DISTDIR}"/ps-ui_pyroscope_all.patch
			"${DISTDIR}"/ps-view-filter-by_all.patch
			"${DISTDIR}"/pyroscope.patch
			"${DISTDIR}"/ui_pyroscope.patch
		)
		eapply "${list[@]}"
		# copy pyroscope stuff
		cp "${DISTDIR}"/*.{cc,h} "${S}"/src/ || die
		# TODO: remove when https://github.com/pyroscope/rtorrent-ps/issues/54 is done
		sed -i -e '30,32d' -e '358,360d' -e '362d' "${S}"/src/command_pyroscope.cc

		append-cxxflags -std=c++11
	fi

	eautoreconf
}

src_configure() {
	# configure needs bash or script bombs out on some null shift, bug #291229
	CONFIG_SHELL=${BASH} econf \
		--disable-dependency-tracking \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_with xmlrpc xmlrpc-c)
}

src_install() {
	default
	doman doc/rtorrent.1

	if use daemon; then
		newinitd "${FILESDIR}/rtorrentd.init" rtorrentd
		newconfd "${FILESDIR}/rtorrentd.conf" rtorrentd
		systemd_newunit "${FILESDIR}/rtorrentd_at.service" "rtorrentd@.service"
	fi
}
