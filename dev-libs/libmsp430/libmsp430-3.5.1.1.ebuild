
EAPI=5

inherit autotools eutils

SLOT="0"
SRC_URI="http://www.ti.com/lit/sw/slac460o/slac460o.zip"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}"

src_prepare() {
	cd "${S}"

	sed 's/include <hidapi.h>/include <hidapi\/hidapi.h>/g' -i \
	    ThirdParty/BSL430_DLL/BSL430_DLL/Physical_Interfaces/MSPBSL_PhysicalInterfaceUSB.h \
	    DLL430_v3/src/TI/DLL430/HidUpdateManager.cpp || die
	
	sed 's/ThirdParty\/lib\/hid\-libusb.o/-lhidapi-libusb -lhidapi-hidraw/g' -i Makefile || die
	
	sed 's/HIDOBJ :=.*/HIDOBJ := /g' -i  Makefile || die
	
	epatch "${FILESDIR}/gcc5.patch"
}

src_install() {
	cd "${S}"
	
	dolib "libmsp430.so"
}
