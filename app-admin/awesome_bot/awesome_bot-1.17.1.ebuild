# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby22 ruby23 ruby24"
inherit ruby-fakegem

DESCRIPTION="Validate links in awesome projects"
HOMEPAGE="https://github.com/dkhamsing/awesome_bot"
SRC_URI="https://github.com/dkhamsing/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
SLOT="0"
LICENSE="MIT"
KEYWORDS="amd64"
IUSE="test"

RDEPEND="
	${RUBY_DEPS}
	dev-ruby/parallel"
# rspec_junit_formatter test dep is not yet packaged in gentoo
DEPEND="
	${RDEPEND}
	test? (
		dev-ruby/rspec
		)
"

src_install() {
	ruby-ng_src_install
	find "${D}" \( -name "assets" -o -name "console" -o -name "setup" \) -exec rm -rf {} \;
}
