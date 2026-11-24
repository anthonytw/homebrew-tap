# Homebrew formula template for the `sempere` CLI.
#
# Lives in the tap repository anthonytw/homebrew-tap as Formula/sempere.rb.
# packaging/homebrew/README.md explains how to fill in VERSION and the checksums
# from a release's SHA256SUMS (or run scripts/update-formula.sh).
class Sempere < Formula
  desc "Keys, verification, export and recovery for Sempere encrypted handwriting vaults"
  homepage "https://github.com/anthonytw/sempere"
  license "GPL-3.0-or-later"

  # Literal versions in the URLs: brew audit refuses a `version` it can scan from them.
  on_macos do
    # One universal (arm64 + x86_64) binary for both. `brew style` allows url/sha256 only
    # inside on_arm/on_intel, not directly in on_macos.
    on_arm do
      url "https://github.com/anthonytw/sempere/releases/download/v1.3.0/sempere-1.3.0-macos-universal.tar.gz"
      sha256 "1682947b88328d7f42326bc3cc32f15e7a2b2f8fcdc10c1000c469bf87c473af"
    end
    on_intel do
      url "https://github.com/anthonytw/sempere/releases/download/v1.3.0/sempere-1.3.0-macos-universal.tar.gz"
      sha256 "1682947b88328d7f42326bc3cc32f15e7a2b2f8fcdc10c1000c469bf87c473af"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/anthonytw/sempere/releases/download/v1.3.0/sempere-1.3.0-linux-aarch64.tar.gz"
      sha256 "78608116954ac91383e6b1427744085a684ab1ae49a302b99ab8e927ce578949"
    end
    on_intel do
      url "https://github.com/anthonytw/sempere/releases/download/v1.3.0/sempere-1.3.0-linux-x86_64.tar.gz"
      sha256 "18587f08da7609da33e232b0b1a0ce8723e2afed3bb79037bf1aae432e946853"
    end
  end

  def install
    bin.install "sempere"
    # Fonts for text in exports (Noto, OFL 1.1); found at ../share/sempere/fonts from the binary.
    (share/"sempere/fonts").install Dir["fonts/*"]
    doc.install "README.md", "CHANGELOG.md", "LICENSE-EXCEPTION", "docs/cli.md"
  end

  test do
    assert_equal "sempere #{version}", shell_output("#{bin}/sempere --version").lines.first.strip
    assert_match "ABSOLUTELY NO WARRANTY", shell_output("#{bin}/sempere --version")
    # A fresh identity is an age secret key.
    assert_match "AGE-SECRET-KEY-", shell_output("#{bin}/sempere keys generate")
  end
end
