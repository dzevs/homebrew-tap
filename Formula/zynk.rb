# typed: false
# frozen_string_literal: true

# Homebrew formula for zynk — a binary (prebuilt) formula that downloads the v3.0.0 GitHub Release
# assets and installs the binary (no Rust/Zig build). Install: `brew install dzevs/tap/zynk`.
class Zynk < Formula
  desc "Terminal-native command center for AI agents"
  homepage "https://github.com/dzevs/zynk"
  version "3.0.0"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/dzevs/zynk/releases/download/v3.0.0/zynk-v3.0.0-macos-aarch64.tar.gz"
      sha256 "b9c1c04dbd00aad0d603ff944f9c785bff969841d7318f04d61870fd811137ea"
    end
    on_intel do
      url "https://github.com/dzevs/zynk/releases/download/v3.0.0/zynk-v3.0.0-macos-x86_64.tar.gz"
      sha256 "a7b723163a39f239ab7329679b2276195f16d7652fee333b530440ef1fea085c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/dzevs/zynk/releases/download/v3.0.0/zynk-v3.0.0-linux-aarch64.tar.gz"
      sha256 "57c5ca4e38893a0c84cf7a2c647cf7e82c74e96245bacdf8de7fb1d79bb709bc"
    end
    on_intel do
      url "https://github.com/dzevs/zynk/releases/download/v3.0.0/zynk-v3.0.0-linux-x86_64.tar.gz"
      sha256 "599aaabde8ddbf1f2273798deb3169cfc31521b978762321bddbe190aaa2ada8"
    end
  end

  def install
    bin.install "zynk"
  end

  def caveats
    lines = ["zynk's prebuilt binaries are not code-signed or notarized."]
    if OS.mac?
      lines << "Homebrew installs into its Cellar (tar extraction drops the download quarantine), so"
      lines << "zynk should run without a Gatekeeper prompt. If macOS still blocks it on first run:"
      lines << "  xattr -dr com.apple.quarantine #{opt_bin}/zynk"
    end
    if OS.linux?
      lines << "These Linux binaries are glibc-dynamic and require glibc >= 2.30."
    end
    lines << "Self-update is not wired yet; upgrade with `brew upgrade zynk`."
    lines.join("\n")
  end

  test do
    assert_match "zynk #{version}", shell_output("#{bin}/zynk --version")
  end
end
