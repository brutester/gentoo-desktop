# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit linux-info toolchain-funcs cmake-multilib

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/IntelRealSense/${PN}.git"
else
	SRC_URI="https://github.com/IntelRealSense/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Intel's RealSense 3D Camera API"
HOMEPAGE="https://github.com/IntelRealSense/librealsense"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="+examples"

RDEPEND="
	virtual/libusb:1
	examples? ( =media-libs/glfw-3* )
"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers
	virtual/pkgconfig
"

CONFIG_CHECK="USB_VIDEO_CLASS"
ERROR_USB_VIDEO_CLASS="librealsense requires CONFIG_USB_VIDEO_CLASS enabled."

DOCS=( AUTHORS CLA.md CONTRIBUTING.md readme.md )

pkg_pretend() {
	kernel_is ge 4 4 || die "Upstream has deprecated support for kernels < 4.4."

	if tc-is-gcc && [[ gcc-version < 4.9 ]]; then
		die "Upstream requires at least GCC-4.9"
	fi
}

src_prepare() {
	sed 's/^.*COMMAND ldconfig.*$//g' -i CMakeLists.txt
	cmake-utils_src_prepare
}
