# Maintainer: Mohit Nikhare

pkgname=maintain-btrfs
pkgver=1.0.0
pkgrel=1
pkgdesc="A simple Arch Linux maintenance utility for Btrfs systems"
arch=('any')
url="https://github.com/YOUR_USERNAME/maintain-btrfs"
license=('MIT')

depends=('bash' 'pacman')
optdepends=(
    'snapper: Snapshot cleanup support'
    'timeshift: Snapshot cleanup support'
    'pacman-contrib: Use paccache for package cache cleanup'
    'btrfs-progs: Btrfs balance and scrub support'
)

source=("maintain-btrfs")
sha256sums=('SKIP')

package() {
    install -Dm755 maintain-btrfs "$pkgdir/usr/bin/maintain-btrfs"
}
