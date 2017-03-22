# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit toolchain-funcs cmake-utils

MY_PN="realsense_sdk"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/IntelRealSense/${MY_PN}.git"
else
	SRC_URI="https://github.com/IntelRealSense/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Intel's RealSense SDK for Linux"
HOMEPAGE="https://github.com/IntelRealSense/realsense_sdk"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND="
"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers
	virtual/pkgconfig
	media-libs/opencv
	media-libs/librealsense
"

src_prepare() {
    for path in samples/ sdk/ tests/
    do
        sed 's/\-D_FORTIFY_SOURCE=2 //g' -i $path/CMakeLists.txt
    done
    cmake-utils_src_prepare
}

