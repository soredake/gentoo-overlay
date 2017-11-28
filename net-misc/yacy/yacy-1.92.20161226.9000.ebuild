# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils java-pkg-2 java-ant-2 systemd user versionator
MAJOR_PV="$(get_version_component_range 1-2)"
REL_PV="$(get_version_component_range 3)"
SVN_PV="$(get_version_component_range 4)"

DESCRIPTION="YaCy - p2p based distributed web-search engine"
HOMEPAGE="https://yacy.net/en/index.html"
SRC_URI="https://github.com/yacy/yacy_search_server/archive/Release_1.90.tar.gz"
SRC_URI="https://www.yacy.net/release/yacy_v${MAJOR_PV}_${REL_PV}_${SVN_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

DEPEND=">=virtual/jdk:1.8"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

EANT_BUILD_TARGET="all"

pkg_setup() {
	enewgroup yacy
	enewuser yacy -1 -1 /var/lib/yacy yacy
}

src_install() {
	# remove win-only stuff
	find "${S}" -name "*.bat" -delete || die
	#find "${S}" -name "*.bat" -exec rm '{}' \; || die
	# remove sources
	rm -r "${S}/source" || die
	rm "${S}/build.properties" "${S}/build.xml"
	rm -r "${S}/addon/YaCy.app" || die
	rm -r "${S}/addon/installer" || die
	rm -r "${S}/addon/Notepad++" || die

	dodoc AUTHORS COPYRIGHT NOTICE gpl.txt readme.txt

	yacy_home="/usr/share/${PN}"
	dodir ${yacy_home}
	cp -r "${S}/*" "${D}${yacy_home}" || die

	rm "${D}${yacy_home}/{AUTHORS,COPYRIGHT,NOTICE,gpl.txt,readme.txt}"
	rm -r "${D}${yacy_home}/lib/*License"

	dodir /var/log/yacy
	chown yacy:yacy "${D}/var/log/yacy" || die

	dosym ../../../var/lib/yacy /${yacy_home}/DATA

	if use systemd ; then
		systemd_newunit "${FILESDIR}"/${PN}-ipv6.service ${PN}-ipv6.service
		systemd_newunit "${FILESDIR}"/${PN}.service ${PN}.service
	fi
}

pkg_postinst() {
	einfo "yacy.logging will write logfiles into /var/lib/yacy/LOG"
	einfo "To setup YaCy, open http://localhost:8090 in your browser."
}
