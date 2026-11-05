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
      url "https://github.com/anthonytw/sempere/releases/download/v1.0.0/sempere-1.0.0-macos-universal.tar.gz"
      sha256 "3d584844ff8275b274b76a23dd16db6afb582f80cbdd770ea22b2a3dccf9b532"
    end
    on_intel do
      url "https://github.com/anthonytw/sempere/releases/download/v1.0.0/sempere-1.0.0-macos-universal.tar.gz"
      sha256 "3d584844ff8275b274b76a23dd16db6afb582f80cbdd770ea22b2a3dccf9b532"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/anthonytw/sempere/releases/download/v1.0.0/sempere-1.0.0-linux-aarch64.tar.gz"
      sha256 "b313f26b4c83162c8445b955d691596ca8935c6498813b67e154b9bffc5005cc"
    end
    on_intel do
      url "https://github.com/anthonytw/sempere/releases/download/v1.0.0/sempere-1.0.0-linux-x86_64.tar.gz"
      sha256 "c10a76022326469b6f292e583cc942b001ba460eacda79b98cbdf1137c07f9a2"
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
