# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3 mono-env gnome2-utils xdg-utils

DESCRIPTION="osu! - Rhythm is just a *click* away!"
HOMEPAGE="https://osu.ppy.sh/"
EGIT_REPO_URI="https://github.com/ppy/osu.git"
SRC_URI="!system-nuget? ( https://dist.nuget.org/win-x86-commandline/v4.6.0/nuget.exe )
	https://aur.archlinux.org/cgit/aur.git/plain/osu-lazer.png?h=osu-lazer-git -> ${PN}.png
	https://aur.archlinux.org/cgit/aur.git/plain/x-osu-lazer.xml?h=osu-lazer-git -> x-${PN}.xml"

LICENSE="MIT"
SLOT="0"
IUSE="debug msbuild system-nuget"

RDEPEND="media-video/ffmpeg
	>=dev-lang/mono-5.9.0.398
	virtual/opengl"
DEPEND="${RDEPEND}
	msbuild? ( dev-util/msbuild )
	system-nuget? ( dev-dotnet/nuget )"

pkg_setup() {
	has network-sandbox $FEATURES && \
		die "games-action/osu requires 'network-sandbox' to be disabled in FEATURES"
	mono-env_pkg_setup
}

src_prepare() {
	mono "${DISTDIR}/nuget.exe" restore
	mkdir -p "osu.Game/bin/Release"
	ln -s "/usr/lib/mono/4.5/Facades/netstandard.dll" "osu.Game/bin/Release"
	mkdir -p "osu.Desktop/bin/Release"
	ln -s "/usr/lib/mono/4.5/Facades/netstandard.dll" "osu.Desktop/bin/Release"
	echo '<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <add key="OpenTK" value="https://dotnet.myget.org/F/aspnetcore-ci-dev/api/v3/index.json" />
    <add key="opentk-develop" value="https://www.myget.org/F/opentk-develop" />
  </packageSources>
</configuration>
' > NuGet.config
	eapply_user
}

src_compile() {
	export MONO_IOMAP="case"
	if use msbuild; then
		msbuild
	else
		xbuild /property:Configuration=Release
	fi
	# Cleanup
	rm "osu.Game/bin/Release/netstandard.dll"
	rm "osu.Desktop/bin/Release/netstandard.dll"
}

src_install() {
	make_wrapper "osu" 'mono osu!.exe' /usr/$(get_libdir)/osu
	make_desktop_entry 'mono osu!.exe' "osu!lazer" "${PN}" \
		"Game;" "Path=/usr/$(get_libdir)/osu\nTerminal=false"

	# MIME types
	insinto /usr/share/mime/packages
	doins "${DISTDIR}/x-${PN}.xml"

	# Application icon
	doicon -s 256 "${DISTDIR}/${PN}.png"

	# Compiled binaries
	cd "${S}/osu.Desktop/bin/Release"
	insinto /usr/$(get_libdir)/${PN}
	for binary in *.exe *.dll; do
		doins "$binary"
	done

	# Native libraries
	newins "libbass.x64.so" "libbass.so"
	newins "libbass_fx.x64.so" "libbass_fx.so"
	doins "libe_sqlite3.so"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
