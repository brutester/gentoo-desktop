
EAPI=5

inherit autotools

SLOT="0"
SRC_URI="http://www.ti.com/lit/sw/slac460k/slac460k.zip"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}/MSPDebugStack_OS_Package"

src_prepare() {
	cd "${S}"

	sed 's/include <hidapi.h>/include <hidapi\/hidapi.h>/g' -i \
	    ThirdParty/BSL430_DLL/BSL430_DLL/Physical_Interfaces/MSPBSL_PhysicalInterfaceUSB.h \
	    DLL430_v3/src/TI/DLL430/HidUpdateManager.cpp || die
	
	sed 's/ThirdParty\/lib\/hid\-libusb.o/-lhidapi-libusb -lhidapi-hidraw/g' -i Makefile || die
	
	mkdir "ThirdParty/lib"
	
}

src_install() {
	cd "${S}"
	
	dolib "libmsp430.so"
}
