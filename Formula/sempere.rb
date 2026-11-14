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
      url "https://github.com/anthonytw/sempere/releases/download/v1.1.0/sempere-1.1.0-macos-universal.tar.gz"
      sha256 "c0099b21db67ece5ca2cfb3e50040c470de7b953f9c142d4e7631b42712de6a7"
    end
    on_intel do
      url "https://github.com/anthonytw/sempere/releases/download/v1.1.0/sempere-1.1.0-macos-universal.tar.gz"
      sha256 "c0099b21db67ece5ca2cfb3e50040c470de7b953f9c142d4e7631b42712de6a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/anthonytw/sempere/releases/download/v1.1.0/sempere-1.1.0-linux-aarch64.tar.gz"
      sha256 "614ac576c3e0d5482218bca66e32ccbee336a7a45423913b077bae6282751763"
    end
    on_intel do
      url "https://github.com/anthonytw/sempere/releases/download/v1.1.0/sempere-1.1.0-linux-x86_64.tar.gz"
      sha256 "8989aed5900a7556ee47fadaed8261240ab47d41dc9bd5b374f7a8f93f5682ec"
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
