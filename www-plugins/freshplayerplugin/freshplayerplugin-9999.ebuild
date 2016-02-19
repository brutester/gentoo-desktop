
EAPI=5
SLOT=0

inherit git-2 cmake-utils

EGIT_REPO_URI="https://github.com/i-rinat/freshplayerplugin.git"

KEYWORDS="~x86 ~amd64"

DEPEND="dev-libs/libconfig
	dev-libs/uriparser
	www-client/google-chrome
	x11-libs/pango
	x11-libs/libXinerama
	dev-libs/libevent
	media-libs/mesa[egl,gles2]
	"

src_install() {
	cd "${S}"
	insinto /etc
	newins data/freshwrapper.conf.example freshwrapper.conf
	cd "${WORKDIR}/${P}_build"
	insinto /usr/lib64/nsbrowser/plugins/
	doins libfreshwrapper-flashplayer.so
}
