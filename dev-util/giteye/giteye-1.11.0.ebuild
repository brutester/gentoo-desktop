# Copyright open-overlay 2015 by Alex

EAPI=5
inherit eutils versionator

SLOT="0"
RDEPEND=">=virtual/jdk-1.7"

MY_PN="GitEye"

DESCRIPTION="GitEye combines a simple-to-use graphical Git client with central visibility into essential developer tasks such as defect tracking, Agile planning, code reviews and build services."
HOMEPAGE="http://www.collab.net/downloads/giteye"
SRC_URI="https://downloads-guests.open.collab.net/files/documents/61/11867/${MY_PN}-${PV}-linux.x86_64.zip"
LICENSE="Apache-2.0"
IUSE=""
KEYWORDS="~amd64"
S="${WORKDIR}/"

src_install() {
	local dir="/opt/${PN}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/GitEye"

	newicon "icon.xpm" "${PN}.png"
	make_wrapper ${PN} "${dir}/GitEye"
	make_desktop_entry ${PN} "GitEye" ${PN} "Development;IDE"
}
