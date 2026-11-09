# The Homebrew formula of fil, for the tap anthonytw/homebrew-tap (`brew install anthonytw/tap/fil`).
# GENERATED from packaging/homebrew/fil.rb.in by `just brew-formula VERSION` (packaging/render.sh),
# with the checksums of the release's signed SHA256SUMS; do not edit it in the tap by hand.
# docs/m4/packaging.md says how a release reaches the tap.
class Fil < Formula
  desc "Remote shell for development over SSH that keeps your place"
  homepage "https://github.com/anthonytw/fil"
  # macOS: the universal archive. (Homebrew does not allow url in on_macos; Linux overrides it.)
  url "https://github.com/anthonytw/fil/releases/download/v0.1.0/fil-0.1.0-universal-apple-darwin.tar.gz"
  sha256 "7103808e9e3b4067090542f6b00daddbad5fc413ef477849462939a706dc8edb"
  license "GPL-3.0-or-later"

  on_linux do
    on_intel do
      url "https://github.com/anthonytw/fil/releases/download/v0.1.0/fil-0.1.0-x86_64-linux-musl.tar.gz"
      sha256 "646ad47cd0df3e6526b7140b37b971b3895f0ab760c4097d9e6f4ccb212fca88"
    end
    on_arm do
      url "https://github.com/anthonytw/fil/releases/download/v0.1.0/fil-0.1.0-aarch64-linux-musl.tar.gz"
      sha256 "25ab46e63f0bbf2108eec5531358981c886c7c8631dadcaa44996d23fbb695f3"
    end
  end

  def install
    bin.install "bin/fil"
    # The remote bundle that `fil install` uploads; the client finds it at ../libexec/fil/remote
    # from its own canonical path, which in the Cellar is prefix/libexec/fil/remote.
    libexec.install "libexec/fil"
    # Man pages and completions arrive with DOC; until the archive has them, install nothing
    # (Homebrew warns about installing an empty list).
    pages = Dir["share/man/man1/*.1"]
    man1.install pages unless pages.empty?
    pages = Dir["share/man/man5/*.5"]
    man5.install pages unless pages.empty?
    {
      bash_completion => "share/bash-completion/completions/fil",
      zsh_completion  => "share/zsh/site-functions/_fil",
      fish_completion => "share/fish/vendor_completions.d/fil.fish",
    }.each do |dir, file|
      dir.install file if File.exist?(file)
    end
    docs = Dir["share/doc/fil/*"]
    doc.install docs unless docs.empty?
  end

  def caveats
    <<~EOS
      fil also has to be on the remote hosts you use it with: `fil install HOST` uploads it,
      or copy a release's bin/fil there yourself (`fil install --help`).
    EOS
  end

  test do
    assert_match "fil #{version} (wire ", shell_output("#{bin}/fil --version")
    # The bundle is where the client looks for it, and every file of its SHA256SUMS checks (Ruby's
    # own digest: Homebrew on Linux need not have shasum).
    require "digest"
    remote = libexec/"fil/remote"
    (remote/"SHA256SUMS").read.each_line do |line|
      sum, name = line.chomp.split("  ", 2)
      assert_equal sum, Digest::SHA256.file(remote/name).hexdigest
    end
  end
end
